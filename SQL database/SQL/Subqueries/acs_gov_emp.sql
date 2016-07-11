-- acs_gov_emp
SELECT *
FROM (acs_gov
LEFT OUTER JOIN acs_county_emp_0913
ON acs_gov.races_county_no = acs_county_emp_0913.emp_county_no);