psql --host=mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com --port=5432 --username=roesler --password --dbname=Mugshots

-- join with ori-level lemas data
\copy (SELECT * FROM nibrs_arrests_12m_county_nd LEFT OUTER JOIN lemas_13 ON nibrs_arrests_12m_county_nd.ori9 = lemas_13.agencyid) To 'nibrs_arrests_12m_lemas13.csv' With CSV HEADER QUOTE '"'

-- make nibrs-lemas table in PGAdmin

\copy nibrs_arrests_12m_lemas13 FROM 'nibrs_arrests_12m_lemas13.csv' CSV HEADER;

\copy (SELECT * FROM nibrs_arrests_12m_lemas13 LEFT OUTER JOIN acs_zipcodes_13_region_pres12 ON nibrs_arrests_12m_lemas13.zipcode = acs_zipcodes_13_region_pres12.acs_zipcode) To 'nibrs_arrests_12ml_acs_pres.csv' With CSV HEADER QUOTE '"'

-- make nibrs_arrests_12ml_acs_pres table in PGAdmin

\copy nibrs_arrests_12ml_acs_pres FROM 'nibrs_arrests_12ml_acs_pres.csv' CSV HEADER;