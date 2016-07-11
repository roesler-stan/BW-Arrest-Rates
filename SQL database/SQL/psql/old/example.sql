--nibrs_offenders_arrests_12m

--Figure out how to get to multi-line mode
-- \i filename.sql once in psql
-- psql... -f filename.sql


psql -f nibrs.sql -o nibrs_offenders_12mco_nd.csv


\i nibrs.sql \o nibrs_offenders_12mco_nd.csv

psql --host=mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com --port=5432 --username=roesler --password --dbname=Mugshots
-- enter password: break_free15

--../Data/SQL Output/
\copy (SELECT * FROM nibrs_offenders_12m_county FULL OUTER JOIN nibrs_arrests_12m_county_nd ON nibrs_offenders_12m_county.ori = nibrs_arrests_12m_county_nd.ori AND) To 'nibrs_offenders_arrests_12m.csv' With CSV HEADER QUOTE '"'

-

--DISCONNECT CURRENT
--\q (or ctrl-alt-d)
