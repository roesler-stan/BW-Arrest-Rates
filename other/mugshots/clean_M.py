# #### This file is mugshots.com-specific
# #### To make "combo" variables before cleaning them with "general clean"

import pandas
import numpy
import re

# This file reads the pickle created from the html and selects columns to clean later
def clean_arrests(input_file, counties_file):
    dataset = pandas.read_pickle(input_file)
    dataset = clean_vars(dataset)
    dataset = clean_counties(dataset, counties_file)
    dataset = combine_charges(dataset)

    dataset = keep_vars(dataset)
    
    return dataset

# Take each column whose name has the include values given and not the exclude values and combine them into _combo vars
# Address shouldn't come from a table, so excluding that
# Need to eliminate bad columns - e.g. "offense date"

def clean_vars(dataset):
    # First value is to include, second to exclude
    combo_vars = {'race': ['race|racial|ethnic'], 'gender':['^gender$|^sex$'],
        'birthday':['birth','place'], 'age':['(^|[^a-z])age([^a-z]|$)','victim'],
        'address':['address','work|facility|court|temp|emp|other|school|verified|2|jail|second|table|google'],
        'zipcode':['zip','work|facility|court|temp|emp|other|school|2|jail|prison|second'],
        'date':['(^date$)|((?=.*date)(?=.*/?time|desc|charg|book|confin|admi|arrest|arrrest|'
                'detain|regist|comm|cust|filed|post|intake|arriv|incarc|initial|enter|'
                 'hold|start|in|lodged|added|jail|receiv|entry|issue|recept|publish|intake|'
                 'cust|start|begin))',
                 'release|court|sentenc|download_date|conv|offense|crime|photo|parole|hearing|'
                 'discharge|maximum|min|renew|regist|superv']}

    for key in combo_vars.keys():
        dataset[key + '_combo'] = ''
        include = re.compile(combo_vars[key][0])
        if len(combo_vars[key]) > 1:
            exclude = re.compile(combo_vars[key][1] + '|combo')
        else:
            exclude = re.compile('combo')
        
        for col in dataset.columns:
            if re.search(include, str(col)) and not re.search(exclude, str(col)):
                dataset.loc[dataset[col].notnull(), key + '_combo'] += dataset[col].astype(str) + '; '
    
    dataset['download_date'] = pandas.to_datetime(dataset['download_date'], coerce = True, utc = True)

    # This arrest_id has duplicates, but is unique within county-state folders
    dataset = dataset.rename(columns = {'arrest_id': 'scraping_arrest_id'})
    
    return dataset

# Labels counties with their FIPS ID (county_no)
def clean_counties(dataset, counties_file):
    official_counties = {}
    with open(counties_file, 'r') as county_file:
        for line in county_file:
            # counties are on the right, as County, State
            key = line.split('\t')[1].strip()
            value = line.split('\t')[0]
            official_counties[key] = value

    dataset['arrest_county'] = dataset['arrest_county'].str.replace('-', ' ')
    dataset['county_state'] = dataset['arrest_county'] + ', ' + dataset['arrest_state']

    def get_countyno(county_string):
        if official_counties.has_key(county_string):
            return str(official_counties[county_string])

    # Returns strings of the county number
    dataset['county_no'] = dataset['county_state'].map(get_countyno)

    return dataset

def combine_charges(dataset):
    # Combining variables with 'charge' or 'offense' in their name
    dataset['charge_combo'] = ''

    charge_include = re.compile('charge|offense')
    charge_exclude = re.compile('\#|number|authority|bail|discharged|date|charge_combo|charge_cat'
                                'count|degree|level|related')
    
    def get_charges(charge_value):
        if isinstance(charge_value, tuple) and charge_value:
            return ' +++ ' + str(charge_value) + ' +++ '

        elif isinstance(charge_value, basestring):
            if not charge_value.isspace():
                return ' || ' + charge_value + ' || '
            else:
                return ''
        
        return ''
    
    for col in dataset.columns:
        if re.search(charge_include, str(col)) and not re.search(charge_exclude, str(col)):
            dataset.loc[dataset[col].notnull(), 'charge_combo'] += dataset[col].map(get_charges)

    return dataset

def keep_vars(dataset):
    # The variables to keep.  _combo are new  vars
    dataset = dataset[['scraping_arrest_id', 'county_no', 'arrest_state', 'arrest_county', 'page_views',
                       'download_date', 'description_found', 'disclaimer_found',
                       'fullname', 'google_address',
                       'age_combo','gender_combo','zipcode_combo','birthday_combo','race_combo',
                       'address_combo', 'date_combo', 'charge_combo']]

    # Now you can rename _combo to correct var name
    dataset = dataset.rename(columns=lambda x: x.split('_combo')[0])

    dataset = dataset.rename(columns = {'fullname':'name', 'arrest_state':'state',
                                        'arrest_county':'county', 'charge':'all_charges',
                                        'description_found':'description',
                                        'disclaimer_found':'disclaimer'})
    
    return dataset