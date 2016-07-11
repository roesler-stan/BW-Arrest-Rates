# Creates Pandas dataframe from HTML profile pages
# Requires that data come from profiles folder with State/County/profile_no.html inside

import sys;
reload(sys);
sys.setdefaultencoding("utf8")
import os
import re

import urllib2
from bs4 import BeautifulSoup

from datetime import datetime
import time
import numpy
import pandas
import string

# Rootdir is Profiles
def main(rootdir, output_folder, output_file, states):
	data_array = []

	for arrest_state in states:
		state_folder = os.path.join(rootdir, arrest_state)
		if not os.path.exists(state_folder):
			continue

		for folder_path, county_folders, filenames in os.walk(state_folder):
			files = [f for f in filenames if f.endswith(".html")]
			for filename in files:
				person_dict = {}

				arrest_id_found = int(filename.split('.html')[0])
				person_dict['arrest_id'] = arrest_id_found

				arrest_county = folder_path.split('/')[-1]
				person_dict['arrest_county'] = arrest_county
				person_dict['arrest_state'] = arrest_state
		
				file_path = os.path.join(folder_path, filename)
				data = urllib2.urlopen('file:' + file_path)
				soup = BeautifulSoup(data)
				all_info = soup.find('div', {'id':'container'})

				download_date = time.ctime(os.path.getmtime(file_path))
				download_date = datetime.strptime(download_date, '%a %b %d %H:%M:%S %Y')
				person_dict['download_date'] = download_date

				person_dict = name(all_info, person_dict)
				person_dict = profile_box(all_info, person_dict)

				person_dict = page_views(all_info, person_dict)
				person_dict = description_disclaimer(all_info, person_dict)
				person_dict = google_address(soup, person_dict)

				data_array.append(person_dict)

	dataset = pandas.DataFrame(data_array)

	if not os.path.exists(output_folder):
		os.makedirs(output_folder)
	output_filename = os.path.join(output_folder, output_file)
	
	dataset.to_pickle(output_filename)

# Getting information in profile's gray box, the table below the disclaimer
def profile_box(all_info, person_dict):
	profile = all_info.find('div', {'class':re.compile('graybox')})
	if profile is None:
		return person_dict

	# Finding each line in the box/tables
	box_tag = all_info.find('div',{'class':'fieldvalues'})
	
	# For each tag with class "field", check for lists, tables, and key-value pairs
	for field_tag in box_tag.find_all('div',{'class':'field'}):
		tag_value = field_tag.find('div',{'class':'value'})
		if tag_value is not None:
			# If it is a list element
			if tag_value.find('ul') is not None:
				name = str(field_tag.find('div',{'class':'name'}).text).strip().lower()
				value = [str(li.text).strip().lower() for li in field_tag.find('div',{'class':'value'}).find('ul').find_all('li')]
				person_dict[name] = tuple(value)

			# If it is a table, getall the key-value pairs
			elif tag_value.find('table') is not None:
				# First, get the table name and attach it to all subsequently found keys
				table_name = str(field_tag.find('div',{'class':'name'}).text).strip().strip(':').lower()
				table_name = string.replace(table_name, ' ', '_') + '_table_'
				
				# For each header, go through the rows and find the matching values
				for header_num, header in enumerate(field_tag.find('tr').find_all('th')):
					name = table_name + str(header.text).strip().lower()
					# Want array of table values that correspond to each header
					value = []
			
					for box_row in field_tag.find_all('tr'):
						# If this is content, not a header
						if box_row.find('td') is not None:
							for col_num, column in enumerate(box_row.find_all('td')):
								if header_num == col_num:
									value.append(str(column.text).strip().lower())
			
					person_dict[name] = tuple(value)
			
			# If it is not a list or a table, get the key-value pair
			elif tag_value.find('ul') is None and field_tag.find('div',{'class':'value'}).find('table') is None:
				name = str(field_tag.find('span',{'class':'name'}).text).strip().lower()
				value = str(field_tag.find('span',{'class':'value'}).text).strip().lower()
				person_dict[name] = value
		
		# If there's no div, check if there is a span with names and values
		elif field_tag.find('span', {'class':'value'}) is not None:
			name = str(field_tag.find('span',{'class':'name'}).text).strip().lower()
			value = str(field_tag.find('span',{'class':'value'}).text).strip().lower()
			person_dict[name] = value

	return person_dict

# Description box contains info like booking date
# Disclaimer listing collection date and agency
def description_disclaimer(all_info, person_dict):
	description_found = disclaimer_found = ''

	description_tag = all_info.find('h1', {'class':re.compile('frontpage')})
	if description_tag is not None:
		if description_tag.find_next_sibling('div') is not None:
			description_found = str(description_tag.find_next_sibling('div').text).strip().lower().replace('\n', ' ')

	disclaimer_tag = all_info.find('div', {'class':'smaller'}, {'class':'disclaimer'})
	if disclaimer_tag is not None:
		disclaimer_found = str(disclaimer_tag.text).replace('\n', ' ')

	person_dict['description_found'] = description_found
	person_dict['disclaimer_found'] = disclaimer_found

	return person_dict

def name(all_info, person_dict):
	first_name = last_name = fullname = ''

	# Try to find name text at top left corner
	name_tag_corner = all_info.find('span', {'itemprop':'name'})
	if name_tag_corner is not None:
		fullname = str(name_tag_corner.text).strip().lower()
		first_name = fullname.rsplit(' ', 1)[0]
		if ' ' in fullname:
			last_name = fullname.rsplit(' ', 1)[1]
	
	else:
		# Try to find name text from questions in title
		name_tag_title = all_info.find('h1',{'class':'frontpage-like-header'})
		if name_tag_title is not None:
			if 'Who is' in str(name_tag_title.text):
				fullname = str(name_tag_title.text).strip().split('Who is ')[1].split('?')[0].lower()
				first_name = fullname.rsplit(' ', 1)[0]
				if ' ' in fullname:
					last_name = fullname.rsplit(' ', 1)[1]
			
			else:
				# Try to find name in the profile details box
				name_tag = profile.find('span', text = re.compile("Name"))
				if name_tag is not None:
					fullname = str(name_tag.parent.find('span', {'class':'value'}).text).strip().lower()
					
					if "," in name_found:
						first_name = fullname.split(', ')[1]
						last_name = fullname.split(', ')[0]
					elif " " in name_found:
						first_name = fullname.rsplit(' ', 1)[0]
						last_name = fullname.rsplit(' ', 1)[1]
					else:
						first_name = fullname
						last_name = ''
					
					fullname = (first_name + ' ' + last_name).strip()

	person_dict['first_name'] = first_name
	person_dict['last_name'] = last_name
	person_dict['fullname'] = fullname

	return person_dict

# Page views text
def page_views(all_info, person_dict):
	page_views = ''
	page_views_tag = all_info.find('div',{'class':'small-info-popup'})
	
	if page_views_tag is not None:
		page_views = str(page_views_tag.text).strip().lower()

	person_dict['page_views'] = page_views
	return person_dict

# Text above Google Map
def google_address(soup, person_dict):
	google_address = ''
	address_text = ''

	soup_string = str(soup)
	address_text = re.search(re.compile('googleMap\(.*\''), soup_string)
	
	if address_text:
		address_text = address_text.group(0)
		google_address = address_text.strip('googleMap\(').strip('\'')

	person_dict['google_address'] = google_address
	return person_dict