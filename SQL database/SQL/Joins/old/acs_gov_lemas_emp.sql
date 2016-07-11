--lemas_acs_gov_emp
SELECT * FROM
((acs_gov
LEFT OUTER JOIN lemas_counties
ON acs_gov.races_county_no = lemas_counties.lemas_county_no) acs_table
LEFT OUTER JOIN acs_county_emp_0913
ON acs_table.races_county_no = acs_county_emp_0913.emp_county_no)