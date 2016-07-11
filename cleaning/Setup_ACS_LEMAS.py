"""" To clean county-level ACS and LEMAS data """

import pandas
import re

def main(dataset, dtype):
    dataset = fix_thousands(dataset, dtype)
    dataset = prepare_basic(dataset, dtype)

    if dtype == 'LEMAS':
        dataset = calc_police(dataset)

    return dataset

def prepare_basic(dataset, dtype):


    if dtype == 'ACS':
        dataset['percent_males_black'] = (dataset['black_male'].astype(float) / dataset['male_residents']) * 100
        dataset['percent_males_white'] = (dataset['white_male'].astype(float) / dataset['male_residents']) * 100

    return dataset

def fix_thousands(dataset):
    thouvars = ['mean_inc', 'total_residents', 'male_residents', 'black_male', 'white_male', 'black_male_18_19', 'white_male_18_19',
    'male_15_19', 'male_20_24', 'black_male_20_24', 'white_male_20_24', 'black_male_18_24', 'white_male_18_24',
    'pay_sal_ofcr_min', 'pay_sal_ofcr_max', 'pay_sal_sgt_min', 'pay_sal_sgt_max', 'pay_sal_exc_min', 'pay_sal_exc_max']

    for var in thouvars:
        dataset[var] = dataset[var].astype(float)

    dataset['bdgt_ttl'] = dataset['bdgt_ttl'].astype(float)
    dataset['ftsworn'] = dataset['ftsworn'].astype(float)

    dataset.loc[dataset['bdgt_ttl'] != 0, 'bdgt_per_ftoff'] = dataset.loc[dataset['bdgt_ttl'] != 0, 'bdgt_ttl'] / \
    dataset.loc[dataset['bdgt_ttl'] != 0, 'ftsworn']

    return dataset

def calc_police(dataset):
    # ORI-level vars that haven't been renamed
    if 'pers_fts_racetot' in dataset.columns:
        w_officers = 'pers_fts_wht'
        b_officers = 'pers_fts_blk'
        racetot_officers = 'pers_fts_racetot'

        male_ft = 'pers_pdsw_mft'
        male_pt = 'pers_pdsw_mpt'
        female_ft = 'pers_pdsw_fft'
        female_pt = 'pers_pdsw_fpt'

    # county-level vars that have been renamed
    elif 'w_officers' in dataset.columns:
        w_officers = 'w_officers'
        b_officers = 'b_officers'
        racetot_officers = 'racetot_officers'

        male_ft = 'male_officers_ft'
        male_pt = 'male_officers_pt'
        female_ft = 'female_officers_ft'
        female_pt = 'female_officers_pt'

    dataset.loc[dataset[racetot_officers] != 0, 'w_officers_percent'] = \
        (dataset.loc[dataset[racetot_officers] != 0, w_officers] / \
            dataset.loc[dataset[racetot_officers] != 0, racetot_officers]) * 100

    dataset.loc[dataset[racetot_officers] != 0, 'b_officers_percent'] = (dataset.loc[dataset[racetot_officers] != 0, b_officers] / \
         dataset.loc[dataset[racetot_officers] != 0, racetot_officers]) * 100

    dataset['male_officers_percent'] = ((dataset[male_ft] + dataset[male_pt]) / (dataset[male_ft] + dataset[male_pt] + dataset[female_ft] + dataset[female_pt])) * 100

    dataset['male_officers_ft_percent'] = (dataset[male_ft] / (dataset[male_ft] + dataset[female_ft])) * 100

    hiring = ['hir_edu_no', 'hir_edu_hs', 'hir_edu_scol', 'hir_edu_ad', 'hir_edu_bd']
    for var in hiring:
        dataset.loc[dataset[var] == 1, 'min_hiring_educ'] = var

    dataset.loc[dataset['min_hiring_educ'] == 'hir_edu_hs', 'min_hiring_educ_gths'] = 0
    dataset.loc[dataset['min_hiring_educ'] == 'hir_edu_no', 'min_hiring_educ_gths'] = 0
    dataset.loc[dataset['min_hiring_educ'] == 'hir_edu_scol', 'min_hiring_educ_gths'] = 1
    dataset.loc[dataset['min_hiring_educ'] == 'hir_edu_ad', 'min_hiring_educ_gths'] = 1
    dataset.loc[dataset['min_hiring_educ'] == 'hir_edu_bd', 'min_hiring_educ_gths'] = 1

    return dataset

def calc_policevres(dataset):   
    dataset['wofficers_minusres'] = dataset['w_officers_percent'] - dataset['w_residents_percent']
    dataset['bofficers_minusres'] = dataset['b_officers_percent'] - dataset['b_residents_percent']

    dataset.loc[dataset['w_residents_percent'] != 0, 'wofficers_divres'] = \
        dataset.loc[dataset['w_residents_percent'] != 0, 'w_officers_percent'] / \
        dataset.loc[dataset['w_residents_percent'] != 0, 'w_residents_percent']
    dataset.loc[dataset['b_residents_percent'] != 0, 'bofficers_divres'] = \
        dataset.loc[dataset['b_residents_percent'] != 0, 'b_officers_percent'] / \
        dataset.loc[dataset['b_residents_percent'] != 0, 'b_residents_percent']

    return dataset

def prepare_nibrs(dataset):
    for nibrs_type in ['offenders', 'arrests']:
        other_vars = [nibrs_type + '_county_no', nibrs_type + '_zipcode', nibrs_type + '_age']
        for col in [col for col in dataset.columns if re.search('^' + nibrs_type + '_', col) and col not in other_vars]:
            dataset[col + '_w_percent'] = (dataset['w_' + col] / dataset[col]) * 100
            dataset[col + '_b_percent'] = (dataset['b_' + col] / dataset[col]) * 100

    return dataset