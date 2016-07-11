--acs_counties_13_rpl_no
SELECT * FROM acs_counties_13_rp_lemas
LEFT OUTER JOIN nibrs_counties
ON acs_counties_13_rp_lemas.acs_county_no = nibrs_counties.nibrs_county_no