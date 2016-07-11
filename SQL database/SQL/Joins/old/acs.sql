--TABLE.csv
SELECT * FROM
(TABLE
LEFT OUTER JOIN acs_counties
ON TABLE.county_no = acs_counties.races_county_no);