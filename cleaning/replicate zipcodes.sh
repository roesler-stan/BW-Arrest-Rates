#!/bin/bash

# ASSUMPTIONS: pres12_counties.csv, and state_regions.csv are present in Data folder
# with needed NIBRS, LEMAS, and crosswalk files in their respective folders

# Crosswalk files from https://www.icpsr.umich.edu/icpsrweb/DSDR/studies/4634
python clean_crosswalk.py

# Create LEMAS 2007 and 2013 files, making lemas_07.csv and lemas_13.csv
python create_lemas.py

# Clean ACS files to create acs_zipcodes_13.csv
python acs_zipcodes.py

# Convert NIBRS 2013 offenders .txt file to offenders_2013_raw.csv and offenders_2013.csv
python clean_raw_nibrs.py

# Merge datasets, creating offenders_lemas_acs_2013.csv and acs_zipcodes_13_pres12.csv
python merge_datasets.py

# Clean merged dataset, make offenders_lemas_acs_2013_clean1.csv
python clean_merged.py

# Clean offenders_lemas_acs_2013_clean.csv to include budget variables grouped by agency and zip code, creating offenders_lemas_acs_2013_clean2.csv
# Requires reading data into memory (rather than csv used in clean_merged.py)
python clean_merged_grouping.py