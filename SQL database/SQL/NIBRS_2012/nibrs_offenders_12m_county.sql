--nibrs_offenders_12m_county
--Adding county number

SELECT * FROM
(nibrs_offenders_12m
LEFT OUTER JOIN
(SELECT crosswalk.ori9 ori9,
crosswalk.county_no county_no
FROM crosswalk) crosswalk_table
ON nibrs_offenders_12m.ori = crosswalk_table.ori9);