# To scrape mugshots.com
# Arrest_id simply needs to be unique within each State/County folder to avoid overwriting data
# Later, I can assign unique IDs to the entire dataset

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

from mugshots_constants import *
import pandas
import json

def main(output_location, states = [], counties_json = 'counties.json', arrest_id = 0):
	original_directory = os.getcwd()
	if not os.path.exists(output_location):
		os.makedirs(output_location)
	os.chdir(output_location)

	soup = get_soup('http://mugshots.com/US-Counties')
	states_dict = get_states(soup, states)

	county_array = get_counties(states_dict)	
	# used to be 'w', so will be incomplete
	with open (counties_json, 'a') as f:
		json.dump(county_array, f)

	gothru_counties(county_array, arrest_id)

	os.chdir(original_directory)


def write_output(string, outfile):
	localtime = time.asctime(time.localtime(time.time()))
	with open(outfile, 'a') as f:
		f.write(localtime + ' ' + string + "\n")

# Get and return the Beautiful Soup from a given link
def get_soup(link):
	req = urllib2.Request(url = link, headers = hdrs)
	data = urllib2.urlopen(req, timeout = timeout_time).read()
	soup = BeautifulSoup(data)
	time.sleep(random.uniform(min_pause, max_pause))
	return soup

# Get the state links for all states / the states given
def get_states(soup, states):
	states_dict = {}
	for state_list in soup.find('div',{'id':'subcategories'}).find_all('ul', {'class':'categories'}):
		for state_tag in state_list.findAll('li'):
			state = str(state_tag.find('a').text.split(' (')[0]).strip()
			
			if not states or state in states:
				state_link = base_url + str(state_tag.find('a')['href']).strip()
				states_dict[state] = state_link
	return states_dict

# Get the list of county links and make an array that will become a json object storying county-state-num profiles
def get_counties(states_dict):
	county_array = []

	for state, state_link in states_dict.iteritems():
		state_soup = get_soup(state_link)

		for county_list in state_soup.find('div',{'id':'subcategories'}).find_all('ul', {'class':'categories'}):
			for county_tag in county_list.findAll('li'):
				county_dict = {}
				county = str(county_tag.find('a').text).split(',')[0].strip()
				county_link = base_url + str(county_tag.find('a')['href']).strip()
				county_num_profiles = str(county_tag.find('a').text).split('(')[1].split(')')[0].strip()

				county_dict['state'] = state
				county_dict['county'] = county
				county_dict['county_link'] = county_link
				county_dict['num_profiles'] = county_num_profiles
				county_array.append(county_dict)

	return county_array

# Go through each county link to download its profiles
def gothru_counties(county_array, arrest_id):
	for county_dict in county_array:
		state = county_dict['state']
		county = county_dict['county']
		county_link = county_dict['county_link']

		profile_dir =  os.path.join('Profiles', state, county)
		if not os.path.exists(profile_dir):
			os.makedirs(profile_dir)

		pic_dir = os.path.join('Pictures', state, county)
		if not os.path.exists(pic_dir):
			os.makedirs(pic_dir)

		# If you can't find the first page, continue on to the next county
		try:
			county_soup = get_soup(county_link)
		except Exception as e:
			write_output(county_link + ', ' + e.message, 'failed_first_pages.txt')
			continue

		arrest_id = get_profiles(county_soup, profile_dir, pic_dir, arrest_id)

		# Go to next page, until reach last page
		while True:
			page_button = county_soup.find('div',{'class':'pagination'})
			# If there's no page button, e.g. b/c it's an empty county, break out of loop
			if page_button is None:
				break

			# If there is no next page, break out of loop
			next_page_tag = page_button.find('a',{'class':'next'})
			if next_page_tag is None:
				break

			# If a page fails, break out of this county - otherwise you can visit the same page several times
			next_page_link = county_link + str(next_page_tag['href'])
			try:
				county_soup = get_soup(next_page_link)
			except Exception as e:
				write_output(next_page_link + ', ' + e.message, 'failed_next_pages.txt')
				break

			arrest_id = get_profiles(county_soup, profile_dir, pic_dir, arrest_id)

# Download all the profiles from a given page
def get_profiles(county_soup, profile_dir, pic_dir, arrest_id):
	county_profiles = county_soup.find('div',{'class':'gallery-listing'})
	if county_profiles is not None and county_profiles.find_all('a') is not None:
		for profile_tag in county_profiles.find_all('a'):
			profile_link = base_url + str(profile_tag['href'])
			try:
				profile_soup = get_soup(profile_link)

				profile_filename = os.path.join(profile_dir, str(arrest_id) + '.html')
				pic_filename = os.path.join(pic_dir, str(arrest_id) + '.jpg')

				with open(profile_filename, 'w') as f:
				    f.write(profile_soup.prettify())

				arrest_id += 1

				no_images = profile_soup.find('div',{'class':'no-images'})
				pic_tag = profile_soup.find('div', {'class':'full-image'})

			except Exception as e:
				write_output(profile_link + ', ' + e.message, 'failed_profiles.txt')

			else:
				try:
					if no_images is None and pic_tag is not None and pic_tag.find('img') is not None:
						pic_link = pic_tag.find('img')['src']
						urllib.urlretrieve(pic_link, pic_filename)
				except:
					pass

	return arrest_id