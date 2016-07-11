
# coding: utf-8

# In[1]:

import pandas
import re
import string


# In[10]:

# This expands it to have many charges per arrest_id
def expand_charges(dataset):
    dataset['charge_edit'] = dataset.loc[:,'charge_combo'].astype(str).map(fix_string)
    
    dataset = dataset.loc[:,('charge_edit', 'arrest_id')]
    
    dataset = pandas.DataFrame(dataset['charge_edit'].tolist(), dataset['arrest_id']).stack()
    dataset = dataset.to_frame().reset_index(level = 0, drop = False)
    dataset.columns = ['arrest_id', 'charge']
    dataset.reset_index(drop = True, inplace = True)

    dataset = dataset[dataset['arrest_id'].notnull()]
    dataset = dataset[dataset['charge'].notnull()]
    
    return dataset


# In[ ]:

# Given one string of charges
# Former strings are surrounded by ' || '
# Former tuples are surrounded by ' +++ '
def fix_string(charge_str):
    charges = []

    # For each former tuple in the string, find the text between +++'s
    while ' +++ ' in charge_str:
        tuple_str = charge_str.split(' +++ ')[1]

        # If there is only one +++ (weirdly), stop here
        if len(charge_str.split(' +++ ')) == 2:
            break

        # While there are still quotes left, indicating tuple value
        while '\'' in tuple_str:
            # Finding the text to the right of the left quote and left of the right quote
            c_str = tuple_str.split('\'')[1]
            # If there is only one quote, stop here
            if len(tuple_str.split('\'')) == 2:
                break
            # Otherwise, append the quoted item and delete it from the string
            charges.append(c_str)
            # the second number is the maxsplit, so it returns everything to the right
            tuple_str = string.split(tuple_str, '\'', 2)[-1]

        # Remove the tuple from the charge string
        charge_str = string.split(charge_str, ' +++ ', 2)[-1]

    # For each string, find it and remove it
    while '|| ' in charge_str:
        str_str = charge_str.split(' || ')[1]
        # Append the entire string, b/c can't be sure that commas aren't within a single charge
        charges.append(str_str)

        # If there is only one || (weirdly), stop here
        if len(charge_str.split(' || ')) == 2:
            break

        # Remove that string
        charge_str = string.split(charge_str, ' || ', 2)[-1]

    return tuple(charges)

