import pandas
import numpy
import math
import re

def write_offense_table(nibrs_data, offense_file):
    table_data = offense_table(nibrs_data)
    table_data = table_data.sort_values('Offense Count', ascending = False)
 
    with open (offense_file, 'w') as f:
        f.write(pandas.DataFrame.to_csv(table_data, float_format = '%.2f', index = False))
 
def write_offense_table_detailed(nibrs_data, offense_file_wofficers_divres, offense_file_w_officers_percent):
    min_wofficers_divres = 1
    # 1.271 is nibrs_data['wofficers_divres'].mean()
    max_wofficers_divres = 1.271
    low_wofficers_divres = nibrs_data[nibrs_data['wofficers_divres'] < min_wofficers_divres]
    mid_wofficers_divres = nibrs_data[nibrs_data['wofficers_divres'] >= min_wofficers_divres]
    mid_wofficers_divres = mid_wofficers_divres[mid_wofficers_divres['wofficers_divres'] <= max_wofficers_divres]
    high_wofficers_divres = nibrs_data[nibrs_data['wofficers_divres'] > max_wofficers_divres]
 
    # 89.7 is agency_means['w_officers_percent'].mean()
    min_w_officers_percent = 75
    max_w_officers_percent = 87
    low_w_officers_percent = nibrs_data[nibrs_data['w_officers_percent'] < min_w_officers_percent]
    mid_w_officers_percent = nibrs_data[nibrs_data['w_officers_percent'] >= min_w_officers_percent]
    mid_w_officers_percent = mid_w_officers_percent[mid_w_officers_percent['w_officers_percent'] <= max_w_officers_percent]
    high_w_officers_percent = nibrs_data[nibrs_data['w_officers_percent'] > max_w_officers_percent]
 
    table_data_list = []
    subsets = (low_wofficers_divres, mid_wofficers_divres, high_wofficers_divres, low_w_officers_percent, mid_w_officers_percent, high_w_officers_percent)
    for subset in subsets:
        table_data = offense_table(subset)
        table_data_list.append(table_data)
 
    table_low_wofficers_divres = table_data_list[0]
    table_mid_wofficers_divres = table_data_list[1]
    table_high_wofficers_divres = table_data_list[2]
 
    table_low_wofficers_divres['White Officers per White Resident'] = '< 1'
    table_mid_wofficers_divres['White Officers per White Resident'] = '1 to 1.271'
    table_high_wofficers_divres['White Officers per White Resident'] = '> 1.271'
 
    table_wofficers_divres = table_low_wofficers_divres.append(table_mid_wofficers_divres, ignore_index = True)
    table_wofficers_divres = table_wofficers_divres.append(table_high_wofficers_divres, ignore_index = True)
     
    table_wofficers_divres['White Officers per White Resident'] = table_wofficers_divres['White Officers per White Resident'].astype('category')
    table_wofficers_divres['White Officers per White Resident'] = table_wofficers_divres['White Officers per White Resident'].cat.reorder_categories(['< 1', '1 to 1.271', '> 1.271'], ordered = True)
 
    # Find the offenses in order of descending offense count
    offense_index = list(table_wofficers_divres.groupby('Offense')['Offense Count'].mean().sort_values(ascending = False).index)
 
    # lower numbers mean more common offenses
    def find_order(offense):
        return offense_index.index(offense)
  
    table_wofficers_divres['Offense to Sort'] = table_wofficers_divres['Offense'].map(find_order)
    table_wofficers_divres = table_wofficers_divres.sort_values(['Offense to Sort', 'White Officers per White Resident'], ascending = True)
    table_wofficers_divres = table_wofficers_divres[['Offense', 'White Officers per White Resident', 'Offense Count', 'Arrest Count',
    'Arrest Rate', '% Offenders Black', '% Arrestees Black', '% Offenders / % Arrestees Black']]
 
    with open (offense_file_wofficers_divres, 'w') as f:
        f.write(pandas.DataFrame.to_csv(table_wofficers_divres, float_format = '%.2f', index = False))
 
    # Now make the tables for % officers white
    table_low_w_officers_percent = table_data_list[3]
    table_mid_w_officers_percent = table_data_list[4]
    table_high_w_officers_percent = table_data_list[5]
 
    table_low_w_officers_percent['Percent Officers White'] = '< 75%'
    table_mid_w_officers_percent['Percent Officers White'] = '75 to 87%'
    table_high_w_officers_percent['Percent Officers White'] = '> 87%'
 
    table_w_officers_percent = table_low_w_officers_percent.append(table_mid_w_officers_percent, ignore_index = True)
    table_w_officers_percent = table_w_officers_percent.append(table_high_w_officers_percent, ignore_index = True)
 
    table_w_officers_percent['Percent Officers White'] = table_w_officers_percent['Percent Officers White'].astype('category')
    table_w_officers_percent['Percent Officers White'] = table_w_officers_percent['Percent Officers White'].cat.reorder_categories(['< 75%', '75 to 87%', '> 87%'], ordered = True)
 
    # Find the offenses in order of descending offense count
    offense_index = list(table_w_officers_percent.groupby('Offense')['Offense Count'].mean().sort_values(ascending = False).index)

    table_w_officers_percent['Offense to Sort'] = table_w_officers_percent['Offense'].map(find_order)
    table_w_officers_percent = table_w_officers_percent.sort_values(['Offense to Sort', 'Percent Officers White'], ascending = True)
    table_w_officers_percent = table_w_officers_percent[['Offense', 'Percent Officers White', 'Offense Count', 'Arrest Count',
    'Arrest Rate', '% Offenders Black', '% Arrestees Black', '% Offenders / % Arrestees Black']]
     
    with open (offense_file_w_officers_percent, 'w') as f:
        f.write(pandas.DataFrame.to_csv(table_w_officers_percent, float_format = '%.2f', index = False))
 
def offense_table(nibrs_data):
    """ Make table (but don't write to file) """
 
    # Remove type B offenses, which are only present when there is an arrest
    type_b_offenses = ['bad_check', 'loitering', 'disorder', 'dui', 'drunk', 'family_nonv', 'liquor_law', 'peeping_tom', 'runaway', 'trespass', 'other_offense']
    offense_vars = [var for var in nibrs_data.columns if re.search(re.compile('^offense_'), var) and not re.search(re.compile('segments|residence'), var) and var.split('offense_')[1] not in type_b_offenses]
    arrest_vars = [var for var in nibrs_data.columns if re.search(re.compile('^arrest_'), var) and not re.search(re.compile('transaction|type|seqno|date|residence'), var) and var.split('arrest_')[1] not in type_b_offenses]
 
    offense_counts = {}
    offender_arrest_counts = {}
    offense_arrest_rates = {}
    arrest_b_counts = {}
    offender_arrests_bpercent = {}
    offenders_bpercent = {}
    offenders_div_arrestees_bpercent = {}
    index_vars = set()
 
    offense_counts['all'] = nibrs_data['recsofr'].count()
    offender_arrest_counts['all'] = nibrs_data['arrested'].sum()
    if offender_arrest_counts['all'] != 0:
        offense_arrest_rates['all'] = (float(offender_arrest_counts['all']) / offense_counts['all']) * 100
    else:
        offense_arrest_rates['all'] = numpy.nan
    index_vars.add('all')
 
    black_offenders = nibrs_data[nibrs_data['black_not_white'] == 1]
    white_offenders = nibrs_data[nibrs_data['black_not_white'] == 0]
 
    black_offenders_count = black_offenders['arrested'].count()
    white_offenders_count = white_offenders['arrested'].count()
    total_offenders_count = black_offenders_count + white_offenders_count
    if total_offenders_count > 0:
        offenders_bpercent['all'] = (float(black_offenders_count) / total_offenders_count) * 100
 
    black_arrests_count = black_offenders['arrested'].sum()
    white_arrests_count = white_offenders['arrested'].sum()
    total_arrests_count = black_arrests_count + white_arrests_count
    if total_arrests_count > 0:
        offender_arrests_bpercent['all'] = (float(black_arrests_count) / total_arrests_count) * 100
 
    for var in offense_vars:
        clean_var = var.split('offense_', 1)[1]
        index_vars.add(clean_var)
        offense_counts[clean_var] = nibrs_data[var].sum()
        if 'arrest_' + clean_var in nibrs_data.columns:
            offender_arrest_counts[clean_var] = nibrs_data[nibrs_data[var] == 1]['arrest_' + clean_var].sum()
            if offense_counts[clean_var] > 0:
                offense_arrest_rates[clean_var] = (float(offender_arrest_counts[clean_var]) / offense_counts[clean_var]) * 100
         
        black_offenders_count = black_offenders[black_offenders[var] == 1]['arrested'].count()
        white_offenders_count = white_offenders[white_offenders[var] == 1]['arrested'].count()
        total_offenders_count = black_offenders_count + white_offenders_count
        if total_offenders_count > 0:
            offenders_bpercent[clean_var] = (float(black_offenders_count) / total_offenders_count) * 100
 
        if 'arrest_' + clean_var in nibrs_data.columns:
            black_arrests = black_offenders[black_offenders[var] == 1]['arrest_' + clean_var].sum()
            white_arrests = white_offenders[white_offenders[var] == 1]['arrest_' + clean_var].sum()
            total_arrests = black_arrests + white_arrests
            if total_arrests > 0:
                offender_arrests_bpercent[clean_var] = (float(black_arrests) / total_arrests) * 100
 
    for var, value in offender_arrests_bpercent.iteritems():
        if value != 0:
            offenders_div_arrestees_bpercent[var] = offenders_bpercent[var] / offender_arrests_bpercent[var]
 
    index_vars_list = list(index_vars)
 
    data_dict = {'Offense Count': offense_counts, 'Arrest Count': offender_arrest_counts, 'Arrest Rate': offense_arrest_rates,
    '% Offenders Black': offenders_bpercent, '% Arrestees Black': offender_arrests_bpercent, '% Offenders / % Arrestees Black': offenders_div_arrestees_bpercent}
    table_data = pandas.DataFrame(data_dict, index = index_vars_list)
 
    def table_format(number):
        if math.isnan(number):
            return 'N/A'
        if number > 100:
            return '{0:,d}'.format(int(number))
        else:
            return str(int(number))
 
    table_data['Offense'] = table_data.index
    table_data['Offense'] = table_data['Offense'].replace(to_replace = '_', value = ' ', regex = True)
    table_data['Offense'] = table_data['Offense'].str.title()
 
    table_data = table_data[['Offense', 'Offense Count', 'Arrest Count', 'Arrest Rate', '% Offenders Black', '% Arrestees Black', '% Offenders / % Arrestees Black']]
    return table_data