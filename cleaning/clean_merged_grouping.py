""" Creates agency- and county-level grouped variables, using already cleaned data. """
import pandas

def main():
    data_directory = '../../Data/'
    infile = data_directory + 'offenders_2013_caplg_ucr_clean1_small.csv'
    outfile = data_directory + 'offenders_2013_caplg_ucr_clean2.csv'

    dataset = pandas.read_csv(infile)
    dataset = lemas_grouping(dataset)
    dataset.to_csv(outfile, header = True, index = False)

def lemas_grouping(dataset):
	agency_data = dataset.groupby('ori')
	county_data = dataset.groupby('fips_county1_no')

	agency_offenders_count = agency_data['arrested'].count().reset_index()
	agency_offenders_count = agency_offenders_count.rename(columns = {'arrested': 'agency_offenders_count'})

	agency_arrestees_count = agency_data['arrested'].sum().reset_index()
	agency_arrestees_count = agency_arrestees_count.rename(columns = {'arrested': 'agency_arrestees_count'})

	county_offenders_count = county_data['arrested'].count().reset_index()
	county_offenders_count = county_offenders_count.rename(columns = {'arrested': 'county_offenders_count'})

	county_arrestees_count = county_data['arrested'].sum().reset_index()
	county_arrestees_count = county_arrestees_count.rename(columns = {'arrested': 'county_arrestees_count'})

	county_bdgt = county_data['bdgt_ttl'].mean().reset_index()
	county_bdgt = county_bdgt.rename(columns = {'bdgt_ttl': 'county_bdgt'})

	dataset = dataset.merge(agency_offenders_count, on = ['ori'], how = 'outer')
	dataset = dataset.merge(agency_arrestees_count, on = ['ori'], how = 'outer')
	dataset = dataset.merge(county_offenders_count, on = ['fips_county1_no'], how = 'outer')
	dataset = dataset.merge(county_arrestees_count, on = ['fips_county1_no'], how = 'outer')
	dataset = dataset.merge(county_bdgt, on = ['fips_county1_no'], how = 'outer')
    
	dataset['agency_bdgt_per_offender'] = (dataset['bdgt_ttl'] * 1000000) / dataset['agency_offenders_count']
	dataset['agency_bdgt_per_arrestee'] = (dataset['bdgt_ttl'] * 1000000) / dataset['agency_arrestees_count']
	dataset['county_offenders_per_resident'] = dataset['county_offenders_count'] / (dataset['total_residents'] * 1000)
	dataset['county_arrestees_per_resident'] = dataset['county_arrestees_count'] / (dataset['total_residents'] * 1000)
	dataset['county_bdgt_per_resident'] = (dataset['county_bdgt'] * 1000000) / (dataset['total_residents'] * 1000)

	return dataset

if __name__ == '__main__':
    main()