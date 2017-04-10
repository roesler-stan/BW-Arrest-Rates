""" Create descriptive tables - using full dataset before removing women and non-black/white """

import basic_stats as bs
import acs_dems as ad
import lemas_table as lt
import ucr_table as ut
import pandas as pd

def main():
    in_directory = '../../Data/'
    out_directory = '../../Output/descriptive/ch1 discrimination/'

    nibrs_offenders_file = in_directory + 'offenders_2013_caplg_ucr_clean2.csv'
    us_file = in_directory + 'acs_counties_13.csv'
    pres12_file = in_directory + 'pres12_counties.csv'
    lemas_file = in_directory + 'lemas_13_clean.csv'
    ucr_file = in_directory + 'ucr13_arrests_offenses.csv'

    basic_file = out_directory + 'basic_stats.txt'
    dems_outfile = out_directory + 'desc_county1.csv'
    lemas_outfile = out_directory + 'desc_lemas.csv'
    ucr_outfile = out_directory + 'desc_ucr.csv'

    datasets = read_data(nibrs_offenders_file, us_file, pres12_file, lemas_file, ucr_file)
    nibrs_data, fips_county1_no_means, agency_means, us_data, pres12_data, lemas_data, ucr_data = datasets

    # bs.basic_stats(nibrs_data, fips_county1_no_means, us_data, basic_file)
    # ad.dems_table(fips_county1_no_means, us_data, pres12_data, dems_outfile)
    # lt.lemas_table(agency_means, lemas_data, lemas_outfile)
    ut.ucr_table(nibrs_data, ucr_data, ucr_outfile)

def read_data(nibrs_offenders_file, us_file, pres12_file, lemas_file, ucr_file):
    nibrs_data = pd.read_csv(nibrs_offenders_file)
    nibrs_data = nibrs_data[nibrs_data['type'] == 1]

    needed_vars = ["ori", "fips_county1_no", "w_officers_percent", "b_officers_percent", "arrested", "black_not_white", "sex"]
    for var in needed_vars:
        nibrs_data = nibrs_data[nibrs_data[var].notnull()]

    # Fix unit issue
    nibrs_data['male_residents'] = nibrs_data['male_residents'] / 1000

    # Remove anyone with an excpetional clearance
    nibrs_data = nibrs_data[nibrs_data['cleared_exceptionally'] == -6]

    numeric_vars = ['b_residents', 'w_residents', 'com_bt', 'tech_typ_vpat', 'hir_trn_no_p', 'min_hiring_educ_gths', 'pres12_reps_percent_total']
    numeric_vars += [col for col in nibrs_data if 'inc_under' in col or 'unemp' in col]
    for var in numeric_vars:
        nibrs_data[var] = pd.to_numeric(nibrs_data[var], errors = 'coerce')

    # Grouping NIBRS data at the county and agency levels
    fips_county1_no_means = nibrs_data.groupby('fips_county1_no').mean()
    agency_means = nibrs_data.groupby('ori').mean()

    # # US Data already at the county level
    us_data = pd.read_csv(us_file)
    us_data = fix_thousands(us_data)

    # County-level voting data
    pres12_data = pd.read_csv(pres12_file)

    lemas_data = pd.read_csv(lemas_file)
    # Only keep local agencies (not state or sheriff)
    lemas_data = lemas_data[lemas_data['type'] == 1]
    lemas_data.loc[lemas_data['ftsworn'] != 0, 'bdgt_per_ftoff'] = lemas_data.loc[lemas_data['ftsworn'] != 0, 'bdgt_ttl'] / \
    lemas_data.loc[lemas_data['ftsworn'] != 0, 'ftsworn']

    # Agency (ORI)- level UCR offense and arrest data
    ucr_data = pd.read_csv(ucr_file)

    return [nibrs_data, fips_county1_no_means, agency_means, us_data, pres12_data, lemas_data, ucr_data]

def fix_thousands(dataset):
    for var in ['mean_inc', 'total_residents', 'b_residents', 'w_residents', 'male_residents', 'black_male', 'white_male']:
        dataset[var] = dataset[var] / 1000
    return dataset

if __name__ == '__main__':
    main()