import pandas as pd

filename = '../Data/offenders_2013_raw.csv'
filename = '../Data/offenders_2013.csv'
filename = '../Data/offenders_2013_caplg_ucr.csv'

filename = '../Data/offenders_2013_caplg_ucr_clean2.csv'
df = pd.read_csv(filename)


df['race'].value_counts()

df = df[df['type'] == 1]
df = df[df['sex'] == 'male']
df = df[df['cleared_exceptionally'] == -6]


# raw, offenders_2013, offenders_2013_caplg_ucr, offenders_2013_caplg_ucr_clean2
1129855 black
2215013 white
total race known 3406916


intake, detention, adjudication, and disposition