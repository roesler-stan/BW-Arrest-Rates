--acs_zipcodes_13_region_pres12

SELECT * FROM acs_zipcodes_13
LEFT OUTER JOIN
(SELECT
ct.zipcode cw_zipcode,
max(ct.state) state,
max(ct.county) county,
max(ct.county_no) county_no,
max(ct.ori7) cw_ori7,
max(ct.ori9) cw_ori9,
avg(total_votes) total_votes,
avg(rep_votes) rep_votes,
avg(dem_votes) dem_votes,
avg(reps_percent_total) reps_percent_total,
avg(dems_percent_total) dems_percent_total,
avg(third_percent_total) third_percent_total,
avg(reps_percent_majority) reps_percent_majority,
avg(dems_percent_majority) dems_percent_majority,
max(plurality_party) plurality_party
FROM crosswalk_region_pres12 as ct
GROUP BY ct.zipcode) cw_table
ON acs_zipcodes_13.acs_zipcode = cw_table.cw_zipcode