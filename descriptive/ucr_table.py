""" Compare NIBRS and UCR data """

import pandas as pd
from table_format import *

def ucr_table(nibrs_data, ucr_data, ucr_outfile):
    """ Compare UCR measures in NIBRS agencies vs. all UCR agencies """
    ucr_cols = [col.split('ucr13_')[-1] for col in nibrs_data.columns if 'ucr13' in col and 'ori' not in col]

    # Only include agencies whose last month reported is December to make comparable
    ucr_data = ucr_data[ucr_data['last_month_reported'] == 12]

    # Only include agencies with data on offender race
    ucr_data = ucr_data[ucr_data['white_arrests_percent'].notnull()]

    # Get percentages for offenses
    offense_vars = [col for col in ucr_cols if '_offenses_total' in col and col != 'total_offenses_offenses_total']
    total = ucr_data['total_offenses_offenses_total']
    for var in offense_vars:
        ucr_data[var] = (ucr_data[var] / total) * 100

    # Multiply race proportions by 100 to get percentages
    race_vars = [col for col in ucr_cols if 'arrests_percent' in col]
    for var in race_vars:
        ucr_data[var] = ucr_data[var] * 100

    # Create a subsample of UCR data that only includes agencies I later analyze
    agencies = nibrs_data['ucr13_ori7'].unique().tolist()
    ucr_nibrs_agencies = ucr_data[ucr_data['ori'].isin(agencies)]

    n_ave_values = {}
    n_std_values = {}
    n_counts_dict = {}

    ucr_ave_values = {}
    ucr_std_values = {}
    ucr_counts_dict = {}

    for var in ucr_cols:
        n_ave_values[var] = ucr_nibrs_agencies[var].mean()
        n_std_values[var] = ucr_nibrs_agencies[var].std()
        n_counts_dict[var] = ucr_nibrs_agencies[var].count().astype(float)

        ucr_ave_values[var] = ucr_data[var].mean()
        ucr_std_values[var] = ucr_data[var].std()
        ucr_counts_dict[var] = ucr_data[var].count().astype(float)

    data_dict = {'Data Set Mean': n_ave_values, 'Data Set S.D.': n_std_values, 'Data Set N' : n_counts_dict,
    'U.S. Mean': ucr_ave_values, 'U.S. S.D.': ucr_std_values, 'U.S. N' : ucr_counts_dict}
    table_data = pd.DataFrame(data_dict, index = [ucr_cols])
    table_data[''] = table_data.index

    cols = [col.replace('_', ' ').title() for col in ucr_cols]
    cols = [col.replace('Indian', 'Native American') for col in cols]
    cols = [col.replace('Nonhispanic', 'Non-Hispanic') for col in cols]
    cols = [col.replace('Total Offenses Offenses Total', 'Total Offenses') for col in cols]
    cols = [' '.join(col.rsplit(' ', 2)[i] for i in [2, 1, 0]) if 'Percent' in col else col for col in cols]
    # Remove 'total' at end of offense cols (e.g. "Murder Offenses Total" to "Murder Offenses")
    cols = [col.split(' Total')[0] if col not in ('Total Offenses', 'Total Arrests') else col for col in cols]
    table_data[''] = cols

    new_order = ['Total Arrests', 'Total Offenses', 'Aggravated Assault Offenses', 'Motor Vehicle Theft Offenses',
    'Larceny Offenses', 'Burglary Offenses', 'Manslaughter Offenses',
    'Murder Offenses', 'Rape Offenses', 'Robbery Offenses',
    'Percent Arrests Black', 'Percent Arrests White', 'Percent Arrests Asian', 'Percent Arrests Native American',
    'Percent Arrests Hispanic', 'Percent Arrests Non-Hispanic']

    table_data[''] = pd.Categorical(table_data[''], new_order)
    table_data = table_data.sort_values(by = '')

    table_data = table_data[['', 'Data Set Mean', 'Data Set S.D.', 'Data Set N', 'U.S. Mean', 'U.S. S.D.', 'U.S. N']]

    with open (ucr_outfile, 'w') as f:
        f.write(pd.DataFrame.to_csv(table_data, float_format = '%.2f', index = False))