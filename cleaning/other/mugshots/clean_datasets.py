# Uses clean_M, general_clen, and clean_charges to clean raw data with many overlapping column names
import pandas
import clean_M as cm
import general_clean as gc
import clean_charges as cc

def main():
	#filenames = ['ALDC', 'FLGA', 'HIKS', 'KYOH', 'OKTN', 'TXWY', 'Failed']
	#filenames = [Failed']
	input_dir = './'
	output_dir = '../July10_Clean/'
	batches = {1: [0, 50000], 2: [50000, 'all']}

	clean_arrests(filenames, input_dir, output_dir, input_dir + 'official_counties.tsv', batches)

def clean_arrests(file_names, input_dir, output_dir, official_counties, batches):
	for filename in file_names:
		dataset = cm.clean_arrests(input_dir + filename, official_counties)

		to_clean = ['race','age','gender','zipcode','address','page_views','date', 'birthday']
		keeping = ['scraping_arrest_id', 'county', 'state', 'county_no', 'name', 'download_date', 'all_charges']
		dataset = gc.main(dataset, to_clean, keeping)
		dataset['arrest_id'] = dataset['state'] + '_' + dataset['county'].str.split(' ').str[0] + '_' + \
			dataset['scraping_arrest_id'].astype(str)

		dataset.to_csv(output_dir + 'arrests_' + filename + '.csv', header = True, index = False, date_format = '%Y-%m-%d', encoding='utf-8')
		
		clean_charges(dataset, filename, output_dir, batches)

def clean_charges(orig_data, filename, output_dir, batches):
	master_dataset = pandas.DataFrame()

	for batch, values in batches.iteritems():
		dataset = orig_data.copy(deep = True)
		if values[1] != 'all':
			dataset = dataset[values[0] : values[1]]
		else:
			dataset = dataset[values[0] : ]

		dataset = cc.expand_charges(dataset)
		dataset.to_csv(output_dir + 'charges_' + filename + str(batch) + '.csv', header = True, index = False)
