# Connect to AWS database via psql

psql --host=mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com --port=5432 --username=roesler --password --dbname=Mugshots

\copy (SELECT * FROM acs_counties_13 LEFT OUTER JOIN lemas_13_counties ON acs_counties_13.acs_county_no = lemas_13_counties.lemas_county_no) To 'acs_lemas.csv' With CSV

\copy (SELECT * FROM nibrs_arrests_12m_county_nd LEFT OUTER JOIN acs_counties_13_rpl_naois ON nibrs_arrests_12m_county_nd.county_no = acs_counties_13_rpl_naois.acs_county_no) To '../Data/SQL Output/nibrs_arrests_12mcnd_acs_rpl_naois.csv' With CSV

COPY...


-f filename

DISCONNECT CURRENT
\q (or ctrl-alt-d)
