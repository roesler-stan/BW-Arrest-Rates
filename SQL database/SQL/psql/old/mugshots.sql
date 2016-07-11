psql --host=mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com --port=5432 --username=roesler --password --dbname=Mugshots

\copy (SELECT * FROM mugshots_july2015 as mt WHERE mt.gender = 'male' and (mt.date_year = 2014 or mt.date_year = 2015) and mt.county_no IS NOT NULL) To 'mugshots_july_male_1415.csv' With CSV HEADER QUOTE '"';

-- create mugshots_july_male_1415 in PGAdmin
\copy mugshots_july_male_1415 FROM 'mugshots_july_male_1415.csv' CSV HEADER;

\copy (SELECT * FROM mugshots_july_male_1415 LEFT OUTER JOIN july_charges ON mugshots_july_male_1415.arrest_id = july_charges.charges_arrest_id) To 'mugshots_july_male_1415_ac.csv' With CSV HEADER QUOTE '"';

-- create mugshots_july_male_1415_ac in PGAdmin
\copy mugshots_july_male_1415_ac FROM 'mugshots_july_male_1415_ac.csv' CSV HEADER;

\copy (SELECT * FROM mugshots_july_male_1415_ac LEFT OUTER JOIN acs_counties_13_rpl_naois ON mugshots_july_male_1415_ac.county_no = acs_counties_13_rpl_naois.acs_county_no) To 'mugshots_july2015_male_acs_rpl_naois.csv' With CSV HEADER QUOTE '"';



