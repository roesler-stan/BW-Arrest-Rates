""" Combine all pres12 files into a single data file and add county_no """

import os
import pandas

def main():
    directory = '../../Data/'
    fips_codes_file = directory + 'fips codes/fips_codes.txt'
    state_fips_file = directory + 'fips codes/state_fips.csv'
    pres12_directory = directory + 'cqpress voting/'
    outfile = 'pres12_counties.csv'

    os.chdir(pres12_directory)
    filenames = [ f for f in os.listdir('.') if '.csv' in f and f != outfile ]
    full_data = merge_files(filenames)
    full_data = lookup_county_no(full_data, fips_codes_file, state_fips_file)

    os.chdir('../')
    full_data.to_csv(outfile, header = True, index = False, quotechar = '"')

def merge_files(filenames):
    full_data = pandas.DataFrame()

    for filename in filenames:
        data = pandas.read_csv(filename, skiprows = 2)
        data = data.rename(columns = {'State': 'state', 'Area': 'county',
            'TotalVotes': 'total_votes', 'RepVotes': 'rep_votes', 'DemVotes': 'dem_votes',
            'RepVotesTotalPercent': 'reps_percent_total', 'DemVotesTotalPercent': 'dems_percent_total',
            'ThirdVotesTotalPercent': 'third_percent_total', 'OtherVotesTotalPercent': 'other_percent_total',
            'RepVotesMajorPercent': 'reps_percent_majority', 'DemVotesMajorPercent': 'dems_percent_majority',
            'PluralityParty': 'plurality_party'})

        desired_cols = [ 'state', 'county', 'total_votes', 'rep_votes', 'dem_votes', 'reps_percent_total', 'dems_percent_total',
        'third_percent_total', 'other_percent_total', 'reps_percent_majority', 'dems_percent_majority', 'plurality_party' ]
        data = data[desired_cols]

        # Correct capitalization
        data['state'] = data['state'].str.title()
        data['county'] = data['county'].str.title()

        for var in ['total_votes', 'rep_votes', 'dem_votes']:
            data[var] = data[var].astype(str).str.replace(',', '')
            data[var] = data[var].convert_objects(convert_numeric = True)

        full_data = full_data.append(data)

    return full_data

def lookup_county_no(full_data, fips_codes_file, state_fips_file):
    """ Calculate county number using county code, matched using state and county names """
    fips_codes = pandas.read_csv(fips_codes_file, header = None, names = ['state', 'state_no', 'county_fips', 'county_name', 'fips_class'])

    state_fips = pandas.read_csv(state_fips_file)
    abbr_to_number = state_fips.set_index('usps')['fips'].to_dict()
    abbr_to_name = state_fips.set_index('usps')['state'].to_dict()
    fips_codes['state_name'] = fips_codes['state'].map(abbr_to_name.get)

    # make county_no
    fips_codes['county_zeros_needed'] = (3 - fips_codes['county_fips'].astype(str).str.len())
    fips_codes.loc[fips_codes['county_zeros_needed'] == 2, 'county_no'] = '00' + fips_codes['county_fips'].astype(str)
    fips_codes.loc[fips_codes['county_zeros_needed'] == 1, 'county_no'] = '0' + fips_codes['county_fips'].astype(str)
    fips_codes.loc[fips_codes['county_zeros_needed'] == 0, 'county_no'] = fips_codes['county_fips'].astype(str)
    fips_codes['county_no'] = fips_codes['state_no'].astype(str) + fips_codes['county_no']

    fips_codes['county_name'] = fips_codes['county_name'].str.replace(' County$', '')
    fips_codes = fips_codes[['state_name', 'county_name', 'county_no']]
    full_data = full_data.merge(fips_codes, left_on = ['county', 'state'], right_on = ['county_name', 'state_name'], how = 'left')

    return full_data

if __name__ == '__main__':
    main()