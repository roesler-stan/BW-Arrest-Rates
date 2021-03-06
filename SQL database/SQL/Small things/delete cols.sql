﻿-- delete columns from acs_counties_13_rpl_nai

ALTER TABLE acs_counties_13_rpl_nai
DROP COLUMN b_inc_10to15,
DROP COLUMN b_inc_15to20,
DROP COLUMN b_inc_20to25,
DROP COLUMN b_inc_25to30,
DROP COLUMN b_inc_30to35,
DROP COLUMN b_inc_35to40,
DROP COLUMN b_inc_40to45,
DROP COLUMN b_inc_50to60,
DROP COLUMN b_inc_60to75,
DROP COLUMN b_inc_75to100,
DROP COLUMN b_inc_100to125,
DROP COLUMN b_inc_125to150,
DROP COLUMN b_inc_150to200,
DROP COLUMN b_inc_200more,
DROP COLUMN w_inc_10to15,
DROP COLUMN w_inc_15to20,
DROP COLUMN w_inc_20to25,
DROP COLUMN w_inc_25to30,
DROP COLUMN w_inc_30to35,
DROP COLUMN w_inc_35to40,
DROP COLUMN w_inc_40to45,
DROP COLUMN w_inc_50to60,
DROP COLUMN w_inc_60to75,
DROP COLUMN w_inc_75to100,
DROP COLUMN w_inc_100to125,
DROP COLUMN w_inc_125to150,
DROP COLUMN w_inc_150to200,
DROP COLUMN w_inc_200more,
DROP COLUMN cw_county_no,
DROP COLUMN lemas_county_no,
DROP COLUMN county_no15,
DROP COLUMN bw_residents_pdiff,
DROP COLUMN bw_residents_ratio,
DROP COLUMN bw_residents_percent,
DROP COLUMN prop_residents_wnotb;
