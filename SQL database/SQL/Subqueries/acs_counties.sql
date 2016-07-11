-- acs_counties
-- left outer joins to only have one main county_no and b/c only need counties where can control for race
-- The order makes sense, since don't need later tables if earlier vars are missing
SELECT * FROM
(((SELECT * FROM (SELECT acs_races_0913.county_no races_county_no,
	acs_races_0913.total total_residents,
	acs_races_0913.white w_residents,
	acs_races_0913.black b_residents,
	acs_races_0913.indian i_residents,
	acs_races_0913.asian a_residents,
	acs_races_0913.hawaii h_residents,
	acs_races_0913.other o_residents,
	acs_races_0913.multiple m_residents,
	acs_races_0913.mult_inclother mi_resdients,
	acs_races_0913.mult_notother mn_residents
	FROM acs_races_0913) races_select
-- ACS income
LEFT OUTER JOIN (SELECT *
	FROM acs_inc_0913) acs_inc_select
	ON races_select.races_county_no = acs_inc_select.county_no) acs_basic
-- ACS county resident racial group income, 2009-2013
LEFT OUTER JOIN (SELECT acs_inc_black_0913.county_no binc_county_no,
	acs_inc_black_0913.total binc_total,
	acs_inc_black_0913.inc_under10 binc_under10,
	acs_inc_black_0913.inc_10to15 binc_10to15,
	acs_inc_black_0913.inc_15to20 binc_15to20,
	acs_inc_black_0913.inc_20to25 binc_20to25,
	acs_inc_black_0913.inc_25to30 binc_25to30,
	acs_inc_black_0913.inc_30to35 binc_30to35,
	acs_inc_black_0913.inc_35to40 binc_35to40,
	acs_inc_black_0913.inc_40to45 binc_40to45,
	acs_inc_black_0913.inc_45to50 binc_45to50,
	acs_inc_black_0913.inc_50to60 binc_50to60,
	acs_inc_black_0913.inc_60to75 binc_60to75,
	acs_inc_black_0913.inc_75to100 binc_75to100,
	acs_inc_black_0913.inc_100to125 binc_100to125,
	acs_inc_black_0913.inc_125to150 binc_125to150,
	acs_inc_black_0913.inc_150to200 binc_150to200,
	acs_inc_black_0913.inc_200more binc_200more
	FROM acs_inc_black_0913) black_inc
	ON acs_basic.races_county_no = black_inc.binc_county_no) acs_wblack
LEFT OUTER JOIN (SELECT acs_inc_white_0913.county_no winc_county_no,
	acs_inc_white_0913.total winc_total,
	acs_inc_white_0913.inc_under10 winc_under10,
	acs_inc_white_0913.inc_10to15 winc_10to15,
	acs_inc_white_0913.inc_15to20 winc_15to20,
	acs_inc_white_0913.inc_20to25 winc_20to25,
	acs_inc_white_0913.inc_25to30 winc_25to30,
	acs_inc_white_0913.inc_30to35 winc_30to35,
	acs_inc_white_0913.inc_35to40 winc_35to40,
	acs_inc_white_0913.inc_40to45 winc_40to45,
	acs_inc_white_0913.inc_45to50 winc_45to50,
	acs_inc_white_0913.inc_50to60 winc_50to60,
	acs_inc_white_0913.inc_60to75 winc_60to75,
	acs_inc_white_0913.inc_75to100 winc_75to100,
	acs_inc_white_0913.inc_100to125 winc_100to125,
	acs_inc_white_0913.inc_125to150 winc_125to150,
	acs_inc_white_0913.inc_150to200 winc_150to200,
	acs_inc_white_0913.inc_200more winc_200more
	FROM acs_inc_white_0913) white_inc
	ON acs_wblack.binc_county_no = white_inc.winc_county_no)