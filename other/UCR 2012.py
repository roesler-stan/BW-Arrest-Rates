""" UCR Arrest Demographics, 2012 """

import pandas

def main():
    input_file = '../../../Data/UCR/Arrests_w_Race_2013/arrest_dems13_clean.dta'
    output_file = '../../../Data/SQL Input/ucr_arrests_13.csv'
    states_file = '../../../Data/Counties states/states_fips.csv'

    arrest_data = UCR_arrests(input_file, states_file)
    arrest_data = arrest_data[['ORI', 'COUNTY', 'STATE', 'county_no', 'YEAR', 'MONTH', 'POP', 'OFFENSE', 
    'AB_edit', 'AW_edit','AI_edit','AA_edit','AH_edit','AN_edit']]

    # I rename variables here b/c to do it earlier would risk having duplicate columns
    arrest_data = arrest_data.rename(columns = {'ORI':'ORI', 'COUNTY':'county', 'STATE':'state', 'YEAR':'year', 'MONTH':'month', 
        'POP':'population', 'OFFENSE':'offense', 'AB_edit':'black', 'AW_edit':'white', 'AI_edit':'indian', 'AA_edit':'asian', 
        'AH_edit':'hispanic', 'AN_edit':'nonhispanic'})

    # converting month from category to string, not sure if necessary
    arrest_data['month'] = (arrest_data['month'].astype(str).str.extract('(\d+)')).astype(float)
    arrest_data.to_csv(output_file, header = True, index = False)

def UCR_arrests(input_file, states_file):
    arrest_data = pandas.read_stata(input_file)
    # removing states "canal zone", "puerto rico", "guam", and "virgin islands"
    arrest_data = arrest_data[~arrest_data.STATE.str.contains('Canal Zone|Puerto Rico|Guam|Virgin Islands')]
    
    # get the state codes to get county codes
    state_codes = pandas.read_csv(states_file)
    official_states = dict(zip(list(state_codes.state), list(state_codes.fips)))

    def get_stateno(state_string):
        if official_states.has_key(state_string):
            return str(official_states[state_string])
    
    # Returns string of the state number
    arrest_data['state_no'] = arrest_data['STATE'].astype(str).map(get_stateno)
    
    # Creating county numbers for the UCR arrest dataset
    arrest_data['county_no'] = arrest_data['state_no'].astype(str)

    # Need to multiply county number by 2 and subtract 1 to get all odd numbers
    arrest_data['COUNTY'] = (arrest_data['COUNTY'] * 2) - 1
    
    # States are a one- or two-digit number, all counties are three-digits, including leading 0's
    for county in arrest_data['COUNTY'].unique():
        # if the county number is one digit
        if 0 < county < 10:
            # CHECK THAT int() is okay
            arrest_data.loc[arrest_data['COUNTY'] == county, 'county_no'] += '00' + str(int(county))

        # if the county number is two digits
        if 9 < county < 100:
            arrest_data.loc[arrest_data['COUNTY'] == county, 'county_no'] += '0' + str(int(county))

        # if the county number is three digits
        if 99 < county < 1000:
            arrest_data.loc[arrest_data['COUNTY'] == county, 'county_no'] += str(int(county))
    
    # getting # of racial groups' arrests per county
    arrest_data['AB_edit'] = (arrest_data['AB'].astype(str).str.extract('(\d+)')).astype(float)
    arrest_data['AW_edit'] = (arrest_data['AW'].astype(str).str.extract('(\d+)')).astype(float)
    arrest_data['AI_edit'] = (arrest_data['AI'].astype(str).str.extract('(\d+)')).astype(float)
    arrest_data['AA_edit'] = (arrest_data['AA'].astype(str).str.extract('(\d+)')).astype(float)
    arrest_data['AH_edit'] = (arrest_data['AH'].astype(str).str.extract('(\d+)')).astype(float)
    arrest_data['AN_edit'] = (arrest_data['AN'].astype(str).str.extract('(\d+)')).astype(float)
    
    return arrest_data

if __name__ == '__main__':
    main()