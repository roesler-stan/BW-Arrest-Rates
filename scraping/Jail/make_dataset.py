# To read the JSON from Jail.com and make a pandas dataframe
# TO DO: include results data, like, how many pages / limit


import json
import pandas
import re

def json_to_pandas(input_file):
	with open(input_file, 'r') as jfile:
		data = json.load(jfile)

	# Add each dictionary to the array of records
	records = []

	for record in data:
		person_dict = {}

		for value in ['id', 'name', 'book_date']:
			if record.has_key(value):
				person_dict[value] = record[value]
		
		# 'details' contains Gender, Race, Age, Facility, Height...
		if record.has_key('details'):
			for key, value in record['details']:
				person_dict[key] = value

		# Charges
		if record.has_key('charges'):
			person_dict['charges'] = tuple(record['charges'])

		if record.has_key('jail'):
			for key in record['jail'].keys():
				person_dict['jail_' + key] = record['jail'][key]

		records.append(person_dict)

	return pandas.DataFrame(records)

def clean_vars(dataset, sources_file):
	dataset['book_date'] = pandas.to_datetime(dataset['book_date'], coerce = True)
	dataset['book_year'] = dataset['book_date'].dt.year

	# Make column names lowercase
	dataset = dataset.rename(columns=lambda x: str(x.lower()))

	def make_lower(possible_string):
		if isinstance(possible_string, basestring):
			return possible_string.lower()
		else:
			return possible_string

	# Making string values lowercase
	dataset = dataset.applymap(make_lower)

	#dataset['charges'] = dataset['charges'].str.decode('ascii').str.encode('utf-8')

	dataset['charges_string'] = dataset['charges'].astype(str).str.lower

	dataset = dataset.rename(columns = {'age (at arrest)':'age', 'book_date':'date'})

	dataset['source'] = dataset['id'].str.split('/').str[1].str.split('/').str[0]
	dataset['arrest_id'] = dataset['id'].str.split('/').str[-1]

	dataset = clean_sources(dataset, sources_file)

	return dataset

# Adding source name from sources.csv
def clean_sources(dataset, sources_file):
	sources = {}
	sources_data = pandas.read_csv(sources_file)
	for i, row in sources_data.iterrows():
		sources[row['ID']] = row['Name'].lower()

	def get_source(source_string):
		if sources.has_key(source_string):
			return str(sources[source_string])

	dataset['source_text'] = dataset['source'].map(get_source)

	# Checks if a word matches a bad regex, and if so, removes it from the clean words list
	def remove_common(source_string):
		bad_words = ["(^|[^a-z])police", "(^|[^a-z])sheriff", "(^|[^a-z])depart", "(^|[^a-z])agency", "(^|[^a-z])office",
			"(^|[^a-z])jail", "(^|[^a-z])county", "(^|[^a-z])detention", "(^|[^a-z])center", "(^|[^a-z])regional",
			"(^|[^a-z])city of", "(^|[^a-z])correction", "(^|[^a-z])facilit", "(^|[^a-z])bureau", "xc2|xa0|\*", "(^|[^a-z])adult",
			"(^|[^a-z])facitlity", "(^|[^a-z])of($|[^a-z])"]

		clean_words = []
		for word in source_string.split():
			clean_words.append(word)
			for bad_word in bad_words:
				if re.search(re.compile(bad_word), word):
					clean_words.remove(word)
					break

		clean_string = ''
		for clean_word in clean_words:
			clean_string += clean_word + ' '

		return clean_string.strip()

	dataset['source_text_clean'] = dataset['source_text'].map(remove_common)

	def get_state(source_string):
		return source_string.split('-')[0]

	dataset['state'] = dataset['source'].map(get_state)

	return dataset