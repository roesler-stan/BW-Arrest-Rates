""" Compare NIBRS and UCR data """

import pandas
from table_format import *

def ucr_table(nibrs_data, ucr_data, ucr_outfile):
    """ Compare UCR measures in NIBRS agencies vs. all UCR agencies """
    ucr_cols = [col.split('ucr13_')[-1] for col in nibrs_data.columns if 'ucr13' in col and 'ori' not in col]

    # Only include agencies whose last month reported is December to make comparable
    ucr_data = ucr_data[ucr_data['last_month_reported'] == 12]

    # Only include agencies with data on offender race
    ucr_data = ucr_data[ucr_data['white_arrests_percent'].notnull()]

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

    data_dict = {'Dataset Mean': n_ave_values, 'Dataset S.D.': n_std_values, 'Dataset N' : n_counts_dict,
    'UCR Mean': ucr_ave_values, 'UCR S.D.': ucr_std_values, 'UCR N' : ucr_counts_dict}
    table_data = pandas.DataFrame(data_dict, index = [ucr_cols])
    table_data[''] = table_data.index

    cols = [col.replace('_', ' ').title() for col in ucr_cols]
    cols = [col.replace('Indian', 'Native American') for col in cols]
    cols = [col.replace('Nonhispanic', 'Non-Hispanic') for col in cols]
    cols = [col.replace('Total Offenses Offenses Total', 'Total Offenses') for col in cols]
    cols = [' '.join(col.rsplit(' ', 2)[i] for i in [2, 1, 0]) if 'Percent' in col else col for col in cols]
    # Remove 'total' at end of offense cols (e.g. "Murder Offenses Total" to "Murder Offenses")
    cols = [col.split(' Total')[0] if col not in ('Total Offenses', 'Total Arrests') else col for col in cols]
    table_data[''] = cols

    new_order = ['Total Offenses', 'Total Arrests', 'Aggravated Assault Offenses', 'Motor Vehicle Theft Offenses',
    'Larceny Offenses', 'Burglary Offenses', 'Manslaughter Offenses',
    'Murder Offenses', 'Rape Offenses', 'Robbery Offenses',
    'Percent Arrests Black', 'Percent Arrests White', 'Percent Arrests Asian', 'Percent Arrests Native American',
    'Percent Arrests Hispanic', 'Percent Arrests Non-Hispanic']

    table_data[''] = pandas.Categorical(table_data[''], new_order)
    table_data = table_data.sort_values(by = '')

    table_data = table_data[['', 'Dataset Mean', 'Dataset S.D.', 'Dataset N', 'UCR Mean', 'UCR S.D.', 'UCR N']]

    with open (ucr_outfile, 'w') as f:
        f.write(pandas.DataFrame.to_csv(table_data, float_format = '%.2f', index = False))