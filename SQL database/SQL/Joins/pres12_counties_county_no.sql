-- pres12_counties_county_no
SELECT * FROM pres12_counties
LEFT OUTER JOIN
	(SELECT crosswalk_12.state_name cw_state, crosswalk_12.county cw_county,
	max(crosswalk_12.county_no) pres12_county_no
	FROM crosswalk_12
	GROUP BY crosswalk_12.state_name, crosswalk_12.county) ct
ON ct.cw_state = pres12_counties.pres12_state AND ct.cw_county = pres12_counties.pres12_county