--acs_counties_13_region_pres12
--grouping by county b/c of crosswalk format
SELECT * FROM acs_counties_13
LEFT OUTER JOIN (SELECT
ct.county_no cw_county_no,
avg(ct.region) region,
avg(ct.total_votes) total_votes,
avg(ct.rep_votes) rep_votes,
avg(ct.dem_votes) dem_votes,
avg(ct.reps_percent_total) reps_percent_total,
avg(ct.dems_percent_total) dems_percent_total,
avg(ct.third_percent_total) third_percent_total,
avg(ct.other_percent_total) other_percent_total,
avg(ct.reps_percent_majority) reps_percent_majority,
avg(ct.dems_percent_majority) dems_percent_majority,
max(ct.plurality_party) plurality_party
FROM crosswalk_region_pres12 as ct
GROUP BY ct.county_no) cw_table
ON acs_counties_13.acs_county_no = cw_table.cw_county_no