# JailBase

import sys;
reload(sys);
sys.setdefaultencoding("utf8")
import os

import urllib
import urllib2
from bs4 import BeautifulSoup
import re
import random
import time
import numpy
from datetime import datetime

def write_output(string, outfile):
    localtime = time.asctime(time.localtime(time.time()))
    with open(outfile, 'a') as f:
        f.write(localtime + ' ' + string + "\n")

def get_JB(output_location, outputfile = 'JB_output.txt', failed_file = 'JB_failed.txt', failed_pics = 'JB_failed_pics.txt', \
    county_listfile = 'county_list', given_state = 'All', state_min = 0, state_max = 100, county_min = 0, county_max = 20000, \
    year_min = 0, year_max = 3000, month_min = 0, month_max = 12, no_attempts = 3, timeout_time = 10, min_pause = 0.1, max_pause = 1, \
    identifier = 0, back_to_front = False):
    
    hdrs = {'Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=1.8', 'Accept-Language':'en-us,en;q=0.5', \
    'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36'}

    county_links = []
    state_no = 0
    county_no = 0

    base_url = 'http://www.jailbase.com'
    site_url = base_url + '/en/sources/'

    original_directory = os.getcwd()
    if not os.path.exists(output_location):
        os.makedirs(output_location)
    os.chdir(output_location)
    
    req = urllib2.Request(url = site_url, headers = hdrs)
    data = urllib2.urlopen(req, timeout = timeout_time).read()
    time.sleep(random.uniform(min_pause, max_pause))
    soup = BeautifulSoup(data)

    # check if they gave a specific state to download.  get list of county links before begin downloading anything, faster
    for state_tag in soup.findAll('div', {'class':re.compile('resultLabelBox')}):
        state = str(state_tag.find('div', {'class':'stateName'}).find('a').text).strip()
        # now finding each county link
        for sibling in state_tag.find_next_siblings():
            if sibling.name == 'div' and str(sibling['class'][0]).strip() == 'resultContent':
                a_first = sibling.find('div', {'class':'first'}).find('a')
                county_name = str(a_first['href']).split('sources/')[1].split('/')[0].strip()
                county_links.append((base_url + str(a_first['href']).strip(), county_name, state, state_no, county_no))
                county_no += 1
                # checking if last county, which have already gotten above
                if sibling.name == 'div' and sibling['class'] == [u'resultContent', u'last']:
                    break
        state_no += 1

    numpy.save(county_listfile, county_links)

    # using list of county links with their states, going to each year, month, day, profile
    # creating a list of links for each profile
    if back_to_front:
        county_links = reversed(county_links)
    for county_link, county_name, state, state_number, county_number in county_links:
        # skip over this state if a specific state was given and this isn't it
        if given_state != 'All' and given_state != state:
            continue
        
        # checks for state and county numbers, which are inclusive
        if state_number >= state_min and state_number <= state_max and county_number >= county_min and county_number <= county_max:
            for attempt in range(no_attempts):
                try:
                    county_req = urllib2.Request(url = county_link, headers = hdrs)
                    county_data = urllib2.urlopen(county_req, timeout = timeout_time).read()
                    time.sleep(random.uniform(min_pause, max_pause))
                except Exception as e:
                    if attempt == no_attempts - 1:
                        write_output(', '.join([county_link, county_name, str(county_number), 'county']), failed_file)
                        write_output(', '.join([e.message, county_link]), outputfile)
                    pass
                else:
                    write_output('starting county ' + county_link + ', number ' + str(county_number), outputfile)
                    county_soup = BeautifulSoup(county_data)

                    arrest_dir = county_soup.find('h2', text = re.compile('Daily Arrest Directory'))
                    if arrest_dir is not None:
                        if arrest_dir.find_next_siblings('a') is not None:
                            for year_tag in arrest_dir.find_next_siblings('a'):
                                year_link = base_url + str(year_tag['href']).strip()
                                year = int(str(year_tag.text).strip())
                                if year >= year_min and year <= year_max:
                                    for attempt in range(no_attempts):
                                        try:
                                            year_req = urllib2.Request(url = year_link, headers = hdrs)
                                            year_data = urllib2.urlopen(year_req, timeout = timeout_time).read()
                                            time.sleep(random.uniform(min_pause, max_pause))
                                        except Exception as e:
                                            if attempt == no_attempts - 1:
                                                write_output(', '.join([year_link, county_name, str(county_number), 'year']), failed_file)
                                                write_output(', '.join([e.message, year_link]), outputfile)
                                        else:
                                            write_output('starting county-year ' + year_link, outputfile)
                                            year_soup = BeautifulSoup(year_data)
                                            recent1 = year_soup.find('h3', text = re.compile('Recent Arrests'))
                                            years_intro = recent1.parent.find_next_sibling('p')
                                            if years_intro is not None:
                                                if years_intro.find_all('a') is not None:
                                                    for month_tag in years_intro.find_all('a'):
                                                        month_link = base_url + str(month_tag['href']).strip()
                                                        month = int(str(month_tag['href']).strip().rsplit('-',1)[1].split('/')[0])
                                                        if month >= month_min and month <= month_max:
                                                            profile_dir =  os.path.join('Profiles', state, county_name, str(year), str(month))
                                                            if not os.path.exists(profile_dir):
                                                                os.makedirs(profile_dir)

                                                            pic_dir = os.path.join('Pictures', state, county_name, str(year), str(month))
                                                            if not os.path.exists(pic_dir):
                                                                os.makedirs(pic_dir)
                                                            for attempt in range(no_attempts):
                                                                try:
                                                                    month_req = urllib2.Request(url = month_link, headers = hdrs)
                                                                    month_data = urllib2.urlopen(month_req, timeout = timeout_time).read()
                                                                    time.sleep(random.uniform(min_pause, max_pause))
                                                                except Exception as e:
                                                                    if attempt == no_attempts - 1:
                                                                        write_output(', '.join([month_link, county_name, str(county_number), 'month']), failed_file)
                                                                        write_output(', '.join([e.message, month_link]), outputfile)
                                                                else:
                                                                    write_output('starting month ' + month_link, outputfile)
                                                                    month_soup = BeautifulSoup(month_data)

                                                                    recent2 = month_soup.find('h3', text = re.compile('Recent Arrests'))
                                                                    days_intro = recent2.parent.find_next_sibling('p')
                                                                    if days_intro is not None:
                                                                        if days_intro.find_all('a') is not None:
                                                                            for day_tag in days_intro.find_all('a'):
                                                                                day_link = base_url + str(day_tag['href']).strip()
                                                                                for attempt in range(no_attempts):
                                                                                    try:
                                                                                        day_req = urllib2.Request(url = day_link, headers = hdrs)
                                                                                        day_data = urllib2.urlopen(day_req, timeout = timeout_time).read()
                                                                                        time.sleep(random.uniform(min_pause, max_pause))
                                                                                    except Exception as e:
                                                                                        if attempt == no_attempts - 1:
                                                                                            write_output(', '.join([day_link, county_name, str(county_number), 'day']), failed_file)
                                                                                            write_output(', '.join([e.message, day_link]), outputfile)
                                                                                    else:
                                                                                        day_soup = BeautifulSoup(day_data)
                                                                                        for profile_div in day_soup.findAll('div', {'class':re.compile('thumb2')}):
                                                                                            profile_link = base_url + str(profile_div.find('a')['href']).strip()
                                                                                            for attempt in range(no_attempts):
                                                                                                try:
                                                                                                    profile_req = urllib2.Request(url = profile_link, headers = hdrs)
                                                                                                    profile_data = urllib2.urlopen(profile_req, timeout = timeout_time).read()
                                                                                                    time.sleep(random.uniform(min_pause, max_pause))
                                                                                                except Exception as e:
                                                                                                    if attempt == no_attempts - 1:
                                                                                                        identifier += 1
                                                                                                        write_output(', '.join([profile_link, str(identifier), county_name, str(county_number), 'profile']), failed_file)
                                                                                                        write_output(', '.join([e.message, profile_link, str(identifier)]), outputfile)
                                                                                                else:
                                                                                                    profile_filename = os.path.join(profile_dir, str(identifier) + '.html')
                                                                                                    pic_filename = os.path.join(pic_dir, str(identifier) + '.jpg')
                                                                                                    identifier += 1
                                                                                                    profile_soup = BeautifulSoup(profile_data)
                                                                                                    
                                                                                                    # might want to add a try statement with except(IOError)
                                                                                                    with open(profile_filename, 'w') as f:
                                                                                                        f.write(profile_soup.prettify())
                                                                                                    pic_tag = profile_soup.find('div', {'class':'profileThumb'})
                                                                                                    for attempt in range(no_attempts):
                                                                                                        try:
                                                                                                            pic_link = pic_tag.find('img')['src']
                                                                                                            urllib.urlretrieve(pic_link, pic_filename)
                                                                                                        except Exception as e:
                                                                                                            if attempt == no_attempts - 1:
                                                                                                                write_output(', '.join([profile_link, str(identifier), state, 'pic']), failed_pics)
                                                                                                                write_output(', '.join([e.message, profile_link, str(identifier)]), outputfile)
                                                                                                        else:
                                                                                                            break
                                                                                                    break
                                                                                        break
                                                                    break
                                        break
                    break

    os.chdir(original_directory)