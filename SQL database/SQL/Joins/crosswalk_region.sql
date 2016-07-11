--crosswalk_region
SELECT * FROM crosswalk
LEFT OUTER JOIN (SELECT
sr.state_number sr_state_number,
sr.region region
FROM state_regions as sr) sr_table
ON crosswalk.state_no = sr_table.sr_state_number