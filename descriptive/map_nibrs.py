import pandas
import numpy

def main():
    infile = '../Data/offenders_lemas_acs_2013_clean.csv'
    outfile = '../Output/maps/nibrs13_bdivw_arrests.tsv'
    
    map_zipcodes(infile, outfile)

def map_zipcodes(infile, outfile):
    dataset = pandas.read_csv(infile)

    with open(outfile, 'w') as r_file:
        r_file.write('id\trate\n')
        zipcodes = dataset.groupby('zipcode')

        for zipcode in zipcodes.groups:
            zipcode_data = zipcodes.get_group(zipcode)
            black_zipcodes = zipcode_data[zipcode_data['black_not_white'] == 1]
            white_zipcodes = zipcode_data[zipcode_data['black_not_white'] == 0]
            black_rate = black_zipcodes['arrested'].mean()
            white_rate = white_zipcodes['arrested'].mean()
            
            if white_rate == 0:
                rate = numpy.nan
            else:
                rate = black_rate / white_rate

            rate_str = format(rate, '.3f')
            if rate_str == 'inf':
                rate_str = '1'

            if rate_str != 'nan':
                r_file.write(str(int(zipcode)) + '\t' + rate_str + '\n')

if __name__ == '__main__':
    main()