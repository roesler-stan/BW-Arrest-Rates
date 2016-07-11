""" A few individual-level changes that general_clean did not do originally. """

import pandas
import numpy

def main(dataset):
    # Remove any mugshots without a county identified
    dataset = dataset[dataset['county_no'].notnull()]
    
    for date_var in ['date', 'download_date', 'birthday', 'views_date']:
        if date_var in dataset.columns:
            dataset[date_var] = pandas.to_datetime(dataset[date_var], coerce = True, utc = True)[:]

    dataset['year'] = dataset['date'].dt.year

    dataset['days_online'] = dataset['download_date'][:] - dataset['date']
    
    # Removing minors without removing people of unknown age
    dataset = dataset.drop(dataset.index[dataset['age'] < 18])
    dataset['age_sq'] = dataset['age'] ** 2
    
    dataset = offense_types(dataset)
    dataset = race_additional(dataset)
    
    return dataset

def race_additional(dataset):
    dataset.loc[dataset['black_only_ighisp'] == 1, 'black_not_other_known'] = 1
    dataset.loc[dataset['white_only_ighisp'] == 1, 'black_not_other_known'] = 0
    dataset.loc[dataset['am_ind_only_ighisp'] == 1, 'black_not_other_known'] = 0
    dataset.loc[dataset['asian_only_ighisp'] == 1, 'black_not_other_known'] = 0
    dataset.loc[dataset['east_asian_only_ighisp'] == 1, 'black_not_other_known'] = 0
    
    dataset.loc[dataset['white_only_ighisp'] == 1, 'white_not_other_known'] = 1
    dataset.loc[dataset['black_only_ighisp'] == 1, 'white_not_other_known'] = 0
    dataset.loc[dataset['am_ind_only_ighisp'] == 1, 'white_not_other_known'] = 0
    dataset.loc[dataset['asian_only_ighisp'] == 1, 'white_not_other_known'] = 0
    dataset.loc[dataset['east_asian_only_ighisp'] == 1, 'white_not_other_known'] = 0
    
    # Not really necessary b/c variables like white_only and racial_minority are null if race is unknown
    #dataset['race_known'] = 0
    #dataset.loc[dataset['racial_minority'].notnull(), 'race_known'] = 1
    
    return dataset

# To remove counties without at least N arrets
def remove_small(dataset, min_arrests = 10):
    few_arrests = []
    bycounty = dataset.groupby('county_no')

    for county_no in bycounty.groups:
        if bycounty.get_group(county_no).arrest_id.count() < min_arrests:
            few_arrests.append(county_no)

    def has_few(county_no):
        return county_no in few_arrests

    dataset = dataset[~dataset.county_no.map(has_few)]
    return dataset

# Remove each county with low completeness on given variables
def remove_miss(dataset, miss_vars, miss_rate):
    counties = dataset.groupby('county_no')
    for county in counties.groups:
        for var in miss_vars:
            if (counties.get_group(county)[var].count() / counties.get_group(county)['arrest_id'].count()) < miss_rate:
                dataset = dataset[dataset['county_no'] != county]
    return dataset

# Less than 75% missing on black/white, age, and gender
# m2014_lmiss = remove_miss(m2014, ['black_not_white','age','gender'], .75)