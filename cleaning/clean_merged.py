"""
This file cleans the data merged previously, row-wise
"""

import csv
import numpy
from charge_dict import *
import datetime
import dateutil.parser

def main():
    data_directory = '../../Data/'
    infile = data_directory + 'offenders_2013_caplg_ucr.csv'
    outfile = data_directory + 'offenders_2013_caplg_ucr_clean1.csv'

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
                row = clean_dates(row)
                row = victim_vars(row)                
                writer.writerow(row)

def fix_thousands(row):
    thouvars = ['mean_inc', 'total_residents', 'male_residents', 'pay_sal_ofcr_min', 'pay_sal_ofcr_max', 'pay_sal_sgt_min',
    'pay_sal_sgt_max', 'pay_sal_exc_min', 'pay_sal_exc_max']

    for var in thouvars:
        row[var] = force_float(row[var]) / 1000

    row['bdgt_ttl'] = force_float(row['bdgt_ttl'])
    row['ftsworn'] = force_float(row['ftsworn'])

    if row['ftsworn'] > 0:
        row['bdgt_per_ftoff'] = (row['bdgt_ttl'] * 1000 * 1000) / row['ftsworn']

    return row

def code_offenses(row):
    for var in ['offense_' + value for value in charge_dict.values()] + ['arrest_' + value for value in charge_dict.values()]:
        row[var] = None
    clean_row = row.copy()

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

def convert_numeric(row):
    """ Try to convert all values to float, or int if there are no decimals """
    clean_row = row.copy()
    for key in row.keys():
        if 'date' not in key or 'indicator' in key:
            try:
                clean_row[key] = float(row[key])
                if clean_row[key].is_integer():
                    clean_row[key] = int(clean_row[key])
            except ValueError:
                clean_row[key] = row[key]
    return clean_row

def offender_race(row):
    row['black_not_white'] = None
    row['racial_minority'] = None

    if row['race'] == 'black':
        row['black_not_white'] = 1
    elif row['race'] == 'white':
        row['black_not_white'] = 0
    
    # If any race other than white alone is found, count as racial minority
    if row['race']:
        row['racial_minority'] = 1
    elif row['black_not_white'] == 0:
        row['racial_minority'] = 0

    return row

def clean_dates(row):
    incident_date = make_date(row['incident_date'])
    report_date = make_date(row['report_date'])
    arrest_date = make_date(row['arrest_date'])

    if not isinstance(arrest_date, datetime.datetime):
        return row

    if isinstance(incident_date, datetime.datetime):
        row['incident_to_arrest_days'] = (arrest_date - incident_date).days

    if isinstance(report_date, datetime.datetime):
        row['report_to_arrest_days'] = (arrest_date - report_date).days

    return row

def victim_vars(row):
    # which victim is the first human victim recorded
    if row['victim1_type'] == 1:
        row['victim_analyzing'] = 1
    elif row['victim2_type'] == 1:
        row['victim_analyzing'] = 2
    elif row['victim3_type'] == 1:
        row['victim_analyzing'] = 3

    # if there wasn't a human victim, quit
    if not row.has_key('victim_analyzing'):
        return row

    victim_number = row['victim_analyzing']

    row['victim_analyzing_sex'] = row['victim' + str(victim_number) + '_sex']
    row['victim_analyzing_age'] = row['victim' + str(victim_number) + '_age']

    row['victim_analyzing_race'] = row['victim' + str(victim_number) + '_race']
    if row['victim_analyzing_race'] == 'black':
        row['victim_analyzing_black_not_white'] = 1
    elif row['victim_analyzing_race'] == 'white':
        row['victim_analyzing_black_not_white'] = 0

    # is it interracial - 0 if victim and offender are black or white, 1 if they are but not both the same
    if (row['black_not_white'] != None and row.has_key('victim_analyzing_black_not_white')) and (row['black_not_white'] == row['victim_analyzing_black_not_white']):
        row['victim_analyzing_interracial'] = 0
    if (row['black_not_white'] != None and row.has_key('victim_analyzing_black_not_white')) and (row['black_not_white'] != row['victim_analyzing_black_not_white']):
        row['victim_analyzing_interracial'] = 1
    
    # did the victim know the offender
    victim_offender1_seqno = row['victim' + str(victim_number) + '_offender1_seqno']
    victim_offender2_seqno = row['victim' + str(victim_number) + '_offender2_seqno']
    victim_offender3_seqno = row['victim' + str(victim_number) + '_offender3_seqno']

    offender_seqno = row['offender_seqno']
    victim_analyzing_relationship = None
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

def find_headers(filename):
    with open(filename, 'r') as f:
        reader = csv.DictReader(f)
        headers = reader.next().keys()

    return headers

def make_date(date):
    date_string = str(date)
    default_date = datetime.datetime(2030, 6, 15)
    try:
        date_found = dateutil.parser.parse(date_string, fuzzy = True, default = default_date)
    except:
        date_found = numpy.nan
    if date_found == default_date:
        date_found = numpy.nan
    return date_found

def force_float(var):
    """ Try to convert a string that may be a number to a float """
    try:
        var_float = float(var)
    except ValueError:
        var_float = numpy.nan
    return var_float

def counties(row):
    """ Count how many FIPS counties are listed in NIBRS for this agency """
    nonmissing_counties = 0
    county_variables = ['fips_county' + str(i) + '_no' for i in range(1, 6)]
    for county_variable in county_variables:
        county_value = row[county_variable]
        if county_value and county_value != '1':
            nonmissing_counties += 1

    row['fips_counties'] = nonmissing_counties
    return row

if __name__ == '__main__':
    main()