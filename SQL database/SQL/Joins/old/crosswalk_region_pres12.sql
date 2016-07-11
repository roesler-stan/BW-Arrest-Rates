--crosswalk_region_pres12
SELECT * FROM crosswalk_region
LEFT OUTER JOIN pres12_counties
ON crosswalk_region.state_name = pres12_counties.pres12_state AND crosswalk_region.county = pres12_counties.pres12_county