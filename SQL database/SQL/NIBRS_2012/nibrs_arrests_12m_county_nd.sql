--nibrs_arrests_12m_county_nd
--Adding county number
SELECT * FROM
(nibrs_arrests_12_male
LEFT OUTER JOIN
(SELECT crosswalk.ori9 ori9,
crosswalk.county_no county_no
FROM crosswalk) crosswalk_table
ON nibrs_arrests_12_male.ori = crosswalk_table.ori9);