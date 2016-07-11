--TABLE.csv
SELECT * FROM
(TABLE
LEFT OUTER JOIN acs_county_emp_0913
ON TABLE.county_no = acs_county_emp_0913.emp_county_no);