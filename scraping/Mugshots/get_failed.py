# Tries to get the profiles from the links that failed in mugshots_profiles
import sys;
reload(sys);
sys.setdefaultencoding("utf8")
import os

import mugshots_profiles as mp
from mugshots_constants import *

import urllib
import urllib2
from bs4 import BeautifulSoup
import re

def main():
	arrest_id = 0

	for source in ('failed_first_pages.txt', 'failed_next_pages.txt'):
		links = get_links(source)
		arrest_id = county_pages(arrest_id, links)

	links = get_links('failed_profiles.txt')
	arrest_id = get_profiles(arrest_id, links)

# Follows a page link and calls get page for each next page found
def county_pages(arrest_id, links):
	for county_link in links:
		try:
			county_soup = mp.get_soup(county_link)

		except Exception as e:
			mp.write_output(county_link + ', ' + e.message, 'failed_pages2.txt')
			continue

		arrest_id = get_page(arrest_id, county_soup)

		while True:
			page_button = county_soup.find('div',{'class':'pagination'})
			if page_button is None:
				break

			next_page_tag = page_button.find('a',{'class':'next'})
			if next_page_tag is None:
				break

			next_page_link = county_link + str(next_page_tag['href'])
			try:
				county_soup = mp.get_soup(next_page_link)
			except Exception as e:
				mp.write_output(next_page_link + ', ' + e.message, 'failed_pages2.txt')
				break

			arrest_id = get_page(arrest_id, county_soup)

	return arrest_id

# Gets county page data and sends it to get_profiles if there are profiles present
def get_page(arrest_id, county_soup):
	county_profiles = county_soup.find('div',{'class':'gallery-listing'})
	if county_profiles is not None and county_profiles.find_all('a') is not None:
		profile_links = [base_url + profile_tag['href'] for profile_tag in county_profiles.find_all('a')]
		arrest_id = get_profiles(arrest_id, profile_links)
	
	return arrest_id

# Gets each profile on the given pages
def get_profiles(arrest_id, profile_links):
	for profile_link in profile_links:
		profile_dir, pic_dir = get_info(profile_link)

		try:
			profile_soup = mp.get_soup(profile_link)

			profile_filename = os.path.join(profile_dir, str(arrest_id) + '.html')
			pic_filename = os.path.join(pic_dir, str(arrest_id) + '.jpg')

			with open(profile_filename, 'w') as f:
			    f.write(profile_soup.prettify())

			arrest_id += 1

			no_images = profile_soup.find('div',{'class':'no-images'})
			pic_tag = profile_soup.find('div', {'class':'full-image'})

		except Exception as e:
			mp.write_output(profile_link + ', ' + e.message, 'failed_profiles2.txt')

		# including an else clause b/c don't want failed pictures to raise an exception
		else:
			try:
				if no_images is None and pic_tag is not None and pic_tag.find('img') is not None:
					pic_link = pic_tag.find('img')['src']
					urllib.urlretrieve(pic_link, pic_filename)
			except:
				pass

	return arrest_id

# Reads a text file and finds links starting with http and ending with a comma
def get_links(filename):
	with open(filename, 'r') as f:
		file_string = f.read()
	return [link.strip(',') for link in re.findall(re.compile('http.*,'), file_string)]

# Gets the state and county baed on a link, and creates a directory to store profiles if it doesn't exist yet
def get_info(link):
	state = link.split('Counties/')[1].split('/')[0]
	county = link.split('Counties/')[1].split('/')[1]
	county = re.split('-[A-Z]{2}$', county)[0]

	profile_dir = os.path.join('Profiles2', state, county)
	if not os.path.exists(profile_dir):
		os.makedirs(profile_dir)

	pic_dir = os.path.join('Pictures2', state, county)
	if not os.path.exists(pic_dir):
		os.makedirs(pic_dir)

	return profile_dir, pic_dir