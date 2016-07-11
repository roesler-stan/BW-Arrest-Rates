--TABLE.csv
SELECT * FROM
(TABLE
LEFT OUTER JOIN lemas_counties
ON TABLE.county_no = lemas_counties.lemas_county_no) lemas_table