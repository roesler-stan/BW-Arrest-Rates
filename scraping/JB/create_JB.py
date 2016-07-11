# To get HTML data into pandas dataset
# NEED TO adjust state and county info, take year and month info from folders

import sys;
reload(sys);
sys.setdefaultencoding("utf8")
import os
import re

import urllib2
from bs4 import BeautifulSoup
import fnmatch

import time
from datetime import datetime
import numpy
import pandas

data_array = []

def get_text(tag):
	if tag is not None:
		return str(tag.text).strip()

def write_output(string, outputfile):
    localtime = time.asctime(time.localtime(time.time()))
    with open(outputfile, 'a') as f:
        f.write(localtime + ' ' + string + "\n")

def create_dataset(rootdir, dataset_file, outputfile='JB_create_errors.txt'):
	for directory, subdirectory, files in os.walk(rootdir):
		files = [fi for fi in files if fi.endswith(".html")]
		for filename in files:
			data = urllib2.urlopen('file:' + os.path.join(directory, filename))
			soup = BeautifulSoup(data)
			
			person_dict = {}

			identifier = filename.split('.html')[0]
			arrest_state = os.path.relpath(directory, rootdir).split('/')[0]
			arrest_county = os.path.relpath(directory, rootdir).split('/')[1]

			download_date = time.ctime(os.path.getmtime(os.path.join(directory, filename)))
			download_date = datetime.strptime(download_date, '%a %b %d %H:%M:%S %Y')

			try:
				profile = soup.find('div', {'class':'profile-content'})
			except:
				write_output('couldn\'t find details for profile ' + identifier, outputfile)
			else:
				first_name = middle_name = last_name = None
				fullname = ''
				try:
					first_name = get_text(profile.find('h1',{'itemprop':'name'}).find('span', {'itemprop':'givenName'}))
					middle_name = get_text(profile.find('h1',{'itemprop':'name'}).find('span', {'itemprop':'additionalName'}))
					last_name = get_text(profile.find('h1',{'itemprop':'name'}).find('span', {'itemprop':'familyName'}))
				except:
					write_output('no name for ' + identifier, outputfile)
				if first_name is not None:
					fullname += first_name + ' '
				if middle_name is not None:
					fullname += middle_name + ' '
				if last_name is not None:
					fullname += last_name
				fullname = fullname.strip()

				booked_by_tag = profile.find('span', text = re.compile('Booked By'))
				if booked_by_tag is not None:
					booked_by = str(booked_by_tag.find_next_sibling('p').find('a').text.strip())
				else:
					booked_by = None
				
				booked_date_tag = profile.find('span', text = re.compile('Booked Date'))
				if booked_date_tag is not None:
					booked_date_text = str(booked_date_tag.find_next_sibling('p').find('a').text).strip()
					booked_date = datetime.strptime(booked_date_text, '%b. %d, %Y')
				else:
					booked_date = None

				details = soup.find('div',{'class':'detailText'})
				if details is None:
					write_output('couldn\'t find details for profile ' + identifier, outputfile)
				else:
					for entry in details.find_all('p'):
						name = str(entry.find('span',{'class':'profil-label'}).text).strip()
						value = str(entry.find('span',{'class':'profil-label'}).find_next_sibling('span').text).strip()
						person_dict[name] = value

				# doing this after details to avoid overwriting
				person_dict['identifier'] = identifier
				person_dict['arrest_state'] = arrest_state
				person_dict['arrest_county'] = arrest_county
				person_dict['fullname'] = fullname
				person_dict['first_name'] = first_name
				person_dict['middle_name'] = middle_name
				person_dict['last_name'] = last_name
				person_dict['booked_by'] = booked_by
				person_dict['booked_date'] = booked_date

				data_array.append(person_dict)

	dataset = pandas.DataFrame(data_array)
	
	dataset = dataset.rename(columns={'Notes:':'notes','Charges:':'charges','Tags:':'tags'})
	
	dataset.to_pickle(dataset_file)

	print dataset.dtypes
	print dataset.head()
	print dataset.columns.values