"""
ipython
import Setup_final

data_directory = '../Data/SQL Output/'

infile = data_directory + 'nibrs_offenders_arrestees_13_lemas_acs_pres12_small.csv'
outfile = data_directory + 'nibrs_offenders_arrestees_13_lemas_acs_pres12_clean.csv'
dataset = Setup_final.nibrs_offenders_arrestees(infile, outfile)

infile = data_directory + 'nibrs_offenders_13m_lemas_zip_acs_pres12.csv'
outfile = data_directory + 'nibrs_offenders_13m_lemas_zip_acs_pres12_clean.csv'
dataset = Setup_final.nibrs_offenders(infile, outfile)

infile = data_directory + 'nibrs_arrests_13m_la_off_pres12.csv'
outfile = data_directory + 'nibrs_arrests_13m_la_off_pres12_clean.csv'
dataset = Setup_final.nibrs_arrests(infile, outfile)

infile = data_directory + 'mugshots_july_male_1415_ac_arplnao.csv'
outfile = data_directory + 'mugshots_july_male_1415_ac_arplnao_clean.csv'
dataset = Setup_final.setup_mugshots(infile, outfile)

"""

import pandas
import Setup_ACS_LEMAS as sa
import code_offenses as co
import clean_nibrs_offenders_arrestees as oa

def main():
	data_directory = '../Data/SQL Output/'
	infile = data_directory + 'nibrs_offenders_arrestees_13_lemas_acs_pres12_small.csv'
	outfile = data_directory + 'nibrs_offenders_arrestees_13_lemas_acs_pres12_clean.csv'
	dataset = nibrs_offenders_arrestees(infile, outfile)

def nibrs_offenders_arrestees(infile, outfile):
	dataset = pandas.read_csv(infile)
	dataset = sa.main(dataset)
	dataset = oa.main(dataset)
	dataset = co.main(dataset, 'nibrs_offenders_arrestees')

	dataset.to_csv(outfile, index = False, header = True)

def nibrs_arrests(infile, outfile):
	dataset = pandas.read_csv(infile)
	dataset = sa.main(dataset)
	dataset = oa.main(dataset)
	dataset = co.main(dataset, 'nibrs_arrests')

	dataset.to_csv(outfile, index = False, header = True)

	return dataset

def nibrs_offenders(infile, outfile):
	dataset = pandas.read_csv(infile)
	dataset = sa.main(dataset)
	dataset = co.main(dataset, 'nibrs_offenders')

	dataset.to_csv(outfile, index = False, header = True)

	return dataset

def setup_mugshots(infile, outfile):
	dataset = pandas.read_csv(infile)
	dataset = sa.main(dataset)
	dataset = co.main(dataset, 'mugshots')

	dataset.to_csv(outfile, index = False, header = True)

	return dataset

if __name__ == '__main__':
    main()