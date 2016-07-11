"""
Uses pandas, combines clean_merged.py and clean_merged_grouping.py
INCOMPLETE!! Stuck on victim vars
This file cleans the data merged previously
"""

import pandas
import numpy
import clean_lemas
from charge_dict import *
import datetime
import dateutil.parser

def main():
    data_directory = '../../Data/'
    infile = data_directory + 'offenders_lemas_acs_2013.csv'
    outfile = data_directory + 'offenders_lemas_acs_2013_clean.csv'

    dataset = fix_thousands(dataset)

    dataset = pandas.read_csv(infile)
    dataset = lemas_grouping(dataset)
    dataset.to_csv(outfile, header = True, index = False)


    headers = find_headers(infile)
    headers += ['offense_' + value for value in charge_dict.values()]
    headers += ['arrest_' + value for value in charge_dict.values()]
    headers += ['proactive', 'reactive', 'arrested', 'black_not_white', 'racial_minority', 'incident_to_arrest_days', 'report_to_arrest_days']
    headers += ['bdgt_per_ftoff', 'w_officers_percent', 'b_officers_percent', 'wofficers_divres', 'bofficers_divres',
    'male_officers_percent', 'male_officers_ft_percent', 'min_hiring_educ', 'min_hiring_educ_gths']
    headers += ['victim_analyzing', 'victim_analyzing_sex', 'victim_analyzing_age', 'victim_analyzing_race', 'victim_analyzing_black_not_white',
    'victim_analyzing_interracial', 'victim_analyzing_relationship', 'victim_analyzing_known']

    if 'male_residents' not in headers:
        headers.remove('male')
        headers += ['male_residents']
    headers.sort()

    with open(outfile, 'w') as outf:
        writer = csv.DictWriter(outf, fieldnames = headers)
        writer.writeheader()

        with open(infile, 'r') as f:
            reader = csv.DictReader(f)
            for row in reader:
                row = convert_numeric(row)
                row = fix_thousands(row)
                row = code_offenses(row)
                row = offender_race(row)
                row = clean_lemas.main(row)
                row = clean_dates(row)
                row = victim_vars(row)                
                writer.writerow(row)

def fix_thousands(dataset):
    thouvars = ['mean_inc', 'total_residents', 'male_residents', 'black_male', 'white_male', 'black_male_18_19', 'white_male_18_19',
    'male_15_19', 'male_20_24', 'black_male_20_24', 'white_male_20_24', 'black_male_18_24', 'white_male_18_24',
    'pay_sal_ofcr_min', 'pay_sal_ofcr_max', 'pay_sal_sgt_min', 'pay_sal_sgt_max', 'pay_sal_exc_min', 'pay_sal_exc_max']

    for var in thouvars:
        dataset[var] = dataset[var].astype(float)

    dataset['bdgt_ttl'] = dataset['bdgt_ttl'].astype(float)
    dataset['ftsworn'] = dataset['ftsworn'].astype(float)

    dataset.loc[dataset['bdgt_ttl'] != 0, 'bdgt_per_ftoff'] = dataset.loc[dataset['bdgt_ttl'] != 0, 'bdgt_ttl'] / \
    dataset.loc[dataset['bdgt_ttl'] != 0, 'ftsworn']

    return dataset

def code_offenses(dataset):
    for var in ['offense_' + value for value in charge_dict.values()] + ['arrest_' + value for value in charge_dict.values()]:
        dataset[var] = None

    ucr_offense_code1 = ucr_offense_code2 = ucr_offense_code3 = ucr_arrest_offense_code = None
    offense_vars = {'ucr_offense_code1', 'ucr_offense_code2', 'ucr_offense_code3'}

    for offense_var in offense_vars:
        offense_value = row[offense_var]
        offense_text = charge_dict.get(offense_value, None)
        if offense_text:
            clean_row['offense_' + offense_text] = 1
    
    arrest_var = 'ucr_arrest_offense_code'
    arrest_value = row[arrest_var]
    arrest_text = charge_dict.get(arrest_value, None)
    if arrest_text:
        clean_row['arrest_' + arrest_text] = 1

    proactive_vars = ['offense_' + var for var in ['drugs_narcotics', 'drug_equipment', 'prostitution']]
    reactive_vars = ['offense_' + var for var in ['murder', 'robbery', 'burglary', 'auto_theft', 'embezzlement', 'arson']]

    for proactive_var in proactive_vars:
        if clean_row[proactive_var] == 1:
            clean_row['proactive'] = 1
            break

    for reactive in reactive_vars:
        if clean_row[reactive] == 1:
            clean_row['reactive'] = 1
            break

    clean_row['arrested'] = 0
    if row['ucr_arrest_offense_code'] > 0:
        clean_row['arrested'] = 1

    return clean_row

def offender_race(dataset):
    dataset.loc[dataset['black'] == 1, 'black_not_white'] = 1
    dataset.loc[dataset['white'] == 1, 'black_not_white'] = 0

    # If any race other than white alone is found, count as racial minority
    dataset.loc[dataset['race'].notnull(), 'racial_minority'] = 1
    dataset.loc[dataset['black_not_white'] == 0, 'racial_minority'] = 0

    return dataset

def clean_dates(dataset):
    dataset['incident_date'] = pandas.to_datetime(dataset['incident_date'], errors = 'coerce', format = '')
    dataset['report_date'] = pandas.to_datetime(dataset['report_date'], errors = 'coerce', format = '')
    dataset['arrest_date'] = pandas.to_datetime(dataset['arrest_date'], errors = 'coerce', format = '')

    dataset['incident_to_arrest_days'] = (dataset['arrest_date'] - dataset['incident_date']).days
    dataset['report_to_arrest_days'] = (dataset['arrest_date'] - dataset['report_date']).days

    return dataset

def victim_vars(row):
    # which victim is the first human victim recorded
    dataset.loc['victim1_type'] == 1, 'victim_analyzing'] = 1
    dataset.loc['victim2_type'] == 1, 'victim_analyzing'] = 2
    dataset.loc['victim3_type'] == 1, 'victim_analyzing'] = 3

    dataset.loc[dataset['victim_analyzing'] == 1, 'victim_analyzing_sex'] = dataset.loc[dataset['victim_analyzing'] == 1, 'victim1_sex']
    dataset.loc[dataset['victim_analyzing'] == 2, 'victim_analyzing_sex'] = dataset.loc[dataset['victim_analyzing'] == 2, 'victim2_sex']
    dataset.loc[dataset['victim_analyzing'] == 3, 'victim_analyzing_sex'] = dataset.loc[dataset['victim_analyzing'] == 3, 'victim3_sex']

    dataset.loc[dataset['victim_analyzing'] == 1, 'victim_analyzing_age'] = dataset.loc[dataset['victim_analyzing'] == 1, 'victim1_age']
    dataset.loc[dataset['victim_analyzing'] == 2, 'victim_analyzing_age'] = dataset.loc[dataset['victim_analyzing'] == 2, 'victim2_age']
    dataset.loc[dataset['victim_analyzing'] == 3, 'victim_analyzing_age'] = dataset.loc[dataset['victim_analyzing'] == 3, 'victim3_age']

    dataset.loc[dataset['victim_analyzing'] == 1, 'victim_analyzing_race'] = dataset.loc[dataset['victim_analyzing'] == 1, 'victim1_race']
    dataset.loc[dataset['victim_analyzing'] == 2, 'victim_analyzing_race'] = dataset.loc[dataset['victim_analyzing'] == 2, 'victim2_race']
    dataset.loc[dataset['victim_analyzing'] == 3, 'victim_analyzing_race'] = dataset.loc[dataset['victim_analyzing'] == 3, 'victim3_race']

    dataset.loc[dataset['victim_analyzing_race'] == 'black', 'victim_analyzing_black_not_white'] = 1
    dataset.loc[dataset['victim_analyzing_race'] == 'white', 'victim_analyzing_black_not_white'] = 0

    # Whether victim and offender are white and black or both white or both black
    dataset['victim_analyzing_interracial'] = (dataset['victim_analyzing_black_not_white'] == dataset['black_not_white']).astype(float)
    dataset.loc[dataset['victim_analyzing_black_not_white'].isnull(), 'victim_analyzing_interracial'] = numpy.nan
    dataset.loc[dataset['black_not_white'].isnull(), 'victim_analyzing_interracial'] = numpy.nan
    
    # whether the victim knew the offender
    dataset.loc[dataset['victim_analyzing'] == 1, 'victim_analyzing_offender1_seqno'] = dataset.loc[dataset['victim_analyzing'] == 1, 'victim1_offender1_seqno']
    dataset.loc[dataset['victim_analyzing'] == 2, 'victim_analyzing_offender1_seqno'] = dataset.loc[dataset['victim_analyzing'] == 1, 'victim2_offender1_seqno']
    dataset.loc[dataset['victim_analyzing'] == 3, 'victim_analyzing_offender1_seqno'] = dataset.loc[dataset['victim_analyzing'] == 1, 'victim3_offender1_seqno']

    dataset.loc[dataset['victim_analyzing'] == 1, 'victim_analyzing_offender2_seqno'] = dataset.loc[dataset['victim_analyzing'] == 1, 'victim1_offender2_seqno']
    dataset.loc[dataset['victim_analyzing'] == 2, 'victim_analyzing_offender2_seqno'] = dataset.loc[dataset['victim_analyzing'] == 1, 'victim2_offender2_seqno']
    dataset.loc[dataset['victim_analyzing'] == 3, 'victim_analyzing_offender2_seqno'] = dataset.loc[dataset['victim_analyzing'] == 1, 'victim3_offender2_seqno']

    dataset.loc[dataset['victim_analyzing'] == 1, 'victim_analyzing_offender3_seqno'] = dataset.loc[dataset['victim_analyzing'] == 1, 'victim1_offender3_seqno']
    dataset.loc[dataset['victim_analyzing'] == 2, 'victim_analyzing_offender3_seqno'] = dataset.loc[dataset['victim_analyzing'] == 1, 'victim2_offender3_seqno']
    dataset.loc[dataset['victim_analyzing'] == 3, 'victim_analyzing_offender3_seqno'] = dataset.loc[dataset['victim_analyzing'] == 1, 'victim3_offender3_seqno']



    if offender_seqno == victim_offender1_seqno:
        victim_analyzing_relationship = row['victim' + str(victim_number) + '_offender' + str(1) + '_relationship']
    if offender_seqno == victim_offender2_seqno:
        victim_analyzing_relationship = row['victim' + str(victim_number) + '_offender' + str(2) + '_relationship']
    if offender_seqno == victim_offender3_seqno:
        victim_analyzing_relationship = row['victim' + str(victim_number) + '_offender' + str(3) + '_relationship']
    row['victim_analyzing_relationship'] = victim_analyzing_relationship

    if victim_analyzing_relationship == 25:
        row['victim_analyzing_known'] = 0
    elif victim_analyzing_relationship > 0 and victim_analyzing_relationship < 25:
        row['victim_analyzing_known'] = 1

    return row

def lemas_grouping(dataset):
    agency_data = dataset.groupby('ori')
    zipcode_data = dataset.groupby('zipcode')

    agency_offenders_count = agency_data['arrested'].count().reset_index()
    agency_offenders_count = agency_offenders_count.rename(columns = {'arrested': 'agency_offenders_count'})

    agency_arrestees_count = agency_data['arrested'].sum().reset_index()
    agency_arrestees_count = agency_arrestees_count.rename(columns = {'arrested': 'agency_arrestees_count'})

    zipcode_offenders_count = zipcode_data['arrested'].count().reset_index()
    zipcode_offenders_count = zipcode_offenders_count.rename(columns = {'arrested': 'zipcode_offenders_count'})

    zipcode_arrestees_count = zipcode_data['arrested'].sum().reset_index()
    zipcode_arrestees_count = zipcode_arrestees_count.rename(columns = {'arrested': 'zipcode_arrestees_count'})

    zipcode_bdgt = zipcode_data['bdgt_ttl'].mean().reset_index()
    zipcode_bdgt = zipcode_bdgt.rename(columns = {'bdgt_ttl': 'zipcode_bdgt'})

    dataset = dataset.merge(agency_offenders_count, on = ['ori'], how = 'outer')
    dataset = dataset.merge(agency_arrestees_count, on = ['ori'], how = 'outer')
    dataset = dataset.merge(zipcode_offenders_count, on = ['zipcode'], how = 'outer')
    dataset = dataset.merge(zipcode_arrestees_count, on = ['zipcode'], how = 'outer')
    dataset = dataset.merge(zipcode_bdgt, on = ['zipcode'], how = 'outer')
    
    dataset['agency_bdgt_per_offender'] = (dataset['bdgt_ttl'] * 1000000) / dataset['agency_offenders_count']
    dataset['agency_bdgt_per_arrestee'] = (dataset['bdgt_ttl'] * 1000000) / dataset['agency_arrestees_count']
    dataset['zipcode_offenders_per_resident'] = dataset['zipcode_offenders_count'] / (dataset['total_residents'] * 1000)
    dataset['zipcode_arrestees_per_resident'] = dataset['zipcode_arrestees_count'] / (dataset['total_residents'] * 1000)
    dataset['zipcode_bdgt_per_resident'] = (dataset['zipcode_bdgt'] * 1000000) / (dataset['total_residents'] * 1000)

    return dataset

if __name__ == '__main__':
    main()