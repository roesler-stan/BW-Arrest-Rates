import pandas
from table_format import *

def lemas_table(agency_means, lemas_data, lemas_outfile):
    pd13_controls = ['w_officers_percent', 'b_officers_percent', 'male_officers_percent', 'ftsworn', 'bdgt_ttl',
    'com_bt', 'tech_typ_vpat', 'min_hiring_educ_gths', 'hir_trn_no_p']
    binary = ['com_bt', 'tech_typ_vpat', 'min_hiring_educ_gths', 'hir_trn_no_p']

    n_ave_values = {}
    n_std_values = {}
    n_counts_dict = {}

    lemas_ave_values = {}
    lemas_std_values = {}
    lemas_counts_dict = {}

    for var in pd13_controls:
        n_counts_dict[var] = agency_means[var].count().astype(float)
        if var in binary:
            n_ave_values[var] = agency_means[var].mean() * 100
        else:
            n_ave_values[var] = agency_means[var].mean()
            n_std_values[var] = agency_means[var].std()

        if var in lemas_data.columns:
            lemas_counts_dict[var] = lemas_data[var].count().astype(float)
            if var in binary:
                lemas_ave_values[var] = lemas_data[var].mean() * 100
            else:
                lemas_ave_values[var] = lemas_data[var].mean()
                lemas_std_values[var] = lemas_data[var].std()

    data_dict = {'Data Set Mean': n_ave_values, 'Data Set S.D.': n_std_values, 'Data Set N' : n_counts_dict,
    'U.S. Mean': lemas_ave_values, 'U.S. S.D.': lemas_std_values, 'U.S. N' : lemas_counts_dict}
    table_data = pandas.DataFrame(data_dict, index = [pd13_controls])
    table_data[''] = table_data.index

    new_varnames = {'w_officers_percent': '% Officers White', 'b_officers_percent': '% Officers Black',
            'male_officers_percent': '% Officers Male', 'ftsworn': 'Full-Time Sworn Officers', 'bdgt_ttl': 'Total Budget (M)',
            'com_bt': '% Assign Officers to Beats', 'tech_typ_vpat': '% Use Body Cameras',
            'min_hiring_educ_gths': '% Require More than HS', 'hir_trn_no_p': '% Without Additional Training'}

    for oldvar, newvar in new_varnames.items():
        table_data.loc[table_data[''] == oldvar, ''] = newvar

    new_order = ['% Officers White', '% Officers Black', '% Officers Male', 'Full-Time Sworn Officers', 'Total Budget (M)',
    '% Assign Officers to Beats', '% Use Body Cameras', '% Require More than HS', '% Without Additional Training', ]

    table_data[''] = pandas.Categorical(table_data[''], new_order)
    table_data = table_data.sort_values(by = '')
    table_data = table_data[['', 'Data Set Mean', 'Data Set S.D.', 'Data Set N', 'U.S. Mean', 'U.S. S.D.', 'U.S. N']]

    with open (lemas_outfile, 'w') as f:
        f.write(pandas.DataFrame.to_csv(table_data, float_format = '%.2f', index = False))