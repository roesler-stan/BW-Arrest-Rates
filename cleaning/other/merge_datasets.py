""" Merge datasets together to make offenders_lemas_acs_2013.csv """

import pandas
import csv
import os

def main():
    directory = '../../Data/'
    chunks_directory = '../../Data/chunks/'

    acs_outfile = directory + 'acs_counties_13_pres12.csv'
    outfile = directory + 'offenders_lemas_acs_2013.csv'
    chunks_outfile = chunks_directory + 'offenders_lemas_acs_2013_'

    nibrs_file = directory + 'offenders_2013.csv'
    lemas_file = directory + 'lemas_13_clean.csv'
    acs_file = directory + 'acs_counties_13.csv'
    pres12_file = directory + 'pres12_counties.csv'
    governors_file = directory + 'governors/governors_2015.csv'
    ucr13_file = directory + 'ucr13_arrests_offenses.csv'
    crosswalk_agencies_file = directory + 'crosswalk_agencies.csv'

    merge_chunks(chunks_outfile, nibrs_file, lemas_file, acs_file, pres12_file, governors_file, ucr13_file, crosswalk_agencies_file)
    append_chunks(chunks_directory, outfile)
    acs_pres(acs_file, pres12_file, acs_outfile)

def merge_chunks(chunks_outfile, nibrs_file, lemas_file, acs_file, pres12_file, governors_file, ucr13_file, crosswalk_agencies_file):
    """ Merge chunks of NIBRS dataset with the other datasets """
    # Read the data in smaller chunks b/c of memory issue
    CHUNK_SIZE = 300000
    # pandas read_csv chunksize doesn't work properly

    crosswalk_agencies, acs_data, pres12_data, lemas_data, governors_data, ucr13_data = prepare_datasets(crosswalk_agencies_file, acs_file, pres12_file, lemas_file, governors_file, ucr13_file)

    reader = pandas.read_csv(nibrs_file, chunksize = CHUNK_SIZE)
    for chunk_number, nibrs_data in enumerate(reader):
        # Add crosswalk data by agency to get cw_ori7
        nibrs_data = nibrs_data.merge(crosswalk_agencies, left_on = ['ori'], right_on = ['cw_ori9'], how = 'left')

        # Add ACS data using NIBRS fips_county1_no, NOT crosswalk's cw_county_no
        nibrs_data = nibrs_data.merge(acs_data, left_on = ['fips_county1_no'], right_on = ['acs_county_no'], how = 'left')

        # Add voting data
        nibrs_data = nibrs_data.merge(pres12_data, left_on = ['fips_county1_no'], right_on = ['pres12_county_no'], how = 'left')

        # Add LEMAS data
        nibrs_data = nibrs_data.merge(lemas_data, left_on = ['ori'], right_on = ['ori9'], how = 'left')

        # Add governors using state name from NIBRS
        nibrs_data = nibrs_data.merge(governors_data, left_on = ['state_name'], right_on = ['state_gov'], how = 'left')

        # Add UCR arrests-offenses data by ORI7 from crosswalk
        nibrs_data = nibrs_data.merge(ucr13_data, left_on = ['cw_ori7'], right_on = ['ucr13_ori'], how = 'left')

        nibrs_data.to_csv(chunks_outfile + str(chunk_number) + '.csv', header = True, index = False)

def append_chunks(chunks_directory, outfile):
    """ Append together merged dataset chunks """
    filenames = [ chunks_directory + f for f in os.listdir(chunks_directory) if '.csv' in f ]
    with open(filenames[0], 'r') as f:
        reader = csv.DictReader(f)
        row = reader.next()
        headers = row.keys()

    with open(outfile, 'w') as outf:
        writer = csv.DictWriter(outf, fieldnames = headers)
        writer.writeheader()

        for filename in filenames:
            with open(filename, 'r') as f:
                reader = csv.DictReader(f)
                for row in reader:
                    writer.writerow(row)

def acs_pres(acs_file, pres12_file, acs_outfile):
    """ Create a separate file with ACS and voting data for later comparison """
    acs_data = pandas.read_csv(acs_file)
    acs_data.rename(columns = {'county_no': 'acs_county_no'}, inplace = True)

    pres12_data = pandas.read_csv(pres12_file)
    pres12_data.rename(columns = lambda x: 'pres12_' + x, inplace = True)

    acs_pres12 = acs_data.merge(pres12_data, left_on = ['acs_county_no'], right_on = ['pres12_county_no'], how = 'outer')
    acs_pres12.to_csv(acs_outfile, header = True, index = False)

def prepare_datasets(crosswalk_agencies_file, acs_file, pres12_file, lemas_file, governors_file, ucr13_file):
    crosswalk_agencies = pandas.read_csv(crosswalk_agencies_file)
    crosswalk_agencies.rename(columns = lambda x: 'cw_' + x, inplace = True)

    acs_data = pandas.read_csv(acs_file)
    acs_cols = ['county_no', 'mean_inc', 'total_residents', 'b_residents_percent', 'w_residents_percent',
    'male_residents', 'percent_male', 'total_unemp', 'one_race_unemp', 'w_unemp', 'b_unemp']
    races = ['w', 'b', 'i', 'a', 'h', 'o', 'm', 'mi', 'mt']
    acs_cols += [race + '_residents' for race in races]
    acs_cols += ['binc_under' + inc + '_percent' for inc in ['10', '20', '40']]
    acs_cols += ['winc_under' + inc + '_percent' for inc in ['10', '20', '40']]
    acs_data = acs_data[acs_cols]
    acs_data.rename(columns = {'county_no': 'acs_county_no'}, inplace = True)

    pres12_data = pandas.read_csv(pres12_file)
    pres12_cols = ['county_no', 'total_votes', 'reps_percent_total', 'dems_percent_total', 'reps_percent_majority',
    'dems_percent_majority', 'plurality_party']
    pres12_data = pres12_data[pres12_cols]
    pres12_data.rename(columns = lambda x: 'pres12_' + x, inplace = True)

    lemas_data = pandas.read_csv(lemas_file)
    lemas_data.rename(columns = {'statename': 'lemas_statename', 'statecode': 'lemas_statecode'}, inplace = True)

    governors_data = pandas.read_csv(governors_file)
    governors_data.rename(columns = {'state': 'state_gov', 'party': 'gov15_party'}, inplace = True)

    ucr13_data = pandas.read_csv(ucr13_file)
    # only include the following columns
    races = ['black', 'white', 'indian', 'asian', 'hispanic', 'nonhispanic']
    offenses = ['murder', 'manslaughter', 'rape', 'robbery', 'assault', 'burglary', 'larceny', 'motor_vehicle_theft', 'total_offenses']
    ucr_cols = ['ori']
    ucr_cols += [race + '_arrests_total' for race in races]
    ucr_cols += [race + '_arrests_percent' for race in races]
    ucr_cols += [offense + '_total' for offense in offenses]
    ucr13_data = ucr13_data[ucr_cols]
    ucr13_data.rename(columns = lambda x: 'ucr13_' + x, inplace = True)

    return crosswalk_agencies, acs_data, pres12_data, lemas_data, governors_data, ucr13_data

if __name__ == '__main__':
    main()