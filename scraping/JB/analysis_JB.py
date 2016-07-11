import numpy
import pandas
import create_dataset


def set_up():
	dataset = pandas.read_pickle('JB_profiles_dataset')

	# this overwrites age provided if age is given in the notes section
	for i, row in dataset.iterrows():
		if 'Age:' in row['notes']:
			dataset.loc[i, 'age'] = float(row['notes'].lstrip('Age:').strip())

	# can't put arrays as values?
	#charge_text = row['charges'].splitlines()
	#dataset.loc[i, 'charges'] = [charge.strip().strip('\xe2\x80\xa2').strip() for charge in charge_text if not all(c.isspace() for c in charge)]
	
	#tag_text = str(row['tags']).lstrip('#').splitlines()
	#dataset.loc[i, 'tags'] = [tag for tag in tag_text if not all(t.isspace() for t in tag)]

	return dataset


print pandas.value_counts(pdata['booked_date'])
print pandas.value_counts(pdata['gender'])
print pandas.value_counts(pdata['charges'])
