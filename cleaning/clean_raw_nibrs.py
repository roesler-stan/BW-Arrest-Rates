""" Convert ASCII text file to csv files - one raw and one cleaned """

import csv
import numpy
import datetime
import dateutil.parser
import re
import pandas

def main():
    directory = '../../Data/'
    in_directory = directory + 'nibrs/'
    infile = in_directory + '36121-0003-Data.txt'
    state_fips_file = directory + 'fips codes/state_fips.csv'
    outfile_raw = directory + 'offenders_2013_raw.csv'
    outfile_clean = directory + 'offenders_2013.csv'

    raw_offenders(infile, outfile_raw)
    clean_offenders(infile, outfile_clean, state_fips_file)

def raw_offenders(infile, outfile):
    """ Make a dataset of the raw offenders file """
    using_dict = make_dict()
    headers = [key for key in using_dict.keys()]
    headers += ['internal_offender_id']
    headers.sort()

    with open(outfile, 'w') as outf:
        writer = csv.DictWriter(outf, fieldnames = headers)
        writer.writeheader()

        with open(infile, 'r') as f:
            for line_no, line in enumerate(f):
                row = {}
                for var in using_dict.keys():
                    row[var] = line[using_dict[var][0]: using_dict[var][1]]
                    row[var] = convert_numeric(row[var])

                row['internal_offender_id'] = line_no
                writer.writerow(row)

def clean_offenders(infile, outfile, state_fips_file):
    """
    Remove any information about offenders who are not the row offender in offenders file, using offender_seqno
    E.g. use arrestee_age2 if offender_seqno == 2
    """
    state_fips = pandas.read_csv(state_fips_file)
    abbr_to_number = state_fips.set_index('usps')['fips'].to_dict()
    abbr_to_name = state_fips.set_index('usps')['state'].to_dict()

    using_dict = make_dict()

    arrestee_vars = [key for key in using_dict.keys() if re.search(re.compile('arrest'), key)]
    arrestee_vars_clean = list(set([re.sub(re.compile('\d$'), '', var) for var in arrestee_vars]))

    headers = [key for key in using_dict.keys() if key not in arrestee_vars]
    headers += arrestee_vars_clean
    headers += ['internal_offender_id', 'offense_in_residence1', 'offense_in_residence2', 'offense_in_residence3', 'report_date',
    'offender_offenses_coded', 'state_no', 'state_name']

    fips_county_vars = ['fips_county1', 'fips_county2', 'fips_county3', 'fips_county4', 'fips_county5']
    headers = [header for header in headers if header not in fips_county_vars]
    # Add county_no and other variables
    headers += [var + '_no' for var in fips_county_vars]
    headers.sort()

    with open(outfile, 'w') as outf:
        writer = csv.DictWriter(outf, fieldnames = headers)
        writer.writeheader()

        with open(infile, 'r') as f:
            for line_no, line in enumerate(f):
                row = clean_offender_line(line, using_dict, abbr_to_number, abbr_to_name)
                if not row:
                    continue
                row['internal_offender_id'] = line_no
                writer.writerow(row)

def make_dict():
    # First value is minimum, second is maximum column number
    # First one is always one lower than the first column number in the Codebook, second one is always the same as the second column number

    # Variables in basic_dict are same column numbers for all files
    using_dict = {'record_type': [0, 2], 'state_no_nibrs': [2, 4], 'state_abbr': [100, 102], 'ori': [4, 13],
                 'incident': [13, 25], 'incident_date': [25, 33], 'recsadm': [33, 36], 'recsadm': [36, 39], 'recsofs': [39, 42],
               'recsprp': [42, 45], 'recsvic': [45, 48], 'recsofr': [48, 51], 'recsarr': [51, 54], 'city_name': [70, 100], 'pop_group': [102, 104],
               'country_division': [104, 106], 'country_region': [106, 108], 'agency_indicator': [108, 110], 'core_city': [110, 112],
               'covered_ori': [112, 121], 'ucr_county1': [148, 151], 'ucr_county2': [172, 175],
               'ucr_county3': [196, 199], 'ucr_county4': [220, 223], 'ucr_county5': [244, 247],
               'months_reported': [261, 263], 'fips_county1': [303, 306], 'fips_county2': [306, 309],
               'fips_county3': [309, 312], 'fips_county4': [312, 315], 'fips_county5': [315, 318],
               'report_date_indicator': [326, 328], 'offense_segments': [330, 332],
               'cleared_exceptionally': [343, 345], 'exceptional_clearance_date': [345, 353]}

    offenders_dict = {'offender_seqno': [355, 357], 'age': [357, 359], 'sex':[359, 361],
               'race': [361, 363], 'ethnicity': [363, 365], 'ucr_offense_code1': [365, 368],
               'ucr_offense_code2': [368, 371], 'ucr_offense_code3': [371, 374],
               'attempted1': [374, 376], 'attempted2': [376, 378], 'attempted3': [378, 380],
               'location_type1': [398, 400], 'location_type2': [400, 402], 'location_type3': [402, 404],
               'arrest_seqno1': [1034, 1036], 'arrest_seqno2': [1036, 1038], 'arrest_seqno3': [1038, 1040],
               'arrest_transaction1': [1040, 1052], 'arrest_transaction2': [1052, 1064], 'arrest_transaction3': [1064, 1076],
               'arrest_date1': [1076, 1084], 'arrest_date2': [1084, 1092], 'arrest_date3': [1092, 1100],
               'arrest_type1': [1100, 1102], 'arrest_type2': [1102, 1104], 'arrest_type3': [1104, 1106],
               'multiple_arrests1': [1106, 1108], 'multiple_arrests2': [1108, 1110], 'multiple_arrests3': [1110, 1112],
               'ucr_arrest_offense_code1': [1112, 1115], 'ucr_arrest_offense_code2': [1115, 1118], 'ucr_arrest_offense_code3': [1118, 1121],
               'arrestee_age1': [1139, 1141], 'arrestee_age2': [1141, 1143], 'arrestee_age3': [1143, 1145],
               'arrestee_sex1': [1145, 1147], 'arrestee_sex2': [1147, 1149], 'arrestee_sex3': [1149, 1151],
               'arrestee_race1': [1151, 1153], 'arrestee_race2': [1153, 1155], 'arrestee_race3': [1155, 1157],
               'arrestee_ethnicity1': [1157, 1159], 'arrestee_ethnicity2': [1159, 1161], 'arrestee_ethnicity3': [1161, 1163],
               'arrestee_resident_status1': [1163, 1165], 'arrestee_resident_status2': [1165, 1167], 'arrestee_resident_status3': [1167, 1169],
               'arrestee_disposition_u18_1': [1169, 1171], 'arrestee_disposition_u18_2': [1171, 1173], 'arrestee_disposition_u18_3': [1173, 1175],
               'allofns': [1175, 1215],
               # Victim information
               'victim1_seqno': [686, 689], 'victim2_seqno': [689, 692], 'victim3_seqno': [692, 695],
               'victim1_ucr_offense_code1': [695, 698], 'victim1_ucr_offense_code2': [698, 701], 'victim1_ucr_offense_code3': [701, 704],
               'victim2_ucr_offense_code1': [704, 707], 'victim2_ucr_offense_code2': [707, 710], 'victim2_ucr_offense_code3': [710, 713],
               'victim3_ucr_offense_code1': [713, 716], 'victim3_ucr_offense_code2': [716, 719], 'victim3_ucr_offense_code3': [719, 722],
               'victim1_type': [785, 787], 'victim2_type': [787, 789], 'victim3_type': [789, 791],
               'victim1_age': [830, 834], 'victim2_age': [834, 838], 'victim3_age': [838, 842],
               'victim1_sex': [842, 844], 'victim2_sex': [844, 846], 'victim3_sex': [846, 848],
               'victim1_race': [848, 850], 'victim2_race': [850, 852], 'victim3_race': [852, 854],
               'victim1_ethnicity': [854, 856], 'victim2_ethnicity': [856, 858], 'victim3_ethnicity': [858, 860],
               'victim1_resident': [860, 862], 'victim2_resident': [862, 864], 'victim3_resident': [864, 866],
               'victim1_offender1_seqno': [914, 916], 'victim1_offender2_seqno': [916, 918], 'victim1_offender3_seqno': [918, 920],
               'victim1_offender1_relationship': [920, 922], 'victim1_offender2_relationship': [922, 924], 'victim1_offender3_relationship': [924, 926],
               'victim2_offender1_seqno': [926, 928], 'victim2_offender2_seqno': [928, 930], 'victim2_offender3_seqno': [930, 932],
               'victim2_offender1_relationship': [932, 934], 'victim2_offender2_relationship': [934, 936], 'victim2_offender3_relationship': [936, 938],
               'victim3_offender1_seqno': [938, 940], 'victim3_offender2_seqno': [940, 942], 'victim3_offender3_seqno': [942, 944],
               'victim3_offender1_relationship': [944, 946], 'victim3_offender2_relationship': [946, 948], 'victim3_offender3_relationship': [946, 948]}

    using_dict.update(offenders_dict)

    return using_dict

def clean_offender_line(line, using_dict, abbr_to_number, abbr_to_name):
    row = {}
    arrestee_vars = [key for key in using_dict.keys() if re.search(re.compile('arrest'), key)]

    seqno = int(line[using_dict['offender_seqno'][0]: using_dict['offender_seqno'][1]])
    # If it's a type B offense (arrest only) (or -8, which doesn't appear) - skip the offender
    if not seqno or seqno < 0:
        return {}

    # If offender sequence number is zero or greater than 3, it won't match any arrestee records, but that's ok

    for var in using_dict.keys():
        # If the variable is an arrestee variable for a different offender, skip it
        if var in arrestee_vars and (var[-1] != str(seqno) or seqno == 0 or seqno > 3):
            continue

        # Remove the sequence number from the variable name if it is present
        if var in arrestee_vars and var[-1] == str(seqno):
            clean_var = var[0:-1]
        else:
            clean_var = var

        row[clean_var] = line[using_dict[var][0]: using_dict[var][1]]
        if 'date' not in clean_var or 'indicator' in clean_var:
            row[clean_var] = convert_numeric(row[clean_var])

    # Create state_no and state_name variables
    row = lookup_state(row, abbr_to_number, abbr_to_name)
    fips_county_vars = ['fips_county1', 'fips_county2', 'fips_county3', 'fips_county4', 'fips_county5']
    for var in fips_county_vars:
        three_digits = find_three_digits(str(row[var]))
        if three_digits != '':
            ## DO NOT use state_no_nibrs, b/c it is incompatible with ACS and crosswalk state number and gives the wrong FIPS county_no
            row[var + '_no'] = str(row['state_no']) + three_digits
        row.pop(var)
    
    for var in ['incident_date', 'arrest_date', 'exceptional_clearance_date']:
        if var in row.keys():
            row[var] = make_date(row[var])

    for var in ['age', 'arrestee_age', 'victim1_age', 'victim2_age', 'victim3_age']:
        if var in row.keys():
            row[var] = get_age(row[var])
    
    for var in ['sex', 'arrestee_sex', 'victim1_sex', 'victim2_sex', 'victim3_sex']:
        if var in row.keys():
            row[var] = clean_sex(row[var])

    for var in ['race', 'arrestee_race', 'victim1_race', 'victim2_race', 'victim3_race']:
        if var in row.keys():
            row[var] = clean_race(row[var])

    for var in ['ethnicity', 'arrestee_ethnicity', 'victim1_ethnicity', 'victim2_ethnicity', 'victim3_ethnicity']:
        if var in row.keys():
            row[var] = clean_ethnicity(row[var])
        
    # Create 'offense_in_residence' variables
    for i, location_var in enumerate(['location_type1', 'location_type2', 'location_type3']):
        location_type = row[location_var]
        if location_type and location_type == 20:
            row['offense_in_residence' + str(i + 1)] = 1
        else:
            row['offense_in_residence' + str(i + 1)] = 0

    # If incident date variable is actually the report date, change it
    if row['report_date_indicator'] == 1:
        row['report_date'] = row['incident_date']
        row['incident_date'] = ''

    offender_offenses_coded = 0
    for var in ['ucr_offense_code1', 'ucr_offense_code2', 'ucr_offense_code3']:
        if row[var] > 0:
            offender_offenses_coded += 1
    row['offender_offenses_coded'] = offender_offenses_coded

    return row

def make_date(date):
    date_string = str(date)
    default_date = datetime.datetime(2030, 6, 15)
    try:
        date_found = dateutil.parser.parse(date_string, fuzzy = True, default = default_date)
    except:
        return ''
    if date_found == default_date or date_found.year > 2013:
        return ''
    return '-'.join([str(date_found.year), str(date_found.month), str(date_found.day)])

def get_age(age):
    try:
        age = float(age)
    except:
        age = numpy.nan
    if age <= 0 or age >= 99 or numpy.isnan(age):
        return ''
    else:
        return age

def clean_sex(sex):
    try:
        sex = int(sex)
    except:
        return ''
    if sex == 0:
        return 'female'
    elif sex == 1:
        return 'male'
    else:
        return ''
    
def clean_race(race):
    try:
        race = int(race)
    except:
        return ''
    if race == 1:
        return 'white'
    elif race == 2:
        return 'black'
    elif race == 3:
        return 'amind'
    elif race == 4:
        return 'asian'
    elif race == 5:
        return 'hawaiian'
    else:
        return ''

def clean_ethnicity(ethnicity):
    try:
        ethnicity = int(ethnicity)
    except:
        return ''
    if ethnicity == 0:
        return 'not hispanic'
    elif ethnicity == 1:
        return 'hispanic'
    else:
        return ''

def find_three_digits(county):
    """ Make county number string three digits long, adding leading zero if necessary """
    if '-' in county:
        return ''
    return ((3 - len(county)) * '0') + county

def convert_numeric(text_string):
    """ Try to convert a string that may be a number to a float """
    try:
        text_numeric = float(text_string)
        if text_numeric.is_integer():
            text_numeric = int(text_numeric)
        return text_numeric
    except ValueError:
        return text_string

def lookup_state(row, abbr_to_number, abbr_to_name):
    """ Look up state number from state_fips.csv to make county_no that is compatible """
    state_abbr = row['state_abbr']
    row['state_no'] = abbr_to_number.get(state_abbr, numpy.nan)
    row['state_name'] = abbr_to_name.get(state_abbr, '')
    return row

if __name__ == '__main__':
    main()