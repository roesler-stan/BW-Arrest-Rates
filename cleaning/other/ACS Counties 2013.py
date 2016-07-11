import pandas
import re

def main():
    outfile = '../../../Data/SQL Input/acs_counties_13.csv'
    raw_acs_directory = '../../../Data/ACS County/'

    race_filename = raw_acs_directory + 'Race 5Y 2013/ACS_race_residents.csv'
    gender_filename = raw_acs_directory + 'Gender Age 5Y 2013/ACS_13_5YR_S0101_with_ann.csv'

    gender_race_orig = ['white_only.csv', 'black_only.csv', 'amind_only.csv',         'asian_only.csv', 'hawaii_only.csv', 'other_only.csv']
    gender_race_filenames = [raw_acs_directory + 'Race Gender 5Y 2013/' + f for f in gender_race_orig]
    
    inc_filename = raw_acs_directory + 'Income 5Y 2013/acs_inc_0913.csv'
    
    race_directory = raw_acs_directory + 'Income Race 5Y 2013/'
    black_file = race_directory + 'acs_black_inc12.csv'
    white_file = race_directory + 'acs_white_inc12.csv'
    
    gender_inc_filename = raw_acs_directory + 'Income Gender 5Y 2013/ACS_13_5YR_B19215_with_ann.csv'
    emp_filename = raw_acs_directory + 'Employment 5Y 2013/ACS_13_5YR_S2301_with_ann.csv'
    emp_gender_filename = raw_acs_directory + 'Employment Gender 5Y 2013/ACS_13_5YR_S2401_with_ann.csv'
    
    gender_race_emp_directory = raw_acs_directory + 'Employment Gender Race 5Y 2013/'
    gender_race_emp_filenames = [gender_race_emp_directory + f for f in ['white_only.csv', 'black_only.csv']]
    
    # Residents for all racial groups (B02001)
    full_data = pandas.read_csv(race_filename)
    full_data = clean_race(full_data)
        
    # Residents for men, by age (S0101)
    gender_age_data = gender_age(gender_filename)
    full_data = pandas.merge(full_data, gender_age_data, how = 'outer', on = 'county_no')
        
    # Residents for black and white men, and by young age groups (B01001)
    gender_race_data = gender_race(gender_race_filenames)
    full_data = pandas.merge(full_data, gender_race_data, how = 'outer', on = 'county_no')

    # Income - total (DP03)
    inc_data = pandas.read_csv(inc_filename)
    full_data = pandas.merge(full_data, inc_data, how = 'outer', on = 'county_no')
    
    # Income for black and white people (B19001)
    race_inc_data = race_inc(black_file, white_file)
    full_data = pandas.merge(full_data, race_inc_data, how = 'outer', on = 'county_no')
    
    # Income for men and women (B19215)
    gender_inc_data = gender_inc(gender_inc_filename)
    full_data = pandas.merge(full_data, gender_inc_data, how = 'outer', on = 'county_no')
    
    # Income for black and white men - no data
    
    # Unemployment - total and for black and white people (S2301)
    emp_data = emp(emp_filename)
    full_data = pandas.merge(full_data, emp_data, how = 'outer', on = 'county_no')

    # Employment for men (S2401)
    emp_gender_data = emp_gender(emp_gender_filename)
    full_data = pandas.merge(full_data, emp_gender_data, how = 'outer', on = 'county_no')    
    
    # Employment for black and white men (B20005)
    gender_race_emp_data = gender_race_emp(gender_race_emp_filenames)
    full_data = pandas.merge(full_data, gender_race_emp_data, how = 'outer', on = 'county_no')

    full_data = make_floats(full_data)
    
    full_data['county_no'] = full_data['county_no'].astype(str)
    full_data['county_no'] = full_data['county_no'].map(make_county)
    
    full_data.to_csv(outfile, header = True, index = False, quotechar = '"')

def make_county(county_string):
    if len(county_string) == 3:
        county_string = '00' + county_string

    if len(county_string) == 4:
        county_string = '0' + county_string
        
    return county_string

def gender_age(filename):
    clean_data = read_noheaders(filename)
        
    desired_cols = ['Id2', 'Total; Estimate; Total population', 'Male; Estimate; Total population',
                    'Total; Estimate; AGE - 15 to 19 years', 'Male; Estimate; AGE - 15 to 19 years',
                    'Total; Estimate; AGE - 20 to 24 years', 'Male; Estimate; AGE - 20 to 24 years']                    
    clean_data = clean_data[desired_cols]
    
    clean_data = clean_data.rename(columns = lambda x: re.sub('; Estimate; ','', x))
    clean_data = clean_data.rename(columns = lambda x: re.sub('Total population','', x))
    clean_data = clean_data.rename(columns = lambda x: re.sub('AGE - 15 to 19 years','_15_19', x))
    clean_data = clean_data.rename(columns = lambda x: re.sub('AGE - 20 to 24 years','_20_24', x))
    clean_data = clean_data.rename(columns = {'Id2': 'county_no', 'Total': 'total_gender'})    
    clean_data = clean_data.rename(columns = lambda x: x.lower())

    clean_data = make_floats(clean_data)
    clean_data['percent_male'] = (clean_data['male'] / clean_data['total_gender']) * 100
            
    return clean_data

def race_inc(black_file, white_file):   
    full_data = pandas.read_csv(black_file)
    white_data = pandas.read_csv(white_file)
    
    full_data = full_data.rename(columns = lambda x: 'b' + x)
    full_data = full_data.rename(columns = {'bcounty_no': 'county_no'})

    white_data = white_data.rename(columns = lambda x: 'w' + x)
    white_data = white_data.rename(columns = {'wcounty_no': 'county_no'})

    full_data = pandas.merge(full_data, white_data, how = 'outer', on = 'county_no')
    
    for race in ['b', 'w']:
        # Under 10K
        full_data.loc[full_data[race + 'inc_total'] != 0, race + 'inc_under10_percent'] = (full_data[race + 'inc_under10'] / full_data[race + 'inc_total']) * 100

        # Under 20K
        full_data.loc[full_data[race + 'inc_total'] != 0, race + 'inc_under20'] = full_data[race + 'inc_under10'] + full_data[race + 'inc_10to15'] + full_data[race + 'inc_15to20']
        full_data.loc[full_data[race + 'inc_total'] != 0, race + 'inc_under20_percent'] = (full_data[race + 'inc_under20'] / full_data[race + 'inc_total']) * 100

        # Under 40K        
        full_data.loc[full_data[race + 'inc_total'] != 0, race + 'inc_under40'] = full_data[race + 'inc_under10'] + full_data[race + 'inc_10to15']             + full_data[race + 'inc_15to20'] + full_data[race + 'inc_20to25'] + full_data[race + 'inc_25to30']             + full_data[race + 'inc_30to35'] + full_data[race + 'inc_35to40']
        full_data.loc[full_data[race + 'inc_total'] != 0, race + 'inc_under40_percent'] = (full_data[race + 'inc_under40'] / full_data[race + 'inc_total'])* 100

    full_data['bwinc_under40_pdiff'] = full_data['binc_under40_percent'] - full_data['winc_under40_percent']
    full_data['bwinc_under20_pdiff'] = full_data['binc_under20_percent'] - full_data['winc_under20_percent']
    
    return full_data

def gender_inc(filename):
    clean_data = pandas.read_csv(filename)
    clean_data = make_floats(clean_data)
            
    return clean_data

def gender_race(filenames):
    full_data = pandas.DataFrame()
    
    for filename in filenames:
#         filename = directory + filename
        clean_data = read_noheaders(filename)
        
        desired_cols = ['Id2', 'Estimate; Total:', 'Estimate; Male:',
                        'Estimate; Male: - 18 and 19 years', 'Estimate; Male: - 20 to 24 years']
        clean_data = clean_data[desired_cols]
        
        clean_data = clean_data.rename(columns = {'Id2': 'county_no'})
        clean_data = clean_data.rename(columns = lambda x: re.sub('Estimate; ','', x))
        clean_data = clean_data.rename(columns = lambda x: re.sub(':','', x))
        clean_data = clean_data.rename(columns = lambda x: re.sub(' - 18 and 19 years','_18_19', x))
        clean_data = clean_data.rename(columns = lambda x: re.sub(' - 20 to 24 years','_20_24', x))
        
        f_race = filename.split('_only')[0].split('/')[-1]
        race_dict = {'white': 'w', 'black': 'b', 'amind': 'ai', 'asian': 'a',
                     'hawaii': 'hw', 'other': 'o'}
        race = race_dict[f_race]
        
        clean_data = clean_data.rename(columns = lambda x: race + '_' + x)
        clean_data = clean_data.rename(columns = {race + '_county_no': 'county_no'})
        clean_data = clean_data.rename(columns = lambda x: x.lower())

        clean_data = make_floats(clean_data)

        clean_data[race + '_male_18_24'] = clean_data[race + '_male_18_19'] + clean_data[race + '_male_20_24']
        
        if full_data.empty:
            full_data = clean_data.copy()
        else:
            full_data = pandas.merge(full_data, clean_data, how = 'outer', on = 'county_no')

    return full_data

# Total and Black and White unemployment rates
def emp(filename):
    clean_data = read_noheaders(filename)
    
    total_name = 'Unemployment rate; Estimate; Population 16 years and over'
    unemp_name = 'Unemployment rate; Estimate; RACE AND HISPANIC OR LATINO ORIGIN - One race'
    w_unemp = unemp_name + ' - White'
    b_unemp = unemp_name + ' - Black or African American'

    desired_cols = ['Id2', total_name, unemp_name, w_unemp, b_unemp]
    clean_data = clean_data[desired_cols]
    clean_data = clean_data.rename(columns = {'Id2': 'county_no', total_name: 'total_unemp',
                                              unemp_name: 'one_race_unemp', w_unemp: 'w_unemp',
                                              b_unemp: 'b_unemp'})

    clean_data = clean_data.rename(columns = lambda x: x.lower())

    return clean_data

# Men's full-time employment rates
def emp_gender(raw_acs_directory):
    clean_data = read_noheaders(filename)

    male_emp = 'Male; Estimate; Civilian employed population 16 years and over'
    desired_cols = ['Id2', male_emp]
    clean_data = clean_data[desired_cols]
    clean_data = clean_data.rename(columns = {'Id2': 'county_no', male_emp: 'male_worked_ft'})

    return clean_data

# B and W men's full-time employment rates
def gender_race_emp(filenames):    
    full_data = pandas.DataFrame()
    
    for filename in filenames:
        filename = directory + filename        
        clean_data = read_noheaders(filename)
        
        desired_cols = ['Id2', 'Estimate; Male:',
                        'Estimate; Male: - Worked full-time, year-round in the past 12 months: - With earnings:']

        clean_data = clean_data[desired_cols]
        clean_data = clean_data.rename(columns = {'Id2': 'county_no'})
        clean_data = clean_data.rename(columns=lambda x: re.sub('Estimate; ','', x))
        clean_data = clean_data.rename(columns=lambda x: re.sub(' - Worked full-time, year-round in the past 12 months: - With earnings:', '_worked_ft', x))
        clean_data = clean_data.rename(columns=lambda x: re.sub(':','', x))
        
        race = filename.split('_only')[0].split('/')[-1][0]
        clean_data = clean_data.rename(columns = lambda x: race + '_' + x)
        clean_data = clean_data.rename(columns = lambda x: x.lower())
        clean_data = clean_data.rename(columns = {race + '_county_no': 'county_no', race + '_male': race + '_male_empdata'})
        
        clean_data[race + '_male_empdata'] = clean_data[race + '_male_empdata'].astype(float)
        clean_data[race + '_male_worked_ft'] = clean_data[race + '_male_worked_ft'].astype(float)
        clean_data[race + '_m_unemp_ft'] = (clean_data[race + '_male_empdata'] - clean_data[race + '_male_worked_ft']) / clean_data[race + '_male_empdata']

        if full_data.empty:
            full_data = clean_data.copy()
        else:
            full_data = pandas.merge(full_data, clean_data, how = 'outer', on = 'county_no')

    return full_data

def read_noheaders(filename):
    dataset = pandas.read_csv(filename, skiprows = 1)
    return dataset

def make_floats(dataset):
    for col in dataset.columns:
        dataset[col] = dataset[col].convert_objects(convert_numeric=True)

    return dataset

# Calculating resident percentages
def clean_race(dataset):
    dataset.loc[dataset['total_residents'] != 0, 'b_residents_percent'] = (dataset.loc[dataset['total_residents'] != 0, 'b_residents']                 / dataset.loc[dataset['total_residents'] != 0, 'total_residents']) * 100
    
    dataset.loc[dataset['total_residents'] != 0, 'w_residents_percent'] =         (dataset.loc[dataset['total_residents'] != 0, 'w_residents'] /          dataset.loc[dataset['total_residents'] != 0, 'total_residents']) * 100
    
    dataset['bw_residents_pdiff'] = dataset['b_residents_percent'] - dataset['w_residents_percent']
    
    dataset.loc[dataset['w_residents'] != 0, 'bw_residents_ratio'] =         dataset.loc[dataset['w_residents'] != 0, 'b_residents'] / dataset.loc[dataset['w_residents'] != 0, 'w_residents']
    
    dataset['nonw_residents_percent'] = 100 - dataset['w_residents_percent']
    dataset['nonw_residents_percent_sq'] = dataset['nonw_residents_percent'] ** 2
    
    dataset['b_residents_percent_sq'] = dataset['b_residents_percent'] ** 2
    dataset['w_residents_percent_sq'] = dataset['w_residents_percent'] ** 2

    dataset['bw_residents_percent'] = dataset['b_residents_percent'] + dataset['w_residents_percent']

    dataset.loc[dataset['bw_residents_percent'] != 0, 'prop_residents_wnotb'] =         (dataset.loc[dataset['bw_residents_percent'] != 0, 'w_residents_percent'] /         dataset.loc[dataset['bw_residents_percent'] != 0, 'bw_residents_percent'] ) * 100
    
    return dataset