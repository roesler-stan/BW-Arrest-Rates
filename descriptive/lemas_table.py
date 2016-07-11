import pandas
from table_format import *

def lemas_table(agency_means, lemas_data, lemas_outfile):
    pd13_controls = ['w_officers_percent', 'b_officers_percent', 'male_officers_percent', 'ftsworn', 'bdgt_ttl', 'bdgt_per_ftoff',
                    'agency_bdgt_per_offender', 'com_bt', 'tech_typ_vpat', 'hir_trn_no_p', 'min_hiring_educ_gths']

    n_ave_values = {}
    n_std_values = {}
    n_counts_dict = {}

    lemas_ave_values = {}
    lemas_std_values = {}
    lemas_counts_dict = {}

    for var in pd13_controls:
        n_ave_values[var] = agency_means[var].mean()
        n_std_values[var] = agency_means[var].std()
        n_counts_dict[var] = agency_means[var].count().astype(float)

        if var in lemas_data.columns:
            lemas_ave_values[var] = lemas_data[var].mean()
            lemas_std_values[var] = lemas_data[var].std()
            lemas_counts_dict[var] = lemas_data[var].count().astype(float)

    data_dict = {'Dataset Mean': n_ave_values, 'Dataset S.D.': n_std_values, 'Dataset N' : n_counts_dict,
    'U.S. Mean': lemas_ave_values, 'U.S. S.D.': lemas_std_values, 'U.S. N' : lemas_counts_dict}
    table_data = pandas.DataFrame(data_dict, index = [pd13_controls])
    table_data[''] = table_data.index

    new_varnames = {'w_officers_percent': '% Officers White', 'b_officers_percent': '% Officers Black',
            'male_officers_percent': '% Officers Male', 'ftsworn': 'Full-Time Sworn Officers', 'bdgt_ttl': 'Total Budget (M)',
            'bdgt_per_ftoff': 'Budget ($) per FT Officer', 'agency_bdgt_per_offender': 'Budget ($) per Offender',
            'com_bt': 'Officers Assigned to Beats', 'tech_typ_vpat': 'Body Cameras Used', 'hir_trn_no_p': 'No Additional Training',
            'min_hiring_educ_gths': 'More than HS Required'}

    for oldvar, newvar in new_varnames.items():
        table_data.loc[table_data[''] == oldvar, ''] = newvar

    new_order = ['% Officers White', '% Officers Black', '% Officers Male', 'Full-Time Sworn Officers', 'Total Budget (M)',
    'Budget ($) per FT Officer', 'Budget ($) per Offender',
    'No Additional Training', 'More than HS Required', 'Body Cameras Used', 'Officers Assigned to Beats']

    table_data[''] = pandas.Categorical(table_data[''], new_order)
    table_data = table_data.sort_values(by = '')
    table_data = table_data[['', 'Dataset Mean', 'Dataset S.D.', 'Dataset N', 'U.S. Mean', 'U.S. S.D.', 'U.S. N']]

    with open (lemas_outfile, 'w') as f:
        f.write(pandas.DataFrame.to_csv(table_data, float_format = '%.2f', index = False))