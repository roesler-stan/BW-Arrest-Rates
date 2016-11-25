""" Merge datasets using sqlite3
To do this locally, change the filenames to being in directory = '../../Data/' and needed subdirectories 
"""

import sqlite3
import csv
import os
import re
import calendar

def main():
    database_file = 'nibrs.db'
    outfile = 'offenders_2013_caplg_ucr.csv'

    nibrs_file = 'offenders_2013.csv'
    crosswalk_agencies_file = 'crosswalk_agencies.csv'
    lemas_file = 'lemas_13_clean.csv'
    acs_file = 'acs_counties_13.csv'
    pres12_file = 'pres12_counties.csv'
    governors_file = 'governors_2015.csv'
    ucr13_file = 'ucr13_arrests_offenses.csv'

    # Delete old versions of the database file
    if os.path.exists(database_file):
        os.remove(database_file)

    conn = sqlite3.connect(database_file)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    setup_offenders_table(c, nibrs_file, 'offenders_2013')

    setup_table(c, crosswalk_agencies_file, 'crosswalk_agencies', 'cw_ori9', 'ori9')
    setup_table(c, acs_file, 'acs_counties_13', 'acs_county_no', 'county_no')
    setup_table(c, lemas_file, 'lemas_2013', 'lemas_ori9', 'ori9')
    setup_table(c, pres12_file, 'pres12_counties', 'pres12_county_no', 'county_no')
    setup_table(c, governors_file, 'governors_2015', 'state_gov', 'state')

    setup_table(c, ucr13_file, 'ucr13_arrests_offenses', 'ucr13_ori7', 'ori')
    conn.commit()

    ucr_small(c, 'ucr13_arrests_offenses', 'ucr13_arrests_offenses_small')

    merge_datasets(c)

    save_table('offenders_2013_caplg_ucr', outfile, c)

    conn.commit()
    conn.close()

def save_table(table_name, outfile, c):
    c.execute('select * from ' + table_name)
    with open(outfile, "w") as csv_file:
        headers = [i[0] for i in c.description]
        writer = csv.DictWriter(csv_file, fieldnames = headers)
        writer.writeheader()
        for row in c:
            writer.writerow(dict(row))

def merge_datasets(c):
    # Add crosswalk data by agency to get cw_ori7
    c.execute('''CREATE TABLE offenders_2013_cw AS
    SELECT * FROM offenders_2013 LEFT OUTER JOIN crosswalk_agencies
    ON offenders_2013.ori = crosswalk_agencies.cw_ori9''')

    # Add an index just to check that there is only one row per offender
    c.execute(''' CREATE INDEX offender_id_cw ON offenders_2013_cw (offender_id) ''')

    print 'made offenders_2013_cw'

    # Add ACS county demographics
    c.execute('''CREATE TABLE offenders_2013_c_acs AS
    SELECT * FROM offenders_2013_cw LEFT OUTER JOIN acs_counties_13 ON
    offenders_2013_cw.fips_county1_no = acs_counties_13.acs_county_no''')

    print 'made offenders_2013_c_acs'
    # Add voting data by county
    c.execute('''CREATE TABLE offenders_2013_ca_pres12 AS
    SELECT * FROM offenders_2013_c_acs LEFT OUTER JOIN pres12_counties
    ON offenders_2013_c_acs.fips_county1_no = pres12_counties.pres12_county_no''')
    
    print 'made offenders_2013_ca_pres12'
    # Add LEMAS data by ORI
    c.execute('''CREATE TABLE offenders_2013_cap_lemas AS
    SELECT * FROM offenders_2013_ca_pres12 LEFT OUTER JOIN lemas_2013 ON
    offenders_2013_ca_pres12.ori = lemas_2013.lemas_ori9''')
    
    print 'made offenders_2013_capl_gov'
    # Add governors data by state name
    c.execute('''CREATE TABLE offenders_2013_capl_gov AS
    SELECT * FROM offenders_2013_cap_lemas LEFT OUTER JOIN governors_2015 ON
    offenders_2013_cap_lemas.state_name = governors_2015.state_gov''')
    
    # Add an index just to check that there is only one row per offender
    c.execute(''' CREATE INDEX offender_id_capl_gov ON offenders_2013_capl_gov (offender_id) ''')

    print 'about to make offenders_2013_caplg_ucr'
    # Add UCR arrests-offenders data by ORI7 from crosswalk
    c.execute('''CREATE TABLE offenders_2013_caplg_ucr AS SELECT * FROM offenders_2013_capl_gov LEFT OUTER JOIN ucr13_arrests_offenses_small ON offenders_2013_capl_gov.cw_ori7 = ucr13_arrests_offenses_small.ucr13_ori7''')

    # Add an index just to check that there is only one row per offender
    c.execute(''' CREATE INDEX offender_id_caplg_ucr ON offenders_2013_caplg_ucr (offender_id) ''')
    
def ucr_small(c, table_orig, table_small):
    offenses = ['murder', 'rape', 'robbery', 'aggravated_assault', 'burglary', 'larceny', 'motor_vehicle_theft']
    offenses_total = [offense + '_offenses_total' for offense in offenses]
    arrests_total = [offense + '_arrests_total' for offense in offenses]

    races = ['black', 'white', 'asian', 'indian', 'hispanic', 'nonhispanic']
    race_percent = [race + '_arrests_percent' for race in races]

    keys = ['ori', 'total_arrests', 'total_offenses_offenses_total']
    keys.extend(race_percent)
    keys.extend(offenses_total)
    keys = ['ucr13_' + key + '7' if key == 'ori' else 'ucr13_' + key for key in keys]

    keys_string = ', '.join(keys)
    query_text = 'CREATE TABLE ' + table_small + ' AS SELECT ' + keys_string + ' FROM ' + table_orig
    c.execute(query_text)

def setup_offenders_table(c, infile, table_name):
    """ Create table and insert data """
    with open(infile, 'r') as f:
        reader = csv.DictReader(f)
        row = reader.next()

    primary_key = 'offender_id'
    keys = name_columns(infile, row)
    keys.append(primary_key)
    create_table(c, keys, table_name, primary_key)

    with open(infile, 'r') as f:
        reader = csv.DictReader(f)
        for row_number, row in enumerate(reader):
            row = fix_county_no(row)
            values = row.values()
            values.append(row_number)
            insert_row(c, values, table_name)

def fix_county_no(row):
    """ Fix leading-zero problem with county_no """
    for key in row.keys():
        if 'county' in key and '_no' in key:
            county_no = row[key]
            county_no_clean = (5 - len(county_no)) * '0' + county_no
            row[key] = county_no_clean
    return row

def setup_table(c, infile, table_name, primary_key, primary_key_orig):
    """ Create table and insert data
    Check that the row has the original primary key, then use the new primary key name """
    with open(infile, 'r') as f:
        reader = csv.DictReader(f)
        row = reader.next()

    keys = name_columns(infile, row)
    create_table(c, keys, table_name, primary_key)

    with open(infile, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            # Skip any row with a missing primary key
            if not row[primary_key_orig]:
                continue
            values = row.values()
            insert_row(c, values, table_name)

def create_table(c, keys, table_name, primary_key):
    """ Create a table with the given name and primary key """
    if primary_key == 'offender_id':
        keys = [key + ' INTEGER PRIMARY KEY, ' if key == primary_key else key + ' text, ' for key in keys]
    else:
        keys = [key + ' text PRIMARY KEY, ' if key == primary_key else key + ' text, ' for key in keys]
    table_vars = ''.join(keys)
    table_vars = table_vars.rsplit(', ', 1)[0]
    table_vars = '(' + table_vars + ')'
    c.execute("CREATE TABLE " + table_name + " " + table_vars)

def insert_row(c, values, table_name):
    values_tuple = (tuple(values), )
    question_marks = ','.join(['?'] * len(values))
    c.executemany('INSERT INTO ' + table_name + ' VALUES (' + question_marks + ')', values_tuple)

def name_columns(infile, row):
    """ Fix column names for each table to enable merging later """
    keys = row.keys()

    if 'lemas_13_clean' in infile:
        keys = ['lemas_statename' if key == 'statename' else key for key in keys]
        keys = ['lemas_statecode' if key == 'statecode' else key for key in keys]
        keys = ['lemas_ori9' if key == 'ori9' else key for key in keys]

    if 'acs_counties_13' in infile:
        keys = ['acs_county_no' if key == 'county_no' else key for key in keys]

    if 'pres12_counties' in infile:
        keys = ['pres12_' + key for key in keys]

    if 'governors_2015' in infile:
        keys = ['state_gov' if key == 'state' else key for key in keys]
        keys = ['gov15_party' if key == 'party' else key for key in keys]

    if 'ucr13_arrests_offenses' in infile:
        keys = ['ucr13_' + key + '7' if key == 'ori' else 'ucr13_' + key for key in keys]

    if 'crosswalk_agencies' in infile:
        keys = ['cw_' + key for key in keys]

    return keys

if __name__ == '__main__':
    main()