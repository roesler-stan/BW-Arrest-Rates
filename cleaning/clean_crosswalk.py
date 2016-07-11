"""
Crosswalk files (2005) from https://www.icpsr.umich.edu/icpsrweb/DSDR/studies/4634
State FIPS file from https://www.census.gov/geo/reference/ansi_statetables.html
    (not http://www2.census.gov/geo/docs/reference/codes/files/national_county.txt, https://www.census.gov/geo/reference/codes/cou.html)
"""

import pandas

def main():
    data_directory = '../../Data/'
    in_directory = data_directory + 'crosswalk 2005/'
    input_file = in_directory + 'DS0001/agencies_crosswalk.dta'
    state_fips_file = data_directory + 'fips codes/state_fips.csv'
    crosswalk_agencies_file = data_directory + 'crosswalk_agencies.csv'    
    
    data = pandas.read_stata(input_file)
    data = data.rename(columns = lambda x: x.lower())
    data = data[['state', 'county', 'agency', 'fstate', 'fcounty', 'fmsa', 'fmsaname',
                 'ori7', 'ori9', 'zipcode', 'fplace', 'placenm']]
    data['fmsa'] = (data['fmsa'].astype(str).str.extract('(\d+)'))
    data['fcounty'] = pandas.to_numeric(data['fcounty'], errors = 'coerce')
    data = data.rename(columns = {'zipcode': 'zipcode_lowest'})

    data = county_no(data, state_fips_file)
    data.to_csv(crosswalk_agencies_file, header = True, index = False)

def county_no(data, state_fips_file):
    # official_states = dict(zip(list(state_codes.state), list(state_codes.state_no)))
    state_fips = pandas.read_csv(state_fips_file)
    abbr_to_number = state_fips.set_index('usps')['fips'].to_dict()
    abbr_to_name = state_fips.set_index('usps')['state'].to_dict()

    data['state_no'] = data['state'].map(abbr_to_number.get)
    data['state_name'] = data['state'].map(abbr_to_name.get)

    # Create county numbers from string of state_no
    data['county_no'] = data['state_no'].astype(str).str.replace('.0', '')
    
    # States are a one- or two-digit number, all counties are three-digits, including leading 0's
    for county in data['fcounty'].unique():
        # if the county number is one digit
        if 0 < county < 10:
            data.loc[data['fcounty'] == county, 'county_no'] += '00' + str(int(county))

        # if the county number is two digits
        if 9 < county < 100:
            data.loc[data['fcounty'] == county, 'county_no'] += '0' + str(int(county))

        # if the county number is three digits
        if 99 < county < 1000:
            data.loc[data['fcounty'] == county, 'county_no'] += str(int(county))
    
    return data

if __name__ == '__main__':
    main()