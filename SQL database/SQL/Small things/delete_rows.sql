DELETE FROM mugshots_may2015_ac_male_1415
--WHERE nibrs_ooc_county.gender !~* 'M'
--WHERE acs_counties_13_rpl_na_ids.county_no IS NULL
WHERE mugshots_may2015_ac_male_1415.county_no IS NULL OR (mugshots_may2015_ac_male_1415.date_year != 2014 AND mugshots_may2015_ac_male_1415.date_year != 2015);