--TABLE.csv
SELECT * FROM
(TABLE
LEFT OUTER JOIN ucr_counties
ON TABLE.county_no = ucr_counties.ucr_county_no);