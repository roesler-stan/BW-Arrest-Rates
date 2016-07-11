--nibrs_ooc_county
--Adding county number and only keeping men
SELECT * FROM
(nibrs_oo_charges 
WHERE nibrs_oo_charges.gender ~* 'M'
LEFT OUTER JOIN
(SELECT crosswalk.ori9 ori9,
crosswalk.county_no county_no
FROM crosswalk) crosswalk_table
ON nibrs_oo_charges.ori = crosswalk_table.ori9)