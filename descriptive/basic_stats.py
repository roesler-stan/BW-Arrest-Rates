import pandas
import numpy
import sys

def basic_stats(nibrs_data, fips_county1_no_means, us_data, basic_file):
    orig_stdout = sys.stdout
    f = file(basic_file, 'w')
    sys.stdout = f

    print '% of US residents: ' + str((fips_county1_no_means['total_residents'].sum() / us_data['total_residents'].sum()) * 100)
    print '\n'

    print '# of agencies with basic variables non-missing: ' + str(float(len(nibrs_data['ori'].unique())))
    print '\n'

    print '# of US counties: ' + str(float(len(nibrs_data['fips_county1_no'].unique())))
    print '\n'
    print '% of US counties: ' + str((float(len(nibrs_data['fips_county1_no'].unique())) / float(len(us_data['county_no'].unique()))) * 100)
    print '\n'

    print '# of non-hispanic black and white offenders: ' + str(len(nibrs_data.index))
    print '\n'

    print 'Mean age'
    print nibrs_data['age'].mean()
    print '\n'

    print '% male and female'
    print (nibrs_data['sex'].value_counts() / nibrs_data['sex'].count().astype(float)) * 100
    print '\n'

    print '% offenders black, not white, excluding hispanics:'
    print (nibrs_data['black_not_white'].mean() * 100)
    print '\n'

    print '# of offenders with ethnicity known:'
    print nibrs_data['ethnicity'].value_counts()
    print '\n'

    print '% of offenders by race and sex'
    print pandas.crosstab(nibrs_data['black_not_white'], nibrs_data['sex']).apply(lambda r: r/r.sum(), axis = 1)
    print '\n'

    print '# of offenders arrested'
    print nibrs_data['arrested'].value_counts()
    print '\n'
    print '# of offenders arrested by race'
    print pandas.crosstab(nibrs_data['arrested'], nibrs_data['black_not_white'])
    print '\n'
    print '% of offenders arrested by race'
    print pandas.crosstab(nibrs_data['arrested'], nibrs_data['black_not_white']).apply(lambda r: r/r.sum(), axis = 1)
    print '\n'

    print '% of offenders who are in an agency with fewer than the agency mean % of officers white'
    print (nibrs_data['w_officers_percent'] < 89.7).mean()
    print '\n'

    print 'Offenders average agency % officers white'
    print nibrs_data['w_officers_percent'].mean()
    print '\n'
    
    print 'Offenders SD for agency % officers white'
    print nibrs_data['w_officers_percent'].std()
    print '\n'

    # National B-W AtoR
    fips_county1_nos_data = nibrs_data.groupby('fips_county1_no')

    print 'counties\' average B-to-W Arrest-to-Resident ratio, excluding hispanics'
    b_ator = fips_county1_nos_data['black_not_white'].sum() / fips_county1_nos_data['b_residents'].mean()
    w_ator = (fips_county1_nos_data['black_not_white'].count() - fips_county1_nos_data['black_not_white'].sum()) / fips_county1_nos_data['w_residents'].mean()
    ator = b_ator / w_ator
    ator_noninf = ator[ator != numpy.inf]
    print ator_noninf.mean()
    print '\n'

    sys.stdout = orig_stdout
    f.close()