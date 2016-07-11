import numpy
import numbers

float_vars = ['bdgt_ttl', 'pers_fts_racetot', 'pers_fts_wht', 'pers_fts_blk', 'pers_pdsw_mft', 'pers_pdsw_mpt', 'pers_pdsw_fft', 'pers_pdsw_fpt',
'w_officers_percent', 'b_officers_percent', 'w_residents_percent', 'b_residents_percent',  'hir_edu_no', 'hir_edu_hs', 'hir_edu_scol', 'hir_edu_ad', 'hir_edu_bd']

def main(row):
    row = make_floats(row)
    row = calc_police(row)
    row = calc_policevres(row)
    row = clean_numeric(row)
    return row

def make_floats(row):
    for var in float_vars:
        if var not in row.keys():
            continue
        row[var] = force_float(row[var])
    return row

def clean_numeric(row):
    """ Convert variables back to integer if appropriate, and remove nans """
    for var in float_vars:
        if var not in row.keys():
            continue
        if row[var].is_integer():
            row[var] = int(row[var])
        if numpy.isnan(row[var]):
            row[var] = None
    return row

def calc_police(row):
    if row['pers_fts_racetot'] != 0:
        row['w_officers_percent'] = (row['pers_fts_wht'] / row['pers_fts_racetot']) * 100
        row['b_officers_percent'] = (row['pers_fts_blk'] / row['pers_fts_racetot']) * 100

    total_gender = (row['pers_pdsw_mft'] + row['pers_pdsw_mpt'] + row['pers_pdsw_fft'] + row['pers_pdsw_fpt'])
    if total_gender != 0:
        row['male_officers_percent'] = ((row['pers_pdsw_mft'] + row['pers_pdsw_mpt']) / total_gender) * 100

    total_gender_ft = (row['pers_pdsw_mft'] + row['pers_pdsw_fft'])
    if total_gender_ft != 0:
        row['male_officers_ft_percent'] = (row['pers_pdsw_mft'] / total_gender_ft) * 100

    row['min_hiring_educ'] = None
    hiring = ['hir_edu_no', 'hir_edu_hs', 'hir_edu_scol', 'hir_edu_ad', 'hir_edu_bd']
    for var in hiring:
        if row[var] == 1:
            row['min_hiring_educ'] = var
            break

    if row['min_hiring_educ'] in ['hir_edu_hs', 'hir_edu_no']:
        row['min_hiring_educ_gths'] = 0
    elif row['min_hiring_educ'] in ['hir_edu_scol', 'hir_edu_ad', 'hir_edu_bd']:
        row['min_hiring_educ_gths'] = 1

    if row['bdgt_ttl']:
        row['bdgt_ttl'] = row['bdgt_ttl'] / 1000000

    return row

def calc_policevres(row):
    if row.has_key('w_officers_percent') and row['w_residents_percent'] != 0:
        row['wofficers_divres'] = row['w_officers_percent'] / row['w_residents_percent']

    if row.has_key('b_officers_percent') and row['b_residents_percent'] != 0:
        row['bofficers_divres'] = row['b_officers_percent'] / row['b_residents_percent']

    return row

def force_float(var):
    """ Try to convert a string that may be a number to a float """
    try:
        var_float = float(var)
    except ValueError:
        var_float = numpy.nan
    return var_float