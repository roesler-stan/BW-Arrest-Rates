--acs_counties_13_rpl_naois

SELECT * FROM acs_counties_13_rpl_naoi
LEFT OUTER JOIN
(SELECT max(crosswalk.state_name) state,
crosswalk.county_no cw_county_no2
FROM crosswalk
GROUP BY crosswalk.county_no) cw_table
ON acs_counties_13_rpl_naoi.acs_county_no = cw_table.cw_county_no2