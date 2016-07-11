--ucr0812_county_off_laige
SELECT * FROM (ucr0812_county_off_lai_gov
LEFT OUTER JOIN acs_county_emp_0913 ON ucr0812_county_off_lai_gov.county_no = acs_county_emp_0913.emp_county_no);