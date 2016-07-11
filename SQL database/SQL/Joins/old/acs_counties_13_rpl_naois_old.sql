--acs_counties_13_rpl_naois
--FIX THIS - it seems to be a full outer join

SELECT * FROM
(acs_counties_13_rpl_naoi
LEFT OUTER JOIN 
(SELECT crosswalk.state_name state,
crosswalk.county_no cw_county_no2
FROM crosswalk) cw
ON acs_counties_13_rpl_naoi.acs_county_no = cw.cw_county_no2)