--mugshots2015_lea_200
SELECT * FROM
(mugshots2015_arrests_charges
LEFT OUTER JOIN acs_gov_lemas_emp
ON mugshots2015_arrests_charges.county_no = acs_gov_lemas_emp.races_county_no)