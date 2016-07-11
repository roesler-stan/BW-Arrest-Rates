import pandas
import numpy

def main():
    infile = '../Data/lemas_13.csv'
    outfile = '../Output/maps/lemas_13_wofficers.tsv'
    
    map_lemas(infile, outfile)

def map_lemas(infile, outfile):
    dataset = pandas.read_csv(infile)
    dataset = dataset[dataset['type'] == 1]

    dataset['wofficers_percent'] = (dataset['pers_fts_wht'].astype(float) / dataset['pers_fts_racetot']) * 100

    with open(outfile, 'w') as r_file:
        r_file.write('id\trate\n')
        zipcodes = dataset.groupby('zipcode')

        for zipcode in zipcodes.groups:
            zipcode_data = zipcodes.get_group(zipcode)

            rate = zipcode_data['wofficers_percent'].mean()

            rate_str = format(rate, '.3f')
            if rate_str == 'inf':
                rate_str = '1'

            if rate_str != 'nan':
                r_file.write(str(int(zipcode)) + '\t' + rate_str + '\n')

if __name__ == '__main__':
    main()