--TABLE.csv
SELECT * FROM
(TABLE
LEFT OUTER JOIN lemas_counties
ON TABLE.county_no = lemas_counties.races_county_no);