import pandas
import re
import numpy
import csv
from lemas_vars import *
import clean_lemas as cl

def main():
    in_directory = '../../Data/lemas/'
    out_directory = '../../Data/'
    file_07 = in_directory + 'lemas_2007_orig.dta'
    file_13 = in_directory + 'lemas_2013_orig.dta'
    outfile_07 = out_directory + 'lemas_07.csv'
    outfile_13 = out_directory + 'lemas_13.csv'
    outfile_13_clean = out_directory + 'lemas_13_clean.csv'

    data_07 = clean_data(file_07, vars07)
    data_13 = clean_data(file_13, vars13)
    
    data_07.to_csv(outfile_07, header = True, index = False, quotechar = '"')
    data_13.to_csv(outfile_13, header = True, index = False, quotechar = '"')

    # Now add some useful variables and further clean the data
    add_vars(outfile_13, outfile_13_clean)

def add_vars(outfile_13, outfile_13_clean):
    with open(outfile_13, 'r') as f:
        reader = csv.DictReader(f)
        row = reader.next()
        headers = row.keys()

    new_vars = ['w_officers_percent', 'b_officers_percent', 'male_officers_percent', 'male_officers_ft_percent', 'min_hiring_educ',
    'min_hiring_educ_gths', 'wofficers_divres', 'bofficers_divres']

    with open(outfile_13_clean, 'w') as outf:
        writer = csv.DictWriter(outf, fieldnames = headers + new_vars)
        writer.writeheader()

        with open(outfile_13, 'r') as f:
            reader = csv.DictReader(f)
            for row in reader:
                row = cl.make_floats(row)
                row = cl.calc_police(row)
                row = cl.clean_numeric(row)
                writer.writerow(row)

def clean_data(filename, keeping_vars):
    police_data = pandas.read_stata(filename)
    police_data = police_data.rename(columns=lambda x: x.lower())
    police_data = police_data[keeping_vars]

    police_data['zipcode'] = police_data['zipcode'].astype(str).map(clean_zip)
    police_data = recode_categories(police_data)
    return police_data

def clean_zip(zip_string):
    if '.0' in zip_string:
        zip_string = zip_string.split('.0')[0]
        while len(zip_string) < 5:
            zip_string = '0' + zip_string
        return zip_string
    else:
        return zip_string

def recode_categories(police_data):
    police_data = police_data.convert_objects(convert_numeric = True)
    
    yn_vars = set()

    for var in police_data.columns:
        for unique_value in police_data[var].unique():
            if re.search(re.compile('yes($|[^a-z])', re.I), str(unique_value)):
                yn_vars.add(var)

    yn_vars = list(yn_vars)
    
    def yes_no(var_string):
        if re.search(re.compile('yes', re.I), var_string):
            return 1.0
        if re.search(re.compile('no', re.I), var_string):
            return 0.0
        else:
            return numpy.nan

    for var in yn_vars:
        police_data[var] = police_data[var].astype(str).map(yes_no)

    def clean_safe_inc(safe_inc):
        if safe_inc == 'Documented in arrest report':
            return 1
        if safe_inc == 'Use of force form':
            return 1
        if safe_inc == 'No formal record':
            return 0
        else:
            return numpy.nan        

    if 'safe_finc' in police_data.columns:
        police_data['safe_finc_binary'] = police_data['safe_finc'].astype(str).map(clean_safe_inc)
        
    return police_data

if __name__ == '__main__':
    main()