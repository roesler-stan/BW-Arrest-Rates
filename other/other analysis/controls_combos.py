# Robustness check - all possible control combinations

import itertools
import pandas
import statsmodels.genmod.generalized_estimating_equations as sgm
import statsmodels.genmod as sg
import statsmodels.formula.api as smf
import matplotlib.pylab as pylab

def make_combos(controls_list):
    """ Generate list of controls combinations (grows exponentially with each additional control) """
    combos = []
    for length in range(len(controls_list) + 1):
        found_list = list(itertools.combinations(controls_list, length))
        combos.extend(found_list)
    return combos

def all_results(dataset):
    """ Create dataset with results from all possible models """

    controls_list = ['control1', 'control2', 'control3']
    chosen_combos = make_combos(controls_list)

    results_data = pandas.DataFrame()
    other_controls = ['control4', 'control5']
    model_no = 0
    iv = 'black_not_white'
    dv = 'w_arrested'
    groups = 'zipcode'
    fam = sg.families.Binomial()
    ind = sgm.Independence()

    for control_combo in chosen_combos:
        given_controls = other_controls + control_combo
        try:
            controls_string = ''
            for var in given_controls:
                controls_string += ' + ' + var
                i_vars = iv + ' + ' + controls_string

            model = sgm.GEE.from_formula(dv + ' ~ ' + i_vars, groups = groups, data = dataset, family = fam, cov_struct = ind)
            model_fit = model.fit()

            for control in other_controls + ac:
                if control in given_controls:
                    results_data.loc[model_no, control] = 1
                else:
                    results_data.loc[model_no, control] = 0

            results_data.loc[model_no, 'race_coeff'] = model_fit.params[1]
            results_data.loc[model_no, 'race_pvalue'] = model_fit.pvalues[1]

            for i, var in enumerate(given_controls):
                var_index = i + 1
                results_data.loc[model_no, var + '_coeff'] = model_fit.params[var_index]
                results_data.loc[model_no, var + '_pvalue'] = model_fit.pvalues[var_index]
                results_data.loc[model_no, 'N'] = model.nobs

            model_no += 1
        except:
            print 'failed with: ' + str(control_combo)

    return results_data

def plot_models(results_data):
    plot = results_data[results_data['offenders_b_percent'] == 0]['race_pvalue'].plot(kind = 'kde', color = 'blue')
    results_data[results_data['offenders_b_percent'] == 1]['race_pvalue'].plot(kind = 'kde', color = 'red')

    plt.title('All models predicting % Arrestees White \n with and without each control variable (N = )', size = 18)
    plt.xlabel('% __ Coefficient', size = 16)
    plt.ylabel('Density', size = 16)
    plot.tick_params(axis='both', which='major', labelsize = 14)
    pylab.rcParams['figure.figsize'] = 18, 14

    fig = plot.get_figure()
    fig.savefig('all_pd_coeff.png', dpi = 1000)

def predict_coef(results_data, controls_string):
    """ To see which variables cause the officers_white coefficient to go up or down """
    smf.ols(formula = 'race_coeff ~ ' + controls_string, data = results_data).fit().summary()

def predict_coef_median(results_data, controls):
"""
    To see which variables predict the race coefficient - with all possible combinations
    I took the median to avoid outliers' influence
"""
    for var in controls:
        print var
        print results_data[var + '_coeff'].median(), results_data[var + '_pvalue'].median()