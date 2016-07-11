import pandas
import math

def dems_table(fips_county1_no_means, us_data, pres12_data, dems_outfile):
    residents = ['total_residents', 'b_residents_percent', 'w_residents_percent', 'male_residents', 'county_offenders_per_resident']
    inc_controls = ['mean_inc', 'binc_under10_percent', 'binc_under20_percent', 'binc_under40_percent',
    'winc_under10_percent', 'winc_under20_percent', 'winc_under40_percent','one_race_unemp', 'w_unemp', 'b_unemp']
    voting = ['pres12_reps_percent_total']

    # Basic demographic information for NIBRS and all US counties
    fips_county1_no_vars = sorted(list(set(residents + inc_controls + voting)))

    n_ave_values = {}
    n_std_values = {}
    n_counts_dict = {}

    us_ave_values = {}
    us_std_values = {}
    us_counts_dict = {}

    for var in fips_county1_no_vars:
        n_ave_values[var] = fips_county1_no_means[var].mean()
        n_std_values[var] = fips_county1_no_means[var].std()
        n_counts_dict[var] = fips_county1_no_means[var].count().astype(float)
        
        if var in voting:
            # Voting variables aren't prefaces with 'pres12_' in pres12 data
            clean_var = var.split('pres12_')[-1]
            us_ave_values[var] = pres12_data[clean_var].mean()
            us_std_values[var] = pres12_data[clean_var].std()
            us_counts_dict[var] = pres12_data[clean_var].count().astype(float)
            continue

        if var in us_data.columns:
            us_data[var] = pandas.to_numeric(us_data[var], errors = 'coerce')
            us_ave_values[var] = us_data[var].mean()
            us_std_values[var] = us_data[var].std()
            us_counts_dict[var] = us_data[var].count().astype(float)
            
    # Mean Values Table
    data_dict = {'Dataset Mean': n_ave_values, 'Dataset S.D.': n_std_values, 'Dataset N' : n_counts_dict,
    'U.S. Mean': us_ave_values, 'U.S. S.D.': us_std_values, 'U.S. N': us_counts_dict}
    table_data = pandas.DataFrame(data_dict, index = [fips_county1_no_vars])

    def table_format(number):
        if math.isnan(number) or number == float("inf"):
            return 'N/A'
        # If it's really small, put 4 numbers after the decimal
        if number <= 0.001:
            return '%.4f' % number
        if number <= 200:
            return '%.3f' % number
        if number > 200:
            return '{0:,d}'.format(int(number))
        else:
            return 'N/A'

    table_data[''] = table_data.index

    new_varnames = {'b_male': 'Black Males', 'b_residents_percent': '% Residents Black', 'b_unemp': 'Black Unemployment',
        'binc_under10_percent': '% Black Households < 10K', 'binc_under20_percent': '% Black Households < 20K', 'binc_under40_percent': '% Black Households < 40K',
        'male_residents': 'Male Population', 'mean_inc': 'Mean Household Income (K)', 'one_race_unemp': 'Unemployment Rate (Single Race)',
        'pres12_reps_percent_total': '% Votes Republican', 'total_residents': 'Total Population', 'w_male': 'White Males',
        'w_residents_percent': '% Residents White', 'w_unemp': 'White Unemployment', 'winc_under10_percent': '% White Households < 10K',
        'winc_under20_percent': '% White Households < 20K', 'winc_under40_percent': '% White Households < 40K',
        'county_offenders_per_resident': 'Offenders per Resident'}

    for oldvar, newvar in new_varnames.items():
        table_data.loc[table_data[''] == oldvar, ''] = newvar

    new_order = ['Total Population', 'Male Population', 'White Males',  'Black Males',  '% Residents White', '% Residents Black',
    '% Votes Republican', 'Unemployment Rate (Single Race)', 'White Unemployment',  'Black Unemployment', 'Mean Household Income (K)',
    '% White Households < 10K', '% Black Households < 10K', '% White Households < 20K', '% Black Households < 20K', '% White Households < 40K',
    '% Black Households < 40K', 'Offenders per Resident']

    table_data[''] = pandas.Categorical(table_data[''], new_order)
    table_data = table_data.sort_values(by = '')
    table_data = table_data[['', 'Dataset Mean', 'Dataset S.D.', 'Dataset N', 'U.S. Mean', 'U.S. S.D.', 'U.S. N']]

    with open (dems_outfile, 'w') as f:
        f.write(pandas.DataFrame.to_csv(table_data, float_format = '%.2f', index = False))