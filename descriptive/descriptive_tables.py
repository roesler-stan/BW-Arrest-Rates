""" Create descriptive tables """

import basic_stats as bs
import acs_dems as ad
import lemas_table as lt
import offense_tables as ot
import ucr_table as ut

import pandas

def main():
    in_directory = '../../Data/'
    out_directory = '../../Output/tables/'

    nibrs_offenders_file = in_directory + 'offenders_2013_caplg_ucr_clean2.csv'
    us_file = in_directory + 'acs_counties_13.csv'
    pres12_file = in_directory + 'pres12_counties.csv'
    lemas_file = in_directory + 'lemas_13_clean.csv'
    ucr_file = in_directory + 'ucr13_arrests_offenses.csv'

    basic_file = out_directory + 'basic_stats.txt'
    dems_outfile = out_directory + 'desc_county1.csv'
    lemas_outfile = out_directory + 'desc_lemas.csv'
    ucr_outfile = out_directory + 'desc_ucr.csv'
    offense_file = out_directory + 'nibrs_offense_counts.csv'
    offense_file_wofficers_divres = out_directory + 'nibrs_offense_counts_wofficers_divres.csv'
    offense_file_w_officers_percent = out_directory + 'nibrs_offense_counts_w_officers_percent.csv'

    datasets = read_data(nibrs_offenders_file, us_file, pres12_file, lemas_file, ucr_file)
    nibrs_data, fips_county1_no_means, agency_means, us_data, pres12_data, lemas_data, ucr_data = datasets

    bs.basic_stats(nibrs_data, fips_county1_no_means, us_data, basic_file)
    ad.dems_table(fips_county1_no_means, us_data, pres12_data, dems_outfile)
    lt.lemas_table(agency_means, lemas_data, lemas_outfile)
    
    ut.ucr_table(nibrs_data, ucr_data, ucr_outfile)

    ot.write_offense_table(nibrs_data, offense_file)
    ot.write_offense_table_detailed(nibrs_data, offense_file_wofficers_divres, offense_file_w_officers_percent)

def read_data(nibrs_offenders_file, us_file, pres12_file, lemas_file, ucr_file):
    nibrs_data = pandas.read_csv(nibrs_offenders_file)
    nibrs_data = nibrs_data[nibrs_data['type'] == 1]

    needed_vars = ["ori", "fips_county1_no", "w_officers_percent", "b_officers_percent", "arrested", "black_not_white", "sex"]
    for var in needed_vars:
        nibrs_data = nibrs_data[nibrs_data[var].notnull()]

    # Remove anyone with an excpetional clearance
    nibrs_data = nibrs_data[nibrs_data['cleared_exceptionally'] == -6]

    numeric_vars = ['b_residents', 'w_residents', 'com_bt', 'tech_typ_vpat', 'hir_trn_no_p', 'min_hiring_educ_gths', 'pres12_reps_percent_total']
    numeric_vars += [col for col in nibrs_data if 'inc_under' in col or 'unemp' in col]
    for var in numeric_vars:
        nibrs_data[var] = pandas.to_numeric(nibrs_data[var], errors = 'coerce')

    # Fix this until re-clean data
    nibrs_data['bdgt_per_ftoff'] = nibrs_data['bdgt_per_ftoff'] * 1000 * 1000

    # Grouping NIBRS data at the county and agency levels
    fips_county1_no_means = nibrs_data.groupby('fips_county1_no').mean()
    agency_means = nibrs_data.groupby('ori').mean()

    # # US Data already at the county level
    us_data = pandas.read_csv(us_file)
    us_data = fix_thousands(us_data)

    # County-level voting data
    pres12_data = pandas.read_csv(pres12_file)

    lemas_data = pandas.read_csv(lemas_file)
    lemas_data = lemas_data[lemas_data['type'] == 1]
    lemas_data.loc[lemas_data['ftsworn'] != 0, 'bdgt_per_ftoff'] = lemas_data.loc[lemas_data['ftsworn'] != 0, 'bdgt_ttl'] / \
    lemas_data.loc[lemas_data['ftsworn'] != 0, 'ftsworn']

    # Agency (ORI)- level UCR offense and arrest data
    ucr_data = pandas.read_csv(ucr_file)

    # Fix this until re-clean data
    lemas_data['bdgt_per_ftoff'] = lemas_data['bdgt_per_ftoff'] * 1000 * 1000

    return [nibrs_data, fips_county1_no_means, agency_means, us_data, pres12_data, lemas_data, ucr_data]

def fix_thousands(dataset):
    for var in ['mean_inc', 'total_residents', 'b_residents', 'w_residents', 'male_residents', 'black_male', 'white_male']:
        dataset[var] = dataset[var] / 1000
    return dataset

if __name__ == '__main__':
    main()