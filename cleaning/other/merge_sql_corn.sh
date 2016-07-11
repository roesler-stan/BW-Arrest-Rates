cd ../../Data
scp offenders_2013.csv crosswalk_agencies.csv lemas_13_clean.csv acs_counties_13.csv pres12_counties.csv governors/governors_2015.csv ucr13_arrests_offenses.csv roesler@corn.stanford.edu:/farmshare/user_data/roesler/NIBRS/

cd ../Code/cleaning
scp merge_sql_corn.py roesler@corn.stanford.edu:/farmshare/user_data/roesler/NIBRS/
