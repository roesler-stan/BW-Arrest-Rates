--mugshots2015m_lea
SELECT * FROM
(mugshots2015_male
LEFT OUTER JOIN acs_gov_lemas_emp_small
ON mugshots2015_male.county_no = acs_gov_lemas_emp_small.races_county_no)