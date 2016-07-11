import pandas
import statsmodels.iolib.summary2
from statsmodels.iolib.summary2 import summary_params
from statsmodels.iolib.summary2 import summary_col
import statsmodels.genmod.generalized_estimating_equations as sgm
import statsmodels.genmod as sg

def my_col_params(result, float_format='%.4f', stars=True):
    '''To correct stars levels for latex output
    Stack coefficients and standard errors in single column
    '''

    # Extract parameters
    res = summary_params(result)
    # Format float
    for col in res.columns[:2]:
        res[col] = res[col].apply(lambda x: float_format % x)
    # Std.Errors in parentheses
    res.ix[:, 1] = '(' + res.ix[:, 1] + ')'
    # Significance stars
    if stars:
        idx = res.ix[:, 3] < .05
        res.ix[:, 0][idx] = res.ix[:, 0][idx] + '*'
        idx = res.ix[:, 3] < .01
        res.ix[:, 0][idx] = res.ix[:, 0][idx] + '*'
        idx = res.ix[:, 3] < .001
        res.ix[:, 0][idx] = res.ix[:, 0][idx] + '*'
    # Stack Coefs and Std.Errors
    res = res.ix[:, :2]
    res = res.stack()
    res = pandas.DataFrame(res)
    res.columns = [str(result.model.endog_names)]
    return res

statsmodels.iolib.summary2._col_params = my_col_params

def make_table(model1, model2, outfile):
    """
    Write a table for given models to LaTeX and HTML files
    e.g.
        model1 = clustered_logit(dataset, 'black_not_white', 'w_officers_percent', officers_controls + zipcode_controls, 'county_no')
        model2 = sgm.GEE.from_formula('black_not_white ~ w_officers_percent ' + controls1, groups = 'county_no', data = dataset, family = fam, cov_struct = ind).fit()
    """

    results = [model1, model2]
    mnames = ['Model 1', 'Model 2']
    info = {'N':lambda x: "{0:,d}".format(int(x.model.nobs)),
            'Clusters':lambda x: "{0:,d}".format(int(x.model.num_group))}
    results_fit = [result.fit() for result in results]
    table = summary_col(results_fit, model_names = mnames, info_dict = info, float_format='%.3f', stars = True)

    with open (outfile + '.tex', 'w') as mfile:
       mfile.write(table.as_latex())

    with open (outfile + '.html', 'w') as mfile:
       mfile.write(table.as_html())

def make_controls(c_list):
    controls_string = ''
    for var in c_list:
        controls_string += ' + ' + var
    return controls_string

def clustered_logit(data_input, dv, iv, control_vars = [], groups = 'county_no'):
    fam = sg.families.Binomial()
    ind = sgm.Independence()

    controls_string = make_controls(control_vars)
    i_vars = iv + ' + ' + controls_string

    return sgm.GEE.from_formula(dv + ' ~ ' + i_vars, groups, data = data_input, family = fam, cov_struct = ind)
    
    # weight = 1./data_input[weight_input]