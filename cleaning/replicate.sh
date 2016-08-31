#!/bin/bash
# Assumes that NIBRS, LEMAS, and crosswalk files are in their respective folders

# # Clean CQPress voting data
python clean_pres12.py

# # Crosswalk files from https://www.icpsr.umich.edu/icpsrweb/DSDR/studies/4634
python clean_crosswalk.py

# # Create LEMAS 2007 and 2013 files, making lemas_07.csv, lemas_13.csv, and lemas_13_clean.csv
python create_lemas.py

# # Clean ACS files to create acs_counties_13.csv
python acs_counties.py

# # Convert NIBRS 2013 offenders .txt file to offenders_2013_raw.csv and offenders_2013.csv
python clean_raw_nibrs.py

# # Merge datasets, creating offenders_2013_caplg_ucr.csv
# # I did this on Corn in case it wouldn't work on my local computer
python merge_sql_corn.py

# Clean merged dataset, make offenders_2013_caplg_ucr_clean1.csv
python clean_merged.py

# Drop unneeded columns to reduce file size, make offenders_2013_caplg_ucr_clean1_small.csv
python drop_cols.py

# Make offenders_2013_caplg_ucr_clean2.csv
# Clean offenders_2013_caplg_ucr_clean1_small.csv to include budget variables grouped by agency and county, creating offenders_lemas_acs_2013_clean2.csv
# Requires reading data into memory (rather than csv used in clean_merged.py)
python clean_merged_grouping.py
