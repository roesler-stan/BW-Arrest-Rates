""" Clean UCR arrests and offenses files, preparing for merger with NIBRS """

import pandas

def main():
    directory = '../../Data/'
    ucr13_arrests_file = directory + 'ucr13_arrests/arrest_dems13_clean.dta'
    ucr13_offenses_file = directory + 'ucr13_offenses/36122-0001-Data.dta'
    outfile = directory + 'ucr13_arrests_offenses.csv'

    offenses = ['murder', 'rape', 'robbery', 'aggravated_assault', 'burglary', 'larceny', 'motor_vehicle_theft', 'total_offenses']
    offenses_dict = {'011': 'murder', '020': 'rape', '030': 'robbery', '040': 'aggravated_assault', '050': 'burglary',
    '060': 'larceny', '070': 'motor_vehicle_theft', '230': 'drunkenness', '030': 'robbery', '170': 'sex_offense', '110': 'fraud'}

    ucr13_arrests = clean_arrests(ucr13_arrests_file, offenses_dict)
    ucr13_offenses = clean_offenses(ucr13_offenses_file, offenses)

    ucr13_arrests_offenses = ucr13_arrests.merge(ucr13_offenses, on = ['ori'], how = 'outer')

    ucr13_arrests_offenses.to_csv(outfile, header = True, index = False)

def clean_arrests(ucr13_arrests_file, offenses_dict):
    """ Clean arrests data, which are by agency-offense and include information on race, age, and sex
    Transform them into a row for each agency with each race's number of arrests for each offense, e.g. 'black_arrests_201' """
    ucr13_arrests = pandas.read_stata(ucr13_arrests_file)
    ucr13_arrests = ucr13_arrests.rename(columns = lambda x: x.lower())

    # Remove states "canal zone", "puerto rico", "guam", and "virgin islands"
    ucr13_arrests = ucr13_arrests[~ucr13_arrests['state'].str.contains('Canal Zone|Puerto Rico|Guam|Virgin Islands')]
    # Remove missing offenses
    ucr13_arrests = ucr13_arrests[ucr13_arrests['offense'].notnull()]
    ucr13_arrests = ucr13_arrests[ucr13_arrests['offense'] != '']

    # Rename total arrest vars, e.g. 260_arrests_total to allother_arrests_total
    ucr13_arrests['offense'] = ucr13_arrests['offense'].replace(offenses_dict)

    ucr13_arrests.rename(columns = {'ab': 'black_arrests', 'aw': 'white_arrests', 'ai': 'indian_arrests',
        'aa': 'asian_arrests', 'ah': 'hispanic_arrests', 'an': 'nonhispanic_arrests'}, inplace = True)
    ucr13_arrests = ucr13_arrests[['ori', 'offense', 'black_arrests', 'white_arrests', 'indian_arrests', 'asian_arrests',
    'hispanic_arrests', 'nonhispanic_arrests']]

    ucr13_arrests_pivoted = ucr13_arrests.pivot(index = 'ori', columns = 'offense')
    # Rename columns to be race_arrests_offense_number
    my_colnames = []
    offenses = ucr13_arrests_pivoted.columns.get_level_values(1)
    race_arrests = ucr13_arrests_pivoted.columns.get_level_values(0)
    for i, offense in enumerate(offenses):
        my_colnames.append(str(race_arrests[i]) + '_' + str(offense))
    ucr13_arrests_pivoted.columns = my_colnames

    # Calculate totals by race
    races = ['black', 'white', 'indian', 'asian', 'hispanic', 'nonhispanic']
    all_race_arrests = []
    for race in races:
        race_arrests = [race + '_arrests_' + offense for offense in offenses]
        all_race_arrests.extend(race_arrests)
        ucr13_arrests_pivoted[race + '_arrests_total'] = ucr13_arrests_pivoted[race_arrests].sum(axis = 1)

    # Calculate totals by offense
    all_offense_arrests = []
    for offense in offenses:
        offense_arrests = [race + '_arrests_' + offense for race in races]
        all_offense_arrests.extend(offense_arrests)
        ucr13_arrests_pivoted[offense + '_arrests_total'] = ucr13_arrests_pivoted[offense_arrests].sum(axis = 1)
        # Each racial group's percentage of people arrested for a given offense
        for race in races:
            offense_arrest = race + '_arrests_' + offense
            ucr13_arrests_pivoted[race + '_' + offense + '_arrests_percent'] = ucr13_arrests_pivoted[offense_arrest] / ucr13_arrests_pivoted[offense + '_arrests_total']

    # Total number of arrests in this agency - same whether aggregate across race or across offense
    ucr13_arrests_pivoted['total_arrests'] = ucr13_arrests_pivoted[all_race_arrests].sum(axis = 1)

    # Calculate percentages by race
    for race in races:
        ucr13_arrests_pivoted[race + '_arrests_percent'] = ucr13_arrests_pivoted[race + '_arrests_total'] / ucr13_arrests_pivoted['total_arrests']

    # Calculate percentages by offense
    for offense in offenses:
        ucr13_arrests_pivoted[offense + '_arrests_percent'] = ucr13_arrests_pivoted[offense + '_arrests_total'] / ucr13_arrests_pivoted['total_arrests']

    ucr13_arrests_pivoted = ucr13_arrests_pivoted.reset_index()
    return ucr13_arrests_pivoted

def clean_offenses(ucr13_offenses_file, offenses):
    """ Clean offenses data, which DO NOT include information on race, age, and sex
    Go through each month's offense counts, rename, and aggregate """

    months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec']
    # How much each variable type starts with
    offense_type_dict = {'unfounded': 44, 'actual': 70, 'cleared': 96}
    MONTH_DIFF = 118 # How many variables come between unfounded jan murder and unfounded feb murder

    ucr13_offenses = pandas.read_stata(ucr13_offenses_file)
    ucr13_offenses = ucr13_offenses.rename(columns = lambda x: x.lower())

    def find_vars(base_number):
        """ Find variable numbers given base number (murder) """
        murder = base_number
        manslaugher = murder + 1
        rape = murder + 2
        robbery = murder + 5
        aggravated_assault = murder + 10
        burglary = murder + 16
        larceny = murder + 20
        motor_vehicle_theft = murder + 21
        total = murder + 25
        return {'murder': murder, 'manslaugher': manslaugher, 'rape': rape, 'robbery': robbery, 'aggravated_assault': aggravated_assault,
        'burglary': burglary, 'larceny': larceny, 'motor_vehicle_theft': motor_vehicle_theft, 'total_offenses': total}

    columns_dict = {}
    for month_number, month in enumerate(months):
        for offense_type, offense_diff in offense_type_dict.iteritems():
            base_number = month_number * MONTH_DIFF + offense_diff
            var_dict = find_vars(base_number)
            for var_name, var_number in var_dict.iteritems():
                columns_dict['v' + str(var_number)] = offense_type + '_' + month + '_' + var_name

    columns_dict['v3'] = 'ori'
    columns_dict['v12'] = 'last_month_reported'
    ucr13_offenses = ucr13_offenses.rename(columns = columns_dict)
    ucr13_offenses = ucr13_offenses[columns_dict.values()]

    # add variables together to make annual totals
    for offense in offenses:
        offense_cols = [col for col in ucr13_offenses.columns if offense in col]
        ucr13_offenses[offense + '_offenses_total'] = ucr13_offenses[offense_cols].sum(axis = 1)

    # Which month was last reported
    ucr13_offenses['last_month_reported'] = ucr13_offenses['last_month_reported'].cat.rename_categories(range(0, 13))

    return ucr13_offenses

if __name__ == '__main__':
    main()