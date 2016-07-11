import pandas

def main():
    directory = '../../Data/'
    input_file = 'crosswalk.csv'
    states_file = '../../../Data/Counties states/states_fips.csv'

    data = pandas.read_stata(input_file)

    data = data[['STATE', 'COUNTY', 'AGENCY', 'FSTATE', 'FCOUNTY', 'FMSA', 'FMSANAME',
                 'ORI7', 'ORI9', 'ZIPCODE', 'PLACENM']]

    data['FMSA'] = (data['FMSA'].astype(str).str.extract('(\d+)'))
    data['FCOUNTY'] = data['FCOUNTY'].convert_objects(convert_numeric = True)

    data = county_no(data, states_file)

    data.to_csv('../../../Data/SQL Input/crosswalk_12.csv', header = True, index = False)


# I could try to read in a CSV converted from Stata instead
def county_no(data, states_file):    
    # get the state codes to get county codes
    state_codes = pandas.read_csv(states_file)
    official_states = dict(zip(list(state_codes.state), list(state_codes.fips)))

    def get_stateno(state_string):
        if official_states.has_key(state_string):
            return str(official_states[state_string])
    
    # Returns string of the state number
    data['state_no'] = data['FSTATE'].astype(str).map(get_stateno)
    
    # Creating county numbers for the UCR arrest dataset
    data['county_no'] = data['state_no'].astype(str)
    
    # States are a one- or two-digit number, all counties are three-digits, including leading 0's
    for county in data['FCOUNTY'].unique():
        # if the county number is one digit
        if 0 < county < 10:
            data.loc[data['FCOUNTY'] == county, 'county_no'] += '00' + str(int(county))

        # if the county number is two digits
        if 9 < county < 100:
            data.loc[data['FCOUNTY'] == county, 'county_no'] += '0' + str(int(county))

        # if the county number is three digits
        if 99 < county < 1000:
            data.loc[data['FCOUNTY'] == county, 'county_no'] += str(int(county))
    
    return data

