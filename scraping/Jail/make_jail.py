import make_dataset as md
import imp
gc = imp.load_source('general_clean', '../general_clean.py')


def main(input_file, output_file, sources_file):
	# Read json file to dataframe
	dataset = md.json_to_pandas(input_file)

	# pull out the important variables
	dataset = md.clean_vars(dataset, sources_file)

	# Now clean the data using the general file
	to_clean = ['race', 'gender']
	keeping = ['age', 'eyes', 'facility', 'hair', 'height',
       'notes', 'ref #', 'weight', 'charges', 'id',
       'jail_address1', 'jail_address2', 'jail_city', 'jail_name',
       'jail_state', 'jail_url', 'name', 'book_year', 'source',
       'arrest_id', 'charges_string', 'source_text', 'source_text_clean',
       'date', 'state']

	gc.clean_dataset(dataset, output_file, to_clean, keeping)

# import make_jail as mj
# mj.main('../../Data/Jail API/jail', '../../Data/SQL Input/arrests_j1.csv', '../../Data/Jail API/jail_sources.csv')