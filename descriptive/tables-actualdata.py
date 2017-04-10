""" Create descriptive tables - Using data actually analyzed (black and white men only) """

import offense_tables as ot
import pandas as pd
import numpy as np
# easy_install rpy2 - not pip
import rpy2.robjects as robjects
from rpy2.robjects import pandas2ri

def main():
    in_directory = '../../Data/'
    # Change these to use other chapters' data
    out_directory = '../../Output/descriptive/ch1 discrimination/'
    nibrs_offenders_file = in_directory + 'ch1.RData'
    offense_file = out_directory + 'nibrs_offense_counts.csv'
    offense_file_wofficers_divres = out_directory + 'nibrs_offense_counts_wofficers_divres.csv'
    offense_file_w_officers_percent = out_directory + 'nibrs_offense_counts_w_officers_percent.csv'

    nibrs_data = read_data(nibrs_offenders_file)
    ot.write_offense_table(nibrs_data, offense_file)
    ot.write_offense_table_detailed(nibrs_data, offense_file_wofficers_divres, offense_file_w_officers_percent)

def read_data(nibrs_offenders_file):
    robjects.r.load(nibrs_offenders_file)
    nibrs_data = robjects.r['dataset']
    nibrs_data = pd.DataFrame(pandas2ri.ri2py(nibrs_data))
    return nibrs_data

if __name__ == '__main__':
    main()