import sqlite3
import csv
import os
import re
import pandas
import calendar

def main():
    directory = '../../Data/'
    database_file = directory + 'nibrs.db'
    outfile = directory + 'offenders_lemas_acs_2013.csv'

    nibrs_file = directory + 'offenders_2013.csv'
    crosswalk_agencies_file = directory + 'crosswalk_agencies.csv'
    lemas_file = directory + 'lemas_13_clean.csv'
    acs_file = directory + 'acs_counties_13.csv'
    pres12_file = directory + 'pres12_counties.csv'
    governors_file = directory + 'governors/governors_2015.csv'
    ucr13_file = directory + 'ucr13_arrests_offenses.csv'

    # Delete old versions of the database file
    if os.path.exists(database_file):
        os.remove(database_file)

    conn = sqlite3.connect(database_file)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    setup_table(c, nibrs_file, 'offenders_2013')
    setup_table(c, crosswalk_agencies_file, 'crosswalk_agencies')
    setup_table(c, lemas_file, 'lemas_2013')
    setup_table(c, acs_file, 'acs_counties_13')
    setup_table(c, pres12_file, 'pres12_counties')
    setup_table(c, governors_file, 'governors_2015')
    setup_table(c, ucr13_file, 'ucr13_arrests_offenses')

    ucr_small(c, 'ucr13_arrests_offenses', 'ucr13_arrests_offenses_small')

    merge_datasets(c)

    table = pandas.read_sql_query('select * from offenders_2013_caplg_ucr', conn)
    table.to_csv(outfile, index = False)

    conn.commit()
    conn.close()

def merge_datasets(c):
    # Add crosswalk data by agency to get cw_ori7
    table_name = 'offenders_2013_cw'
    query_text = '''SELECT * FROM offenders_2013 LEFT OUTER JOIN crosswalk_agencies
    ON offenders_2013.ori = crosswalk_agencies.cw_ori9'''
    create_merged(c, table_name, query_text)

    # Add ACS county demographics
    table_name = 'offenders_2013_c_acs'
    query_text = '''SELECT * FROM offenders_2013_cw LEFT OUTER JOIN acs_counties_13 ON
    offenders_2013_cw.fips_county1_no = acs_counties_13.acs_county_no'''
    create_merged(c, table_name, query_text)

    # Add voting data by county
    table_name = 'offenders_2013_ca_pres12'
    query_text = '''SELECT * FROM offenders_2013_c_acs LEFT OUTER JOIN pres12_counties
    ON offenders_2013_c_acs.fips_county1_no = pres12_counties.pres12_county_no'''
    create_merged(c, table_name, query_text)

    # Add LEMAS data by ORI
    table_name = 'offenders_2013_cap_lemas'
    query_text = '''SELECT * FROM offenders_2013_ca_pres12 LEFT OUTER JOIN lemas_2013 ON
    offenders_2013_ca_pres12.ori = lemas_2013.ori9'''
    create_merged(c, table_name, query_text)

    # Add governors data by state name
    table_name = 'offenders_2013_capl_gov'
    query_text = '''SELECT * FROM offenders_2013_cap_lemas LEFT OUTER JOIN governors_2015 ON
    offenders_2013_cap_lemas.state_name = governors_2015.state_gov'''
    create_merged(c, table_name, query_text)

    # Add UCR arrests-offenders data by ORI7 from crosswalk
    table_name = 'offenders_2013_caplg_ucr'
    query_text = '''SELECT * FROM offenders_2013_capl_gov LEFT OUTER JOIN ucr13_arrests_offenses_small ON
        offenders_2013_capl_gov.cw_ori7 = ucr13_arrests_offenses_small.ucr13_ori'''
    create_merged(c, table_name, query_text)

def ucr_small(c, table_orig, table_small):
    c.execute('SELECT * FROM ' + table_orig)
    rows = c.fetchall()
    keys = rows[0].keys()
    bad_cols = find_bad(keys)
    keys = [key for key in keys if key not in bad_cols]

    create_table(c, keys, table_small)
    for row in rows:
        values = [row[key] for key in keys]
        insert_row(c, values, table_small)

def create_merged(c, table_name, query_text):
    """ Read all rows into memory, b/c the cursor can only keep track of one thing at a time """
    c.execute(query_text)
    rows = c.fetchall()
    keys = rows[0].keys()    
    create_table(c, keys, table_name)

    for row in rows:
        values = [row[key] for key in keys]
        insert_row(c, values, table_name)

def create_table(c, keys, table_name):
    table_vars = ' text, '.join(keys)
    table_vars = '(' + table_vars + ')'
    c.execute("CREATE TABLE " + table_name + " " + table_vars)

def insert_row(c, values, table_name):
    values_tuple = (tuple(values), )
    question_marks = ','.join(['?'] * len(values))
    c.executemany('INSERT INTO ' + table_name + ' VALUES (' + question_marks + ')', values_tuple)

def setup_table(c, infile, table_name):
    """ Create table and insert data
    The connection is passed by reference, so you do not need to return it """
    with open(infile, 'r') as f:
        reader = csv.DictReader(f)
        row = reader.next()

    keys = name_columns(infile, row)
    create_table(c, keys, table_name)

    with open(infile, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            values = row.values()
            insert_row(c, values, table_name)

def name_columns(infile, row):
    """ Fix column names for each table to enable merging later """
    keys = row.keys()

    if 'lemas_13_clean' in infile:
        keys = ['lemas_statename' if key == 'statename' else key for key in keys]
        keys = ['lemas_statecode' if key == 'statecode' else key for key in keys]

    if 'acs_counties_13' in infile:
        keys = ['acs_county_no' if key == 'county_no' else key for key in keys]

    if 'pres12_counties' in infile:
        keys = ['pres12_' + key for key in keys]

    if 'governors_2015' in infile:
        keys = ['state_gov' if key == 'state' else key for key in keys]
        keys = ['gov15_party' if key == 'party' else key for key in keys]

    if 'ucr13_arrests_offenses' in infile:
        keys = ['ucr13_' + key for key in keys]

    if 'crosswalk_agencies' in infile:
        keys = ['cw_' + key for key in keys]

    return keys

def find_bad(keys):
    """ Find unneeded UCR columns (monthly counts) """
    months = [calendar.month_abbr[i].lower() for i in xrange(1, 13)]
    bad_ucr = []
    for month in months:
        bad_ucr += [col for col in keys if 'ucr13_' in col and '_' + month + '_' in col]
    return list(set(bad_ucr))

if __name__ == '__main__':
    main()