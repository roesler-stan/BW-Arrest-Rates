""" Make a file with mean arreste rates by agency and offender race
Keep agency name, city, and state
"""

import pandas as pd
import numpy as np

def main():
	data_directory = '../../Data/'
	infile = data_directory + 'offenders_2013_caplg_ucr_clean2.csv'
	outfile = data_directory + 'wofficers_byoffense.csv'
	states_file = data_directory + 'states key.csv'

	dataset = clean_dataset(infile, states_file)

	arrested_data = make_subset(dataset, 'all')
	arrested_data = arrested_data.rename(columns = {'arrested': 'arrested_all', 'offenders_count': 'offenders_count_all'})

	offenses = ['simple_assault', 'aggravated_assault', 'intimidation', 'robbery', 'shoplifting',
	'vandalism', 'drugs_narcotics', 'drug_equipment', 'weapon']
	for offense in offenses:
		subset_percent_arrested = make_subset(dataset, offense)

		# Only keep data for agencies with at least 10 offenders with that offense
		agencies_counts = (subset_percent_arrested.groupby('ori')['offenders_count'].sum() >= 10).reset_index()
		good_agencies = agencies_counts[agencies_counts['offenders_count']]['ori'].unique()
		subset_percent_arrested = subset_percent_arrested[subset_percent_arrested['ori'].isin(good_agencies)]
		
		cols = ['ori', 'black_not_white', 'arrested', 'offenders_count']
		subset_percent_arrested = subset_percent_arrested[cols]
		subset_percent_arrested = subset_percent_arrested.rename(columns = {'arrested': 'arrested_' + offense,
			'offenders_count': 'offenders_count_' + offense})

		arrested_data = arrested_data.merge(subset_percent_arrested, on = ['ori', 'black_not_white'], how = 'outer')

	arrested_data = arrested_data.drop('ori', axis = 1)

	# Remove agencies with fewer than 100 total offenders in 2013
	arrested_data = arrested_data[arrested_data['offenders_count_all'] >= 100]

	arrested_data.to_csv(outfile, index = False)

def clean_dataset(infile, states_file):
	dataset = pd.read_csv(infile)
	# Only include agencies with officer demographics data and rows with offender race
	dataset = dataset[dataset['w_officers_percent'].notnull()]
	dataset = dataset[dataset['black_not_white'].notnull()]
	dataset['black_not_white'] = dataset['black_not_white'].astype(int)

	states_data = pd.read_csv(states_file)
	states_data = states_data.set_index('fullname')
	states_dict = states_data['abbreviation'].to_dict()
	dataset['state'] = dataset['state_name'].map(states_dict)
	return dataset

def make_subset(dataset, offense):
	""" To make a separate subset for each offense """
	if offense == 'all':
		subset = dataset.copy()
	else:
		subset = dataset[dataset['offense_' + offense] == 1]
		subset = subset[(subset['arrest_' + offense] == 1) | (subset['arrested'] == 0)]

	agencies = subset.groupby(['ori', 'black_not_white'])
	percent_arrested = agencies.agg({'w_officers_percent': np.mean, 'arrested': np.mean,
		'city': max, 'state': max, 'state_name': 'count'})
	percent_arrested = percent_arrested.rename(columns = {'state_name': 'offenders_count'})
	percent_arrested['arrested'] = percent_arrested['arrested'] * 100
	percent_arrested = percent_arrested.reset_index()
	percent_arrested['offense'] = offense

	return percent_arrested

if __name__ == '__main__':
	main()