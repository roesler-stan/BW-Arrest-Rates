--acs_counties_13_rpl_noa
SELECT * FROM acs_counties_13_rpl_no
LEFT OUTER JOIN (
SELECT na.nibrs_arrests_county_no,
na.nibrs_arrests_race_known,
na.nibrs_w_arrests,
na.nibrs_b_arrests
FROM nibrs_arrests_counties as na) arrests
ON acs_counties_13_rpl_no.acs_county_no = arrests.nibrs_arrests_county_no