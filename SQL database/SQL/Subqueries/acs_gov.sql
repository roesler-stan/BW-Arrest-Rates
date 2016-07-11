--acs_gov
SELECT * FROM
((acs_counties
LEFT OUTER JOIN (SELECT crosswalk.county_no crosswalk_county_no,
max(crosswalk.state) state
FROM crosswalk
GROUP BY crosswalk.county_no) crosswalk_counties
ON acs_counties.races_county_no = crosswalk_counties.crosswalk_county_no) acs_state
LEFT OUTER JOIN
(SELECT governors_2015.state gov_state,
governors_2015.party gov_party
FROM governors_2015) gov_table
ON acs_state.state = gov_table.gov_state);