--nibrs_offenders_12mco_nd

psql --host=mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com --port=5432 --username=roesler --password --dbname=Mugshots

\copy (SELECT ot.record_type, ot.state_no, ot.state, ot.ori, ot.incident, ot.incident_date, ot.seqno, ot.age, ot.gender, ot.race, ot.number_offenses, ot.internal_offender_id, ot.offender_ori9, ot.offender_county_no, ot.offenses_incident, ot.offender_ori9, ot.ucr_offense, ot.attempted FROM nibrs_offenders_12mc_offense as ot) To 'nibrs_offenders_12mco_nd.csv' With CSV HEADER QUOTE '"'

\copy nibrs_offenders_12mco_nd FROM 'nibrs_offenders_12mco_nd.csv' CSV HEADER;

\copy (SELECT * FROM offenders_view FULL OUTER JOIN arrests_view ON offenders_view.offender_ori = arrests_view.arrest_ori AND offenders_view.offender_incident = arrests_view.arrest_incident) To 'nibrs_offenders_arrests_12m.csv' With CSV HEADER QUOTE '"'

--create table in PGAdmin

\copy nibrs_offenders_arrests_12m FROM 'nibrs_offenders_arrests_12m.csv' CSV HEADER;

-- make master ori in PGAdmin

-- create index on ori

-- join crosswalk zipcode
\copy (SELECT * FROM nibrs_offenders_arrests_12m LEFT OUTER JOIN cwzip_view ON nibrs_offenders_arrests_12m.ori = cwzip_view.ori9) To 'nibrs_offenders_arrests_12m_zip.csv' With CSV HEADER QUOTE '"'

\copy nibrs_offenders_arrests_12m_zip FROM 'nibrs_offenders_arrests_12m_zip.csv' CSV HEADER;


-- join with zipcode-level lemas data
\copy (SELECT * FROM nibrs_offenders_arrests_12m_zip LEFT OUTER JOIN lemas_13_zipcodes ON nibrs_offenders_arrests_12m_zip.zipcode = lemas_13_zipcodes.lemas_zipcode) To 'nibrs_offenders_arrests_12mz_lemas.csv' With CSV HEADER QUOTE '"'

-- create nibrs_offenders_arrests_12mz_lemas

\copy nibrs_offenders_arrests_12mz_lemas FROM 'nibrs_offenders_arrests_12mz_lemas.csv' CSV HEADER;

-- join with zipcode-level ACS data
\copy (SELECT * FROM nibrs_offenders_arrests_12mz_lemas LEFT OUTER JOIN acs_zipcodes_13_region_pres12 ON nibrs_offenders_arrests_12mz_lemas.zipcode = acs_zipcodes_13_region_pres12.acs_zipcode) To 'nibrs_offenders_arrests_12mzl_acs.csv' With CSV HEADER QUOTE '"'

tar -zcf nibrs_offenders_arrests_12mzl_acs.tar.gz nibrs_offenders_arrests_12mzl_acs.csv

-- Calculate zipcode-level offender data

scp roesler@corn.stanford.edu:/farmshare/user_data/roesler/Mugshots/SQL/nibrs_offenders_arrests_12mzl_acs.tar.gz ../Data/SQL\ Output/