""" Describe counties and zip codes in NIBRS raw data """

import pandas
from ggplot import *
import sys

def main():
    directory = '../../'
    data_directory = directory + 'Data/'
    output_directory = directory + 'Output/'
    nibrs_file = data_directory + 'offenders_lemas_acs_2013_clean2.csv'
    
    byagency_outfile = output_directory + 'byagency.csv'
    bycounty_outfile = output_directory + 'bycounty1.csv'
    hist_counties_outfile = output_directory + 'hist_counties.png'
    hist_agencies_outfile = output_directory + 'hist_agencies.png'
    text_outfile = output_directory + 'nibrs_agencies_counties.txt'

    nibrs_data = pandas.read_csv(nibrs_file)
    byagency, bycounty_counts = clean_data(nibrs_data)

    byagency.to_csv(byagency_outfile, header = True, index = False)
    bycounty_counts.to_csv(bycounty_outfile, header = True, index = False)

    histograms(byagency, bycounty_counts, hist_counties_outfile, hist_agencies_outfile)
    text_output(byagency, bycounty_counts, text_outfile)

def clean_data(nibrs_data):
    for i in xrange(1, 6):
        nibrs_data['fips_county' + str(i) + '_no'] = pandas.to_numeric(nibrs_data['fips_county' + str(i) + '_no'], errors = 'coerce')
    nibrs_data['state_no'] = pandas.to_numeric(nibrs_data['state_no'], errors = 'coerce')
    byagency = nibrs_data.groupby('ori').mean().reset_index()

    for i in xrange(2, 6):
        byagency['fips_county' + str(i) + '_no_equals_state'] = (byagency['fips_county' + str(i) + '_no'] == byagency['state_no'])
        byagency['fips_county' + str(i) + '_no_missing'] = 0
        byagency.loc[byagency['fips_county' + str(i) + '_no_equals_state'], 'fips_county' + str(i) + '_no_missing'] = 1
        byagency.loc[byagency['fips_county' + str(i) + '_no'].isnull(), 'fips_county' + str(i) + '_no_missing'] = 1
    
    byagency['fips_counties'] = 0
    byagency.loc[byagency['fips_county1_no'].notnull(), 'fips_counties'] = 1
    byagency.loc[byagency['fips_county2_no_missing'] == 0, 'fips_counties'] = 2
    byagency.loc[byagency['fips_county3_no_missing'] == 0, 'fips_counties'] = 3
    byagency.loc[byagency['fips_county4_no_missing'] == 0, 'fips_counties'] = 4
    byagency.loc[byagency['fips_county5_no_missing'] == 0, 'fips_counties'] = 5

    bycounty_counts = byagency.groupby('fips_county1_no').count().reset_index()

    return byagency, bycounty_counts

def histograms(byagency, bycounty_counts, hist_counties_outfile, hist_agencies_outfile):
    # Histogram of how many counties each agency is in
    # origin = -0.5 doesn't work in Python
    hist_counties = ggplot(byagency, aes(x = 'fips_counties')) + geom_histogram(fill = "skyblue") + \
    theme_bw() + ggtitle('Number of Counties per Agency') + xlab('# Counties') + ylab('Agencies')
    ggsave(hist_counties, hist_counties_outfile, dpi = 300, width = 12, height = 10)

    # Histogram of how many agencies each county1 has
    hist_agencies = ggplot(bycounty_counts, aes(x = 'ori')) + geom_histogram(fill = "skyblue") + \
    theme_bw() + ggtitle('Number of Agencies per County 1') + xlab('# Agencies') + ylab('Counties')
    ggsave(hist_agencies, hist_agencies_outfile, dpi = 300, width = 12, height = 10)

def text_output(byagency, bycounty_counts, text_outfile):
    orig_stdout = sys.stdout
    f = file(text_outfile, 'w')
    sys.stdout = f

    print '% of agencies with only one county'
    print byagency['fips_county2_no_missing'].mean()

    print '# agencies with more than one county vs. only one county'
    print byagency['fips_county2_no_missing'].value_counts()
    
    print 'How often different agencies have the same county1 number'
    print byagency['fips_county1_no'].value_counts()

    print 'Agency count for each county'
    print bycounty_counts['ori'].value_counts()

    sys.stdout = orig_stdout
    f.close()

if __name__ == '__main__':
    main()