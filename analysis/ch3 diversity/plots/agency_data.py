import rpy2.robjects as robjects
from rpy2.robjects import pandas2ri
import pandas as pd
import numpy as np

def main():
    directory = "~/Dropbox/Projects/Mugshots Project/Data/"
    infile = directory + "ch3.RData"
    outfile = directory + 'wofficers_byoffense.csv'
    robjects.r.load(infile)
    df = robjects.r['dataset']
    df = pd.DataFrame(pandas2ri.ri2py(df))

    offenses = ("Robbery", "Aggravated Assault", "Simple Assault", "Intimidation", "Weapon", "Shoplifting", "Vandalism", "Drugs Narcotics", "Drug Equipment")
    all_data = calculate_stats(df)
    all_data = all_data.rename(columns = {'arrested': 'arrested_all', 'offenders_count': 'offenders_count_all'})
    for offense in offenses:
        offense_var = offense.lower().replace(' ', '_')
        subset = find_subset(df, offense_var)
        subset = subset[['ori', 'black_not_white', 'arrested']]
        # Calculate stats for this offense
        arrested_df = calculate_stats(subset)
        arrested_df = arrested_df.rename(columns = {'arrested': 'arrested_' + offense_var, 'offenders_count': 'offenders_count_' + offense_var})
        # Merge with existing dataset
        all_data = all_data.merge(arrested_df, on=['ori', 'black_not_white'], how='outer')

    states_file = directory + 'states key.csv'
    states = pd.read_csv(states_file).set_index('fullname').to_dict()['abbreviation']
    ori_data = df.groupby(['ori']).agg({'w_officers_percent': np.mean, 'city': np.max, 'state_name': np.max}).reset_index()
    ori_data['state'] = ori_data['state_name'].map(states.get)
    ori_data = ori_data.drop('state_name', axis=1)
    all_data = all_data.merge(ori_data, on=['ori'], how='left')
    first_cols = ['ori', 'city', 'state', 'w_officers_percent', 'black_not_white']
    cols = first_cols + [c for c in all_data.columns if c not in first_cols]
    all_data['black_not_white'] = all_data['black_not_white'].astype(int)
    all_data[cols].to_csv(outfile, index=False)

def calculate_stats(df):
    cols = ['ori', 'black_not_white']
    def known(v):
        return np.sum(~np.isnan(v))
    counts = df.groupby(cols).agg({'arrested': known}).reset_index()
    counts = counts.rename(columns = {'arrested': 'offenders_count'})
    means = df.groupby(cols)['arrested'].mean().reset_index()
    means['arrested'] = means['arrested'] * 100
    stats = means.merge(counts, on=cols, how='left')
    return stats

def find_subset(df, offense):
    subset = df[df['offense_' + offense] == 1]
    subset = subset[(subset['arrested'] == 0) | (subset['arrest_' + offense] == 1)]
    return subset

if __name__ == "__main__":
    main()