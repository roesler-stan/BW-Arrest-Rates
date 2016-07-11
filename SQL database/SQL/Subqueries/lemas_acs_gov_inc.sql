--lemas_acs_gov_inc
SELECT *
FROM ((lemas_counties
LEFT OUTER JOIN acs_gov
ON lemas_counties.lemas_county_no = acs_gov.races_county_no) lemas_state
LEFT OUTER JOIN acs_inc_0913
ON lemas_state.lemas_county_no = acs_inc_0913.county_no);