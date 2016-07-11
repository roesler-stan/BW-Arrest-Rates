--Figure out how to get to multi-line mode
--also make sure that -f filename.sql works

--psql --host=mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com --port=5432 --username=roesler --password --dbname=Mugshots
-- enter password: onevision_90

\copy (SELECT * FROM nibrs_arrests_12m_county_nd LEFT OUTER JOIN acs_counties_13_rpl_naois ON nibrs_arrests_12m_county_nd.county_no = acs_counties_13_rpl_naois.acs_county_no) To 'nibrs_arrests_12mcnd_acs_rpl_naois.csv' With CSV HEADER QUOTE '"'

--DISCONNECT CURRENT
--\q (or ctrl-alt-d)
