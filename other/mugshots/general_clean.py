""" This takes "combo" variables (without "combo" label) and cleans them """

import pandas
import numpy
import re
import datetime
import dateutil.parser
import dateutil.relativedelta

# Takes dictionary of variables to clean {var_type: var_name}
def main(dataset, to_clean, keeping):
    # The variables to keep in the final dataset
    for clean_var in to_clean:
        if clean_var not in ['page_views','address','race']:
            keeping.append(clean_var + '_edit')
    
    if 'race' in to_clean:
        dataset, keeping = clean_race(dataset, keeping)

    if 'age' in to_clean:
        # If birthday is in to_clean, it will be cleaned here, too
        dataset = clean_age(dataset)
        
    if 'gender' in to_clean:
        dataset = clean_gender(dataset)

    if 'zipcode' in to_clean:
        if 'address' in to_clean:
            dataset = clean_zip(dataset, both = True)
            keeping.append('address')
        # If no address was passed, only clean zipcode
        else:
            dataset = clean_zip(dataset, both = False)

    if 'date' in to_clean:
        dataset = clean_date(dataset)

    # Only clean page views if have a date variable
    if 'page_views' in to_clean:
        dataset = clean_views(dataset)
        for keep_var in ['page_views', 'views_per_day', 'views', 'views_days', 'views_date']:
            keeping.append(keep_var)

    dataset = dataset[keeping]
    dataset = dataset.rename(columns=lambda x: x.split('_edit')[0])
    
    def remove_old(date_value):
        if isinstance(date_value, datetime.datetime) and date_value.year < 1900:
            return numpy.nan
        else:
            return date_value
    
    # Removing dates before 1900 to allow formatting, download_date doesn't need this
    for date_var in ['date', 'birthday', 'views_date']:
        if date_var in dataset.columns:
            dataset[date_var] = dataset[date_var].map(remove_old)
    
    dataset = prepare_races(dataset)
    
    return dataset

def clean_race(dataset, keeping):
    include_dict = {}
    # The first parts of regex are beginnings of words, the last isolated fragments (e.g. 'bl')
    include_dict['white'] = '((^|[^a-z])(wh|cauc|euro))|(^|[^a-z])(w|c)([^a-z]|$)'
    include_dict['am_ind'] = '((^|[^a-z])(am ind|indian|alask|ntv|native))|(^|[^a-z])(i)([^a-z]|$)'
    include_dict['asian'] = '((^|[^a-z])asian|pac|isl|haw|samoa|jap|chin|kor|orien)|(^|[^a-z])(a|p|j)([^a-z]|$)'
    include_dict['east_asian'] = '((^|[^a-z])(east asian|ind))'
    include_dict['hispanic'] = '((^|[^a-z])(hisp|latin|mex))|(^|[^a-z])(h|la?t?)([^a-z]|$)'
    include_dict['black'] = '((^|[^a-z])afr|black|blk)|(^|[^a-z])(b|bk|bl)([^a-z]|$)'
    include_dict['multi'] = '((^|[^a-z])(mult|bi.?rac))'

    exclude_dict = {}
    exclude_dict['east_asian'] = 'am'
    exclude_dict['hispanic'] = 'not h|non ?h|non-h'
    
    dataset['race'] = dataset['race'].astype(str)
    
    for key in include_dict.keys():
        dataset.loc[dataset['race'].str.contains(include_dict[key]), key] = 1

    for key in exclude_dict.keys():
        dataset.loc[dataset['race'].str.contains(exclude_dict[key]), key] = numpy.nan

    # Updating list of vars to keep
    keeping.append('race')
    for race in include_dict.keys():
        keeping.append(race)
    
    return dataset, keeping

def clean_gender(dataset):
    male_regex = re.compile('male|\'m\'|^m[^a-z]|[^a-z]m[^a-z]|^m$')
    female_regex = re.compile('female|fem|\'f\'|^f[^a-z]|[^a-z]f[^a-z]|^f$')

    dataset.loc[dataset['gender'].astype(str).str.contains(male_regex), 'gender_edit'] = 'male'
    dataset.loc[dataset['gender'].astype(str).str.contains(female_regex), 'gender_edit'] = 'female'

    return dataset

# Returns a stand-alone 2-digit number that could be an age as a float
def get_age(age_string):
    # Taking an age from the combo row, which puts a comma/semi-colon after every entry
    if re.search(re.compile('(^|[^0-9])[1-9][0-9]([^0-9]|$)'), age_string):
        return float(re.findall(re.compile('[1-9][0-9]'), age_string)[0])
    else:
        return numpy.nan

def calculate_age(arrest_bday):
    arrest_date = arrest_bday[0]
    bday = arrest_bday[1]
    # If don't have a valid birthday, stop
    if bday == numpy.nan:
        return numpy.nan
    # If know the arrest date, too, calculate age
    elif arrest_date != numpy.nan:
        try:
            dt = dateutil.relativedelta.relativedelta(arrest_date, bday).years
            return dt
        except:
            return numpy.nan

# Returns the earliest date found as a datetime object
def get_date(date_str):
    dt = datetime.datetime
    this_year = datetime.datetime.today().year
    default_date = datetime.datetime(this_year + 10, 6, 15)
    min_year = this_year + 1

    if isinstance(date_str, basestring):
        # If there is more than one entry, choose the earlier date
        if re.search(re.compile('(;.*;)|[\d].*,.*[\d]'), date_str):
            final_groups = []
            groups = date_str.split(';')
            for element in groups:
                final_groups += element.split(',')

            for date_string in final_groups:
                try:
                    date_found = dateutil.parser.parse(date_string, fuzzy = True, default = default_date)
                    if date_found.year < min_year:
                        dt = date_found
                        min_year = dt.year
                except:
                    pass

        else:
            try:
                dt = dateutil.parser.parse(str(date_str), fuzzy = True, default = default_date)
            except:
                pass

    # check if it was assigned the default date or something impossible
    if not isinstance(dt, datetime.datetime):
        return numpy.nan

    dt = dt.replace(tzinfo=None)
    if dt == default_date or dt > datetime.datetime.today():
        return numpy.nan

    return dt

def clean_age(dataset):
    dataset['age_edit'] = dataset['age'].astype(str).map(get_age)

    if 'birthday' in dataset.columns:
        dataset['birthday_edit'] = dataset['birthday'].astype(str).map(get_date)
        dataset['birthday_edit'] = pandas.to_datetime(dataset['birthday_edit'], coerce = True, utc = True)
        # If don't know age but know birthday, calculate age
        dataset['arrest_bday'] = zip(dataset['date'], dataset['birthday_edit'])
        dataset.loc[dataset['age_edit'].isnull(), 'age_edit'] = dataset['arrest_bday'].map(calculate_age)
    
    return dataset

# Finds the last five-digit group in the string
def get_zip(zip_string):
    # if found a five-digit group
    if re.search(re.compile('(^|\D)\d{5}(\D|$)'), str(zip_string)):
        return float(re.findall(re.compile('\d{5}'), str(zip_string))[0])
    else:
        return numpy.nan

# Clean zip code data, don't have to pass address variable
def clean_zip(dataset, both = True):
    # Get 5-digit zip from given var
    dataset['zipcode_edit'] = dataset['zipcode'].map(get_zip)

    # Clean zip code with address variable
    if both:
        # If don't already know zipcode, look for one in address
        dataset.loc[dataset['zipcode_edit'].isnull(), 'zipcode_edit'] = dataset['address'].map(get_zip)
    
    return dataset

# To clean booking date (not needed for Jail.com)
def clean_date(dataset):
    # converting the string found to datetime
    dataset['date_edit'] = dataset['date'].astype(str).map(get_date)
    dataset['date_edit'] = pandas.to_datetime(dataset['date_edit'], coerce = True, utc = True)

    # If this doesn't result in a date, use the description field
    if 'description' in dataset.columns:
        dataset['description_date'] = dataset['description'].astype(str).map(get_date)
        dataset['description_date'] = pandas.to_datetime(dataset['description_date'], coerce = True, utc = True)
        dataset.loc[dataset['date_edit'].isnull(), 'date_edit'] = dataset['description_date']

    if 'download_date' in dataset.columns:
        # If using Pandas 0.15+, can use .dt.days (Corn uses older version)
        dataset['days_online'] = (dataset['download_date'] - dataset['date_edit']).astype('timedelta64[D]')

    return dataset

# Calculate page views per day, uses download_date
def clean_views(dataset):

    def hits_date(hits_string):
        if isinstance(hits_string, basestring):
            hits_string = hits_string.split('\n')[0]
            if 'this page since ' in hits_string:
                date_string = hits_string.split('since ')[1].split(':')[0]
                return datetime.datetime.strptime(date_string, '%m/%d/%Y')
        else:
            return numpy.nan

    dataset['views_date'] = dataset['page_views'].map(hits_date)
    dataset['views_date'] = pandas.to_datetime(dataset['views_date'], coerce = True, utc = True)
    
    dataset['views'] = (dataset['page_views'].str.extract(': ([\d]*)')).astype(float).fillna(numpy.nan)
    # If using Pandas 0.15+, can use .dt.days (Corn uses older version)
    dataset['views_days'] = (dataset['download_date'] - dataset['views_date']).astype('timedelta64[D]')

    dataset.loc[dataset['views_days'] != 0, 'views_per_day'] = dataset['views'] / dataset['views_days']
    
    return dataset

def prepare_races(dataset):    
    races = ['white', 'am_ind', 'asian', 'east_asian', 'hispanic', 'black']

    # [:] to pass by value, to keep hispanic in first list
    races_nohisp = races[:]
    races_nohisp.remove('hispanic')

    # Making multi-racial var, counting hispanic as its own race
    dataset.loc[dataset[races].sum(axis = 1) == 1, 'multi_race_whisp'] = 0
    dataset.loc[dataset[races].sum(axis = 1) > 1, 'multi_race_whisp'] = 1
    
    # Multi-racial, ignoring hispanic
    dataset.loc[dataset[races_nohisp].sum(axis = 1) == 1, 'multi_race_nohisp'] = 0
    dataset.loc[dataset[races_nohisp].sum(axis = 1) > 1, 'multi_race_nohisp'] = 1

    # Making reference group any of the other races found, ref. is overwritten if the race of interest is found
    for race in races:
        # If any race was found, make reference 0
        dataset.loc[dataset['multi_race_whisp'] == 0, race + '_only'] = 0
        dataset.loc[dataset[race] == 1, race + '_only'] = 1
        # If multi-racial
        dataset.loc[dataset['multi_race_whisp'] == 1, race + '_only'] = 0
        dataset.loc[dataset['multi'] == 1, race + '_only'] = 0

    # To ignore hispanicity, not consider it a race
    for race in races_nohisp:
        dataset.loc[dataset['multi_race_nohisp'] == 0, race + '_only_ighisp'] = 0
        dataset.loc[dataset[race] == 1, race + '_only_ighisp'] = 1
        # If multi-racial
        dataset.loc[dataset['multi_race_nohisp'] == 1, race + '_only_ighisp'] = 0
        dataset.loc[dataset['multi'] == 1, race + '_only_ighisp'] = 0
        
    dataset.loc[dataset['black_only_ighisp'] == 1, 'black_not_white'] = 1
    dataset.loc[dataset['white_only_ighisp'] == 1, 'black_not_white'] = 0

    dataset.loc[dataset['black_only_ighisp'] == 1, 'black_not_other_known'] = 1
    dataset.loc[dataset['white_only_ighisp'] == 1, 'black_not_other_known'] = 0
    dataset.loc[dataset['am_ind_only_ighisp'] == 1, 'black_not_other_known'] = 0
    dataset.loc[dataset['asian_only_ighisp'] == 1, 'black_not_other_known'] = 0
    dataset.loc[dataset['east_asian_only_ighisp'] == 1, 'black_not_other_known'] = 0

    dataset.loc[dataset['white_only'] == 1, 'racial_minority'] = 0
    dataset.loc[dataset['black_only'] == 1, 'racial_minority'] = 1
    dataset.loc[dataset['am_ind_only'] == 1, 'racial_minority'] = 1
    dataset.loc[dataset['asian_only'] == 1, 'racial_minority'] = 1
    dataset.loc[dataset['east_asian_only'] == 1, 'racial_minority'] = 1
    dataset.loc[dataset['hispanic_only'] == 1, 'racial_minority'] = 1
    dataset.loc[dataset['multi_race_whisp'] == 1, 'racial_minority'] = 1
    
    return dataset