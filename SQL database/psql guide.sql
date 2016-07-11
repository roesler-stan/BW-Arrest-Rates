psql --host=mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com --port=5432 --username=roesler --password --dbname=Mugshots
sudo pg_dump --host=mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com --port=5432 --username=roesler --password --dbname=Mugshots --file=NIBRS_Mugshots_Dec2015.sql --format=t --verbose

--createdb -T template0 Mugshots_restored
--psql --host=localhost --port=5433 --dbname=Mugshots_restored --username=postgres
pg_restore --host=localhost --port=5433 --dbname=Mugshots_restored --username=roesler NIBRS_Mugshots_Dec2015.sql

-- To set up 2013 NIBRS arrests and offenders files
	-- clean raw data files on Corn, using NIBRS_2013_Clean.py
	scp NIBRS_2013_Clean.py roesler@corn.stanford.edu:/farmshare/user_data/roesler/Mugshots/NIBRS/

	-- create table using NIBRS 2013 SQL iPython Notebook

	psql --host=mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com --port=5432 --username=roesler --password --dbname=Mugshots

	\copy nibrs_arrests_13 FROM 'nibrs_arrests_2013.csv' CSV HEADER;
	\copy nibrs_offenders_13 FROM 'nibrs_offenders_2013.csv' CSV HEADER;

	-- only include men
	\copy (SELECT * FROM nibrs_arrests_13 as nt WHERE nt.gender = 'male' and nt.fips_county1_no IS NOT NULL) To 'nibrs_arrests_13m.csv' With CSV HEADER QUOTE '"';
	\copy (SELECT * FROM nibrs_offenders_13 as ot WHERE ot.gender = 'male' and ot.fips_county1_no IS NOT NULL) To 'nibrs_offenders_13m.csv' With CSV HEADER QUOTE '"';

	-- create nibrs_arrests_13m in PGAdmin
	\i ../../Code/SQL/Create\ tables/NIBRS/nibrs_offenders_13m.sql

	\copy nibrs_arrests_13m FROM 'nibrs_arrests_13m.csv' CSV HEADER QUOTE '"';
	\copy nibrs_offenders_13m FROM 'nibrs_offenders_13m.csv' CSV HEADER QUOTE '"';
	
-- Code charges
	-- code arrest file's charge dummies
	scp nibrs_charges_a1.sql nibrs_charges_all* roesler@corn.stanford.edu:/farmshare/user_data/roesler/Mugshots/NIBRS/
	\i nibrs_charges_a1.sql
	\i nibrs_charges_all1.sql
	\i nibrs_charges_all2.sql
	\i nibrs_charges_all3.sql
	\i nibrs_charges_all4.sql

	-- code offenders file's arrest charges (ucr_arrest_offense_code1 - 3)
	scp nibrs_charges_o1.sql offenders_arrest_charge* offenders_offense_charge* roesler@corn.stanford.edu:/farmshare/user_data/roesler/Mugshots/NIBRS/
	\i nibrs_charges_o1.sql
	\i offenders_arrest_charge1.sql
	\i offenders_arrest_charge2.sql
	\i offenders_arrest_charge3.sql
	
	-- code offenders file's offense charges (ucr_offense_code1 - 3)
	\i offenders_offense_charge1.sql
	\i offenders_offense_charge2.sql

	-- join to zipcode-level crosswalk to get zipcode
	\copy (SELECT * FROM nibrs_offenders_13m LEFT OUTER JOIN cwzip_view ON nibrs_offenders_13m.ori = cwzip_view.ori9) To 'nibrs_offenders_13m_zip.csv' With CSV HEADER QUOTE '"'

	-- create nibrs_offenders_13m_zip in PGAdmin
	\copy nibrs_offenders_13m_zip FROM 'nibrs_offenders_13m_zip.csv' CSV HEADER QUOTE '"';

-- Join NIBRS offenders and arrestees files
	-- create view of arrestees who aren't in offenders file
	\i nibrs_arrests_13_nonoffenders_view.sql
	\copy (SELECT * FROM nibrs_arrests_13_nonoffenders_view) To 'nibrs_arrests_13_nonoffenders.csv' With CSV HEADER QUOTE '"'

	-- python append_arrestees.py - merge offenders and arrestees files
		-- all arrestees' variables are appended as arrestee1

	-- create nibrs_offenders_arrestees_13 table
	\i nibrs_offenders_arrestees_13.sql
	\copy nibrs_offenders_arrestees_13 FROM 'nibrs_offenders_arrestees_13.csv' CSV HEADER;

	-- add zipcode using ori
	\copy (SELECT * FROM nibrs_offenders_arrestees_13 LEFT OUTER JOIN cwzip_view ON nibrs_offenders_arrestees_13.ori = cwzip_view.ori9) To 'nibrs_offenders_arrestees_13_zip.csv' With CSV HEADER QUOTE '"'

	-- create nibrs_offenders_arrestees_13_zip table
	\i nibrs_offenders_arrestees_13_zip.sql
	\copy nibrs_offenders_arrestees_13_zip FROM 'nibrs_offenders_arrestees_13_zip.csv' CSV HEADER;

	-- join with ori-level lemas data
	\copy (SELECT * FROM nibrs_offenders_arrestees_13_zip LEFT OUTER JOIN lemas_13 ON nibrs_offenders_arrestees_13_zip.ori = lemas_13.ori9) To 'nibrs_offenders_arrestees_13_lemas.csv' With CSV HEADER QUOTE '"'
	
	-- create nibrs_offenders_arrestees_13_lemas table
	\i nibrs_offenders_arrestees_13_lemas.sql
	\copy nibrs_offenders_arrestees_13_lemas FROM 'nibrs_offenders_arrestees_13_lemas.csv' CSV HEADER;

	-- join with zipcode-level ACS data
	\copy (SELECT * FROM nibrs_offenders_arrestees_13_lemas LEFT OUTER JOIN acs_zipcodes_13 ON nibrs_offenders_arrestees_13_lemas.zipcode = acs_zipcodes_13.acs_zipcode) To 'nibrs_offenders_arrestees_13_lemas_acs.csv' With CSV HEADER QUOTE '"'
	
	-- create nibrs_offenders_arrestees_13_lemas_acs table
	\i nibrs_offenders_arrestees_13_lemas_acs.sql
	\copy nibrs_offenders_arrestees_13_lemas_acs FROM 'nibrs_offenders_arrestees_13_lemas_acs.csv' CSV HEADER;

	-- add county-level voting data to make nibrs_offenders_arrestees_13_lemas_acs_pres12.csv
	\copy (SELECT * FROM nibrs_offenders_arrestees_13_lemas_acs LEFT OUTER JOIN pres12_counties_county_no ON cast(nibrs_offenders_arrestees_13_lemas_acs.fips_county1_no as character varying) = pres12_counties_county_no.pres12_county_no) To 'nibrs_offenders_arrestees_13_lemas_acs_pres12_nocharges.csv' With CSV HEADER QUOTE '"'

	\i nibrs_offenders_arrestees_13_lemas_acs_pres12.sql
	\copy nibrs_offenders_arrestees_13_lemas_acs_pres12 FROM 'nibrs_offenders_arrestees_13_lemas_acs_pres12_nocharges.csv' CSV HEADER;

	-- Code charges
	scp nibrs_charges_o1.sql offenders* roesler@corn.stanford.edu:/farmshare/user_data/roesler/Mugshots/NIBRS/
	\i nibrs_charges_o1.sql
	-- code arrest charges
	\i offenders_arrest_charge1.sql
	\i offenders_arrest_charge2.sql
	\i offenders_arrest_charge3.sql
	
	-- code offense charges
	\i offenders_offense_charge1.sql
	\i offenders_offense_charge2.sql
	
	\copy (SELECT * FROM nibrs_offenders_arrestees_13_lemas_acs_pres12) To 'nibrs_offenders_arrestees_13_lemas_acs_pres12.csv' With CSV HEADER QUOTE '"'
	
	tar -zcf nibrs_offenders_arrestees_13_lemas_acs_pres12.csv.tar.gz nibrs_offenders_arrestees_13_lemas_acs_pres12.csv
	scp roesler@corn.stanford.edu:/farmshare/user_data/roesler/Mugshots/NIBRS/nibrs_offenders_arrestees_13_lemas_acs_pres12.csv.tar.gz nibrs_offenders_arrestees_13_lemas_acs_pres12.csv.tar.gz
	tar -zxf nibrs_offenders_arrestees_13_lemas_acs_pres12.csv.tar.gz nibrs_offenders_arrestees_13_lemas_acs_pres12.csv

-- To Clean NIBRS 2013 Offenders-Arrestees file
	subset.py to create nibrs_offenders_arrestees_13_lemas_acs_pres12_small.csv
	Setup_final.py (which uses Setup_ACS....py, clean_nibrs_offenders_arrestees.py, and code_offenses.py) to create nibrs_offenders_arrestees_13_lemas_acs_pres12_clean.csv
	subset.py to create nibrs_offenders_arrestees_13_lemas_acs_pres12_cs224.csv

-- Join NIBRS offenders file with other tables
	-- join with ori-level lemas data
	\copy (SELECT * FROM nibrs_offenders_13m_zip LEFT OUTER JOIN lemas_13 ON nibrs_offenders_13m_zip.ori = lemas_13.ori9) To 'nibrs_offenders_13m_lemas_zip.csv' With CSV HEADER QUOTE '"'
	-- create nibrs_arrests_13m_lemas_zip table in PGAdmin
	\copy nibrs_offenders_13m_lemas_zip FROM 'nibrs_offenders_13m_lemas_zip.csv' CSV HEADER;
	
	-- join with zipcode-level ACS data
	\copy (SELECT * FROM nibrs_offenders_13m_lemas_zip LEFT OUTER JOIN acs_zipcodes_13 ON nibrs_offenders_13m_lemas_zip.zipcode = acs_zipcodes_13.acs_zipcode) To 'nibrs_offenders_13m_lemas_zip_acs.csv' With CSV HEADER QUOTE '"'
	
	-- create nibrs_offenders_13m_lemas_zip_acs table in PGAdmin
	\copy nibrs_offenders_13m_lemas_zip_acs FROM 'nibrs_offenders_13m_lemas_zip_acs.csv' CSV HEADER;

	\copy (SELECT * FROM nibrs_offenders_13m_lemas_zip_acs LEFT OUTER JOIN pres12_counties_county_no ON cast(nibrs_offenders_13m_lemas_zip_acs.fips_county1_no as character varying) = pres12_counties_county_no.pres12_county_no) To 'nibrs_offenders_13m_lemas_zip_acs_pres12.csv' With CSV HEADER QUOTE '"'

	-- create nibrs_offenders_13m_lemas_zip_acs_pres12 in PGAdmin
	\copy nibrs_offenders_13m_lemas_zip_acs_pres12 FROM 'nibrs_offenders_13m_lemas_zip_acs_pres12.csv' CSV HEADER;

	tar -zcf nibrs_offenders_13m_lemas_zip_acs_pres12.csv.tar.gz nibrs_offenders_13m_lemas_zip_acs_pres12.csv
	scp roesler@corn.stanford.edu:/farmshare/user_data/roesler/Mugshots/NIBRS/nibrs_offenders_13m_lemas_zip_acs_pres12.csv.tar.gz nibrs_offenders_13m_lemas_zip_acs_pres12.csv.tar.gz
	tar -zxf nibrs_offenders_13m_lemas_zip_acs_pres12.csv.tar.gz nibrs_offenders_13m_lemas_zip_acs_pres12.csv

-- Group offenders file by zipcode to merge with arrests file
	-- create view with nibrs_offenders_13m_zip_view.sql
 	\copy (SELECT * FROM nibrs_offenders_13m_zip_view) To 'nibrs_offenders_13m_zipcodes.csv' With CSV HEADER QUOTE '"'
	
	-- create nibrs_offenders_13m_zipcodes in PGAdmin
	\copy nibrs_offenders_13m_zipcodes FROM 'nibrs_offenders_13m_zipcodes.csv' CSV HEADER QUOTE '"';

-- Group offenders file by county_no to merge with mugshots.com file
	-- create view with nibrs_offenders_13m_counties_view.sql
 	\copy (SELECT * FROM nibrs_offenders_13m_counties_view) To 'nibrs_offenders_13m_counties.csv' With CSV HEADER QUOTE '"'

 	-- create nibrs_offenders_13m_counties in PGAdmin
 	\copy nibrs_offenders_13m_counties FROM 'nibrs_offenders_13m_counties.csv' CSV HEADER QUOTE '"';

-- Join NIBRS arrests file with other tables
	-- join to zipcode-level crosswalk to get zipcode
	\copy (SELECT * FROM nibrs_arrests_13m LEFT OUTER JOIN cwzip_view ON nibrs_arrests_13m.ori = cwzip_view.ori9) To 'nibrs_arrests_13m_zip.csv' With CSV HEADER QUOTE '"'

	-- create nibrs_arrests_13m_zip table in PGAdmin
	\copy nibrs_arrests_13m_zip FROM 'nibrs_arrests_13m_zip.csv' CSV HEADER;

	-- join with ori-level lemas data
	\copy (SELECT * FROM nibrs_arrests_13m_zip LEFT OUTER JOIN lemas_13 ON nibrs_arrests_13m_zip.ori = lemas_13.ori9) To 'nibrs_arrests_13m_lemas_zip.csv' With CSV HEADER QUOTE '"'
	
	-- create nibrs_arrests_13m_lemas_zip table in PGAdmin
	\copy nibrs_arrests_13m_lemas_zip FROM 'nibrs_arrests_13m_lemas_zip.csv' CSV HEADER;
	
	-- join with zipcode-level ACS data
	\copy (SELECT * FROM nibrs_arrests_13m_lemas_zip LEFT OUTER JOIN acs_zipcodes_13 ON nibrs_arrests_13m_lemas_zip.zipcode = acs_zipcodes_13.acs_zipcode) To 'nibrs_arrests_13m_lemas_zip_acs.csv' With CSV HEADER QUOTE '"'
	
	-- create nibrs_arrests_13m_lemas_zip_acs table in PGAdmin
	\copy nibrs_arrests_13m_lemas_zip_acs FROM 'nibrs_arrests_13m_lemas_zip_acs.csv' CSV HEADER;

	-- join with zipcode-level offender data
	\copy (SELECT * FROM nibrs_arrests_13m_lemas_zip_acs LEFT OUTER JOIN nibrs_offenders_13m_zipcodes ON nibrs_arrests_13m_lemas_zip_acs.zipcode = nibrs_offenders_13m_zipcodes.offenders_zipcode) To 'nibrs_arrests_13m_la_off.csv' With CSV HEADER QUOTE '"'
	
	-- create nibrs_arrests_13m_la_off in PGAdmin
	\copy nibrs_arrests_13m_la_off FROM 'nibrs_arrests_13m_la_off.csv' CSV HEADER;

	-- add county_no to voting (run pres12_counties_county_no.sql)
	-- create pres12_counties_county_no in PGAdmin

	\copy pres12_counties_county_no FROM 'pres12_counties_county_no.csv' CSV HEADER;

	\copy (SELECT * FROM nibrs_arrests_13m_la_off LEFT OUTER JOIN pres12_counties_county_no ON cast(nibrs_arrests_13m_la_off.fips_county1_no as character varying) = pres12_counties_county_no.pres12_county_no) To 'nibrs_arrests_13m_la_off_pres12.csv' With CSV HEADER QUOTE '"'

	tar -zcf nibrs_arrests_13m_la_off_pres12.csv.tar.gz nibrs_arrests_13m_la_off_pres12.csv
	scp roesler@corn.stanford.edu:/farmshare/user_data/roesler/Mugshots/NIBRS/nibrs_arrests_13m_la_off_pres12.csv.tar.gz nibrs_arrests_13m_la_off_pres12.csv.tar.gz
	tar -zxf nibrs_arrests_13m_la_off_pres12.csv.tar.gz nibrs_arrests_13m_la_off_pres12.csv

-- Make county-level NIBRS arrests and offenders datasets
	\i nibrs_arrests_13m_counties_view.sql - to make view of arrests file grouped by county
	\copy (SELECT * FROM nibrs_arrests_13m_counties_view) To 'nibrs_arrests_13m_counties.csv' With CSV HEADER QUOTE '"'
	scp roesler@corn.stanford.edu:/farmshare/user_data/roesler/Mugshots/NIBRS/nibrs_arrests_13m_counties.csv nibrs_arrests_13m_counties.csv

	-- create nibrs_arrests_13m_counties in PGAdmin
	\copy nibrs_arrests_13m_counties FROM 'nibrs_arrests_13m_counties.csv' CSV HEADER;

-- Make county-level ACS dataset with NIBRS data
	\copy (SELECT * FROM lemas_13 LEFT OUTER JOIN cw_ori_county_view ON lemas_13.ori9 = cw_ori_county_view.ori9) To 'lemas_13_county.csv' With CSV HEADER QUOTE '"';

	-- create lemas_13_county in PGAdmin
	\copy lemas_13_county FROM 'lemas_13_county.csv' CSV HEADER;

	-- group lemas_13_county by county using lemas_13_counties.sql
	-- create lemas_13_counties in PGAdmin
	\copy lemas_13_counties FROM 'lemas_13_counties.csv' CSV HEADER;

	\copy (SELECT * FROM acs_counties_13_region_pres12 LEFT OUTER JOIN lemas_13_counties ON acs_counties_13_region_pres12.acs_county_no = lemas_13_counties.lemas_county_no) To 'acs_counties_13_rp_lemas13.csv' With CSV HEADER QUOTE '"';

	-- create acs_counties_13_rp_lemas13 in PGAdmin
	\copy acs_counties_13_rp_lemas13 FROM 'acs_counties_13_rp_lemas13.csv' CSV HEADER;

	\copy (SELECT * FROM acs_counties_13_rp_lemas13 LEFT JOIN nibrs_arrests_13m_counties ON acs_counties_13_rp_lemas13.acs_county_no = cast(nibrs_arrests_13m_counties.arrests_county_no as character varying)) To 'acs_counties_13_rpl_nibrs_arrests_13m.csv' With CSV HEADER QUOTE '"';

	-- make acs_counties_13_rpl_nibrs_arrests_13m in PGAdmin
	\copy acs_counties_13_rpl_nibrs_arrests_13m FROM 'acs_counties_13_rpl_nibrs_arrests_13m.csv' CSV HEADER;

	\copy (SELECT * FROM acs_counties_13_rpl_nibrs_arrests_13m LEFT OUTER JOIN nibrs_offenders_13m_counties ON cast(nibrs_offenders_13m_counties.offenders_county_no as character varying) = acs_counties_13_rpl_nibrs_arrests_13m.acs_county_no) To 'acs_counties_13_rpl_nao.csv' With CSV HEADER QUOTE '"';

	-- make acs_counties_13_rpl_nao in PGAdmin
	\copy acs_counties_13_rpl_nao FROM 'acs_counties_13_rpl_nao.csv' CSV HEADER;

-- Mugshots.com
	-- select only men in 2014-15
	\copy (SELECT * FROM mugshots_july2015 as mt WHERE mt.gender = 'male' and (mt.date_year = 2014 or mt.date_year = 2015) and mt.county_no IS NOT NULL) To 'mugshots_july_male_1415.csv' With CSV HEADER QUOTE '"';

	-- create mugshots_july_male_1415 in PGAdmin
	\copy mugshots_july_male_1415 FROM 'mugshots_july_male_1415.csv' CSV HEADER;

	-- upload charges 
	\copy mugshots_charges_july2015 FROM 'Mugshots Datasets/Mugshots_July10_Clean/charges/july10_charges.csv' CSV HEADER;

	-- code charges
	scp code_mugshots_charges_july2015* roesler@corn.stanford.edu:/farmshare/user_data/roesler/Mugshots/
	-- run code_mugshots_charges_july2015_1.sql in PGAdmin
	\i code_mugshots_charges_july2015_2.sql
	\i code_mugshots_charges_july2015_3.sql
	\i code_mugshots_charges_july2015_4.sql
	\i code_mugshots_charges_july2015_5.sql
	
	-- create mugshots_charges_july2015_grouped_view
	\copy (SELECT * FROM mugshots_charges_july2015_grouped_view) To 'mugshots_charges_july2015_grouped.csv' With CSV HEADER QUOTE '"';
	
	-- create mugshots_charges_july2015_grouped in PGAdmin
	\copy mugshots_charges_july2015_grouped FROM 'mugshots_charges_july2015_grouped.csv' CSV HEADER;

	\copy (SELECT * FROM mugshots_july_male_1415 LEFT OUTER JOIN mugshots_charges_july2015_grouped ON mugshots_july_male_1415.arrest_id = mugshots_charges_july2015_grouped.charges_arrest_id) To 'mugshots_july_male_1415_ac.csv' With CSV HEADER QUOTE '"';

	-- create mugshots_july_male_1415_ac in PGAdmin
	\copy mugshots_july_male_1415_ac FROM 'mugshots_july_male_1415_ac.csv' CSV HEADER;

	-- Join mugshots.com data with acs_counties_13_rpl_nao
	\copy (SELECT * FROM mugshots_july_male_1415_ac LEFT OUTER JOIN acs_counties_13_rpl_nao ON mugshots_july_male_1415_ac.county_no = acs_counties_13_rpl_nao.acs_county_no) To 'mugshots_july_male_1415_ac_arplnao.csv' With CSV HEADER QUOTE '"';

	-- create mugshots_july_male_1415_ac_arplnao in PGAdmin
	\copy mugshots_july_male_1415_ac_arplnao FROM 'mugshots_july_male_1415_ac_arplnao.csv' CSV HEADER;
	scp roesler@corn.stanford.edu:/farmshare/user_data/roesler/Mugshots/mugshots_july_male_1415_ac_arplnao.csv mugshots_july_male_1415_ac_arplnao.csv
