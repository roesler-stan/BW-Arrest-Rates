""" Drop columns from cleaned data to reduce file size """

import csv
import re

def main():
    data_directory = '../../Data/'
    infile = data_directory + 'offenders_2013_caplg_ucr_clean1.csv'
    outfile = data_directory + 'offenders_2013_caplg_ucr_clean1_small.csv'

    cols = choose_cols(infile)

    with open(outfile, 'w') as outf:
        writer = csv.DictWriter(outf, fieldnames = cols)
        writer.writeheader()

        with open(infile, 'r') as f:
            reader = csv.DictReader(f)
            for row in reader:
                clean_row = {key: row[key] for key in cols}
                writer.writerow(clean_row)

def choose_cols(infile):
    with open(infile, 'r') as f:
        reader = csv.DictReader(f)
        row = reader.next()

    cols = ['race', 'ethnicity', 'black_not_white', 'racial_minority', 'age', 'sex', 'cleared_exceptionally',
    'incident', 'incident_to_arrest_days', 'report_to_arrest_days', 'proactive', 'reactive',
    'ori', 'type', 'ftsworn', 'ptsworn', 'bdgt_ttl', 'bdgt_per_ftoff', 'hir_trn_no_p', 'hir_trn_no_l', 'safe_finc_binary',
    'min_hiring_educ', 'min_hiring_educ_gths',
    'state_name', 'state_no', 'state_gov', 'gov15_party', 'pres12_plurality_party',
    'zipcode', 'city', 'country_region', 'country_division', 'mean_inc']

    cols += [col for col in row.keys() if 'date' in col]
    cols += [col for col in row.keys() if 'victim_analyzing' in col]
    cols += [col for col in row.keys() if 'officers' in col]
    cols += [col for col in row.keys() if re.search(re.compile('^arrest'), col)]
    cols += [col for col in row.keys() if re.search(re.compile('^offense'), col)]
    cols += [col for col in row.keys() if 'fips_county' in col]
    cols += [col for col in row.keys() if 'percent' in col and 'ucr' not in col]
    cols += [col for col in row.keys() if 'residents' in col]
    cols += [col for col in row.keys() if 'tech_typ' in col]
    cols += [col for col in row.keys() if 'ucr_offense_code' in col]
    cols += [col for col in row.keys() if 'attempted' in col]
    cols += [col for col in row.keys() if 'unemp' in col]
    cols += [col for col in row.keys() if 'location' in col or 'residence' in col]
    cols += [col for col in row.keys() if re.search(re.compile('^com_'), col)]
    cols += [col for col in row.keys() if re.search(re.compile('^recs'), col)]
    cols += [col for col in row.keys() if 'ucr13_' in col]
    # cols += [col for col in row.keys() if 'hir_edu' in col]
    cols = list(set(cols))

    dropped_cols = [col for col in row.keys() if col not in cols]
    print 'You chose to drop ' + str(len(dropped_cols)) + ' columns.'

    return cols

if __name__ == '__main__':
    main()