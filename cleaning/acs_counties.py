""" Make acs_counties_13.csv, county-level ACS demographic data """

import pandas
import re

"""
Data sources:
    2013 5-year estimates from factfinder.census.gov

    race: 2013 5-year county-level file for B02001, ACS_13_5YR_B02001_with_ann.csv
    gender and age: 2013 5-year county_no-level file for S0101, ACS_13_5YR_S0101_with_ann.csv
    gender and age for white, black people: 2013 5-year county_no-level file for B01001A and B01001B, ACS_14_5YR_B01001A_with_ann.csv, ACS_14_5YR_B01001B_with_ann.csv
    mean income: 2013 5-year county_no-level file for S1902, ACS_13_5YR_S1902_with_ann.csv
    household income for white, black people for B19001A and B19001B: ACS_13_5YR_B19001A_with_ann.csv, ACS_13_5YR_B19001B_with_ann.csv
    unemployment for white and black people for S2301: ACS_13_5YR_S2301_with_ann.csv
"""

def main():
    in_directory = '../../Data/acs counties/'
    outfile = '../../Data/acs_counties_13.csv'

    race_filename = in_directory + 'ACS_13_5YR_B02001_with_ann.csv'
    gender_filename = in_directory + 'ACS_13_5YR_S0101_with_ann.csv'
    gender_race_age_filenames = [in_directory + 'ACS_13_5YR_B01001A_with_ann.csv', in_directory + 'ACS_13_5YR_B01001B_with_ann.csv']
    inc_filename = in_directory + 'ACS_13_5YR_S1902_with_ann.csv'
    inc_white_file = in_directory + 'ACS_13_5YR_B19001A_with_ann.csv'
    inc_black_file = in_directory + 'ACS_13_5YR_B19001B_with_ann.csv'
    emp_filename = in_directory + 'ACS_13_5YR_S2301_with_ann.csv'
    
    full_data = clean_race(race_filename)
    gender_age_data = gender_age(gender_filename)
    gender_race_age_data = gender_race_age(gender_race_age_filenames)

    inc_data = clean_inc(inc_filename)    
    race_inc_data = race_inc(inc_black_file, inc_white_file)
    emp_data = emp(emp_filename)

    full_data = pandas.merge(full_data, gender_age_data, how = 'outer', on = 'county_no')
    full_data = pandas.merge(full_data, gender_race_age_data, how = 'outer', on = 'county_no')
    full_data = pandas.merge(full_data, inc_data, how = 'outer', on = 'county_no')
    full_data = pandas.merge(full_data, race_inc_data, how = 'outer', on = 'county_no')
    full_data = pandas.merge(full_data, emp_data, how = 'outer', on = 'county_no')
    
    full_data = full_data.rename(columns = lambda x: x.lower())
    full_data['county_no'] = full_data['county_no'].astype(str).str[-5:]

    full_data.to_csv(outfile, header = True, index = False, quotechar = '"')

# Calculating resident percentages
def clean_race(race_filename):
    dataset = read_noheaders(race_filename)
    dataset = dataset.rename(columns = lambda x: x.lower())

    good_columns = [col for col in dataset.columns if 'margin' not in col]
    dataset = dataset[good_columns]
    dataset = dataset.drop(dataset[['id2', 'geography']], axis = 1)

    dataset = dataset.rename(columns = lambda x: x.replace('estimate; total: - ', ''))
    dataset = dataset.rename(columns = lambda x: x.split(' alone')[0])
   
    dataset = dataset.rename(columns = {'id': 'county_no', 'white':'w_residents', 'black or african american':'b_residents',
        'american indian and alaska native':'i_residents', 'asian':'a_residents', 'native hawaiian and other pacific islander':'h_residents',
        'some other race':'o_residents', 'two or more races:':'m_residents', 'two or more races: - two races including some other race': 'mi_residents',
        'two or more races: - two races excluding some other race, and three or more races':'mt_residents',
        'estimate; total:':'total_residents'})

    dataset.loc[dataset['total_residents'] != 0, 'b_residents_percent'] = (dataset.loc[dataset['total_residents'] != 0, 'b_residents'] / dataset.loc[dataset['total_residents'] != 0, 'total_residents']) * 100    
    dataset.loc[dataset['total_residents'] != 0, 'w_residents_percent'] = (dataset.loc[dataset['total_residents'] != 0, 'w_residents'] / dataset.loc[dataset['total_residents'] != 0, 'total_residents']) * 100
    dataset['nonw_residents_percent'] = 100 - dataset['w_residents_percent']
    
    return dataset

def gender_age(filename):
    dataset = read_noheaders(filename)
        
    desired_cols = ['Id', 'Total; Estimate; Total population', 'Male; Estimate; Total population',
                    'Total; Estimate; AGE - 15 to 19 years', 'Male; Estimate; AGE - 15 to 19 years',
                    'Total; Estimate; AGE - 20 to 24 years', 'Male; Estimate; AGE - 20 to 24 years']                    
    dataset = dataset[desired_cols]
    
    dataset = dataset.rename(columns = lambda x: re.sub('; Estimate; ','', x))
    dataset = dataset.rename(columns = lambda x: re.sub('Total population','', x))
    dataset = dataset.rename(columns = lambda x: re.sub('AGE - 15 to 19 years','_15_19', x))
    dataset = dataset.rename(columns = lambda x: re.sub('AGE - 20 to 24 years','_20_24', x))
    dataset = dataset.rename(columns = {'Id': 'county_no', 'Total': 'total_gender'})    
    dataset = dataset.rename(columns = lambda x: x.lower())
    dataset = dataset.rename(columns = {'male': 'male_residents'})

    dataset['percent_male'] = (dataset['male_residents'] / dataset['total_gender']) * 100
            
    return dataset

def gender_race_age(filenames):
    full_data = pandas.DataFrame()
    
    for i, filename in enumerate(filenames):
        dataset = read_noheaders(filename)
        
        desired_cols = ['Id', 'Estimate; Total:', 'Estimate; Male:',
                        'Estimate; Male: - 18 and 19 years', 'Estimate; Male: - 20 to 24 years']
        dataset = dataset[desired_cols]
        
        dataset = dataset.rename(columns = {'Id': 'county_no'})
        dataset = dataset.rename(columns = lambda x: re.sub('Estimate; ','', x))
        dataset = dataset.rename(columns = lambda x: re.sub(':','', x))
        dataset = dataset.rename(columns = lambda x: re.sub(' - 18 and 19 years','_18_19', x))
        dataset = dataset.rename(columns = lambda x: re.sub(' - 20 to 24 years','_20_24', x))
        
        race = ['white', 'black'][i]
        
        dataset = dataset.rename(columns = lambda x: race + '_' + x)
        dataset = dataset.rename(columns = {race + '_county_no': 'county_no'})
        dataset = dataset.rename(columns = lambda x: x.lower())

        dataset[race + '_male_18_24'] = dataset[race + '_male_18_19'] + dataset[race + '_male_20_24']
        
        if full_data.empty:
            full_data = dataset.copy()
        else:
            full_data = pandas.merge(full_data, dataset, how = 'outer', on = 'county_no')

    return full_data

def clean_inc(filename):
    dataset = read_noheaders(filename)

    rename_dict = {'Id': 'county_no', 'Total; Estimate; All households':'total_inc_households',
    'Mean income (dollars); Estimate; All households':'mean_inc'}
    dataset = dataset.rename(columns = rename_dict)
    dataset = dataset[rename_dict.values()]
    
    return dataset

def race_inc(black_file, white_file):
    full_data = read_noheaders(black_file)
    white_data = read_noheaders(white_file)
    
    def rename_inc(dataset):
        rename_dict = {'Id':'county_no', 'Estimate; Total:':'inc_households',
                       'Estimate; Total: - Less than $10,000':'inc_under10',
                       'Estimate; Total: - $10,000 to $14,999':'inc_10to15',
                       'Estimate; Total: - $15,000 to $19,999':'inc_15to20',
                       'Estimate; Total: - $20,000 to $24,999':'inc_20to25',
                       'Estimate; Total: - $25,000 to $29,999':'inc_25to30',
                       'Estimate; Total: - $30,000 to $34,999':'inc_30to35',
                       'Estimate; Total: - $35,000 to $39,999':'inc_35to40',
                       'Estimate; Total: - $40,000 to $44,999':'inc_40to45',
                       'Estimate; Total: - $45,000 to $49,999':'inc_45to50',
                       'Estimate; Total: - $50,000 to $59,999':'inc_50to60',
                       'Estimate; Total: - $60,000 to $74,999':'inc_60to75',
                       'Estimate; Total: - $75,000 to $99,999':'inc_75to100',
                       'Estimate; Total: - $100,000 to $124,999':'inc_100to125',
                       'Estimate; Total: - $125,000 to $149,999':'inc_125to150',
                       'Estimate; Total: - $150,000 to $199,999':'inc_150to200',
                       'Estimate; Total: - $200,000 or more':'inc_200more'}

        dataset = dataset.rename(columns = rename_dict)
        dataset = dataset[rename_dict.values()]
        return dataset

    full_data = rename_inc(full_data)
    white_data = rename_inc(white_data)

    full_data = full_data.rename(columns = lambda x: 'b' + x)
    full_data = full_data.rename(columns = {'bcounty_no': 'county_no'})

    white_data = white_data.rename(columns = lambda x: 'w' + x)
    white_data = white_data.rename(columns = {'wcounty_no': 'county_no'})

    full_data = pandas.merge(full_data, white_data, how = 'outer', on = 'county_no')
    
    for race in ['b', 'w']:
        # Under 10K
        full_data.loc[full_data[race + 'inc_households'] != 0, race + 'inc_under10_percent'] = (full_data[race + 'inc_under10'] / full_data[race + 'inc_households']) * 100

        # Under 20K
        full_data.loc[full_data[race + 'inc_households'] != 0, race + 'inc_under20'] = full_data[race + 'inc_under10'] + full_data[race + 'inc_10to15'] + full_data[race + 'inc_15to20']
        full_data.loc[full_data[race + 'inc_households'] != 0, race + 'inc_under20_percent'] = (full_data[race + 'inc_under20'] / full_data[race + 'inc_households']) * 100

        # Under 40K        
        full_data.loc[full_data[race + 'inc_households'] != 0, race + 'inc_under40'] = full_data[race + 'inc_under10'] + full_data[race + 'inc_10to15']             + full_data[race + 'inc_15to20'] + full_data[race + 'inc_20to25'] + full_data[race + 'inc_25to30']             + full_data[race + 'inc_30to35'] + full_data[race + 'inc_35to40']
        full_data.loc[full_data[race + 'inc_households'] != 0, race + 'inc_under40_percent'] = (full_data[race + 'inc_under40'] / full_data[race + 'inc_households'])* 100
    
    return full_data

def emp(filename):
    """ Total and black and white unemployment rates """
    dataset = read_noheaders(filename)
    
    total_name = 'Unemployment rate; Estimate; Population 16 years and over'
    unemp_name = 'Unemployment rate; Estimate; RACE AND HISPANIC OR LATINO ORIGIN - One race'
    w_unemp = unemp_name + ' - White'
    b_unemp = unemp_name + ' - Black or African American'

    desired_cols = ['Id', total_name, unemp_name, w_unemp, b_unemp]
    dataset = dataset[desired_cols]
    dataset = dataset.rename(columns = {'Id': 'county_no', total_name: 'total_unemp',
                                              unemp_name: 'one_race_unemp', w_unemp: 'w_unemp',
                                              b_unemp: 'b_unemp'})

    dataset = dataset.rename(columns = lambda x: x.lower())
    return dataset

def read_noheaders(filename):
    return pandas.read_csv(filename, skiprows = 1)

if __name__ == '__main__':
    main()