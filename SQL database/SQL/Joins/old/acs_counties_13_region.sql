--acs_counties_13_region
SELECT * FROM acs_counties_13
LEFT OUTER JOIN (SELECT
ct.county_no cw_county_no,
ct.region region
FROM crosswalk_region as ct) cw_table
ON acs_counties_13.acs_county_no = cw_table.cw_county_no