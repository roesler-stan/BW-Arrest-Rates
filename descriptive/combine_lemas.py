""" Merge 2007 and 2013 LEMAS file to check how many agencies overlap. """

import pandas

file7 = 'lemas7.csv'
file13 = 'lemas13.csv'

lemas7 = pandas.read_csv(file7)
lemas13 = pandas.read_csv(file13)

data = lemas7.merge(lemas13, how = 'inner', left_on = 'ORI', right_on = 'ori7')

lemas7['ORI'].count()
lemas13['ori7'].count()
data['ori7'].count()
# 1,142 are matched, from about 2,800 in each of the other datasets