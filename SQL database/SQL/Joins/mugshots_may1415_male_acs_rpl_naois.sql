﻿-- mugshots_may1415_male_acs_rpl_naois
SELECT * FROM mugshots_may2015_ac_male_1415
LEFT OUTER JOIN acs_counties_13_rpl_naois
ON mugshots_may2015_ac_male_1415.county_no = acs_counties_13_rpl_naois.acs_county_no