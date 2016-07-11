--TABLE.csv
SELECT * FROM
(TABLE
LEFT OUTER JOIN acs_gov_emp
ON TABLE.county_no = acs_gov_emp.races_county_no);