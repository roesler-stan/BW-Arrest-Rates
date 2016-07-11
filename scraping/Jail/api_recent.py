# Read list of sources to query
import pandas
import urllib2
import json
import time
import random

base_url = 'http://www.jail.com/api/1/recent/'
hdrs = {'Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=1.8', 'Accept-Language':'en-us,en;q=0.5', \
    'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36'}
timeout_time = 20
sleep_time = 1

def main():
	sources = pandas.read_csv('jail_sources.csv')
	dataset = []

	for source in sources['ID'].unique():
		source_link = base_url + '?source_id=' + source
		data, dataset = get_data(source_link, dataset)
		
		# While there are more pages to get
		while(data['next_page'] != 0):
			link = source_link + '&page=' + str(data['next_page'])
			data, dataset = get_data(link, dataset)

	with open('jail', 'w') as outfile:
		json.dump(dataset, outfile)

def get_data(link, dataset):
	try:
		source_req = urllib2.Request(url = link, headers = hdrs)
		source_html = urllib2.urlopen(source_req, timeout = timeout_time).read()
		time.sleep(sleep_time)
		data = json.loads(source_html)
		dataset += data['records']
	
	# If it didn't load page, act as if it hit the last page
	except Exception as e:
		data = {'next_page':0}
		with open('../Data/failed','a') as f:
			f.write(link + ', ' + e.message + '\n')
	
	return data, dataset