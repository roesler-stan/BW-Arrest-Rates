﻿--acs_counties_13_rp_lemas
SELECT * FROM acs_counties_13_region_pres12
LEFT OUTER JOIN lemas_13_counties
ON acs_counties_13_region_pres12.acs_county_no = lemas_13_counties.lemas_county_no