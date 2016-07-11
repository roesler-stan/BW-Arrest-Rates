"""
Crosswalk files from https://www.icpsr.umich.edu/icpsrweb/DSDR/studies/4634
State FIPS file from http://www2.census.gov/geo/docs/reference/codes/files/national_county.txt, https://www.census.gov/geo/reference/codes/cou.html
"""

import pandas

def main():
    in_directory = '../../Data/crosswalk 2005/'
    out_directory = '../../Data/'
    input_file = in_directory + 'DS0001/agencies_crosswalk.dta'
    states_file = in_directory + 'national_county.txt'
    outfile = out_directory + 'crosswalk.csv'

    data = pandas.read_stata(input_file)
    state_codes = pandas.read_csv(states_file, header = None, names = ['state', 'state_no', 'county_fips', 'county_name', 'fips_class'])

    data = data.rename(columns = lambda x: x.lower())
    data = data[['state', 'county', 'agency', 'fstate', 'fcounty', 'fmsa', 'fmsaname',
                 'ori7', 'ori9', 'zipcode', 'ziprange', 'fplace', 'placenm']]
    data['fmsa'] = (data['fmsa'].astype(str).str.extract('(\d+)'))
    data['fcounty'] = pandas.to_numeric(data['fcounty'], errors = 'coerce')

    data = county_no(data, state_codes)

    data.to_csv(outfile, header = True, index = False)

def county_no(data, state_codes):
    # get the state codes to get county codes
    official_states = dict(zip(list(state_codes.state), list(state_codes.state_no)))
    
    # Returns string of the state number
    data['state_no'] = data['state'].astype(str).map(official_states.get).astype(str).str.split('.0').str.get(0)
    
    # Creating county numbers
    data['county_no'] = data['state_no']
    
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

def zipcodes(data):
	""" Find maximum zip code and make tuple with all zip codes """
	data['fplace'] = pandas.to_numeric(data['fplace'], errors = 'coerce')
	# Need to find all possible zip codes in fplace, then take all zip codes up to the one ending in ziprange digits


	return data

if __name__ == '__main__':
    main()