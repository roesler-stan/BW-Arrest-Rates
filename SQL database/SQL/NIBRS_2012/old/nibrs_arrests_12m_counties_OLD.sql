--nibrs_arrests_12m_counties

SELECT * FROM
((SELECT
	ct.county_no nibrs_county_no,
	count(ct.race) nibrs_arrests_race_known

	FROM nibrs_arrests_12m_county as ct
	GROUP BY ct.county_no) all_arrestees

LEFT OUTER JOIN
(SELECT
	w_ct.county_no w_nibrs_county_no,
	count(w_ct.race) nibrs_w_arrests

	FROM nibrs_arrests_12m_county as w_ct
	WHERE w_ct.race ~* 'W'
	GROUP BY w_ct.county_no) w_arrestees
ON all_arrestees.nibrs_county_no = w_arrestees.w_nibrs_county_no) all_and_white

LEFT OUTER JOIN
(SELECT
	b_ct.county_no b_nibrs_county_no,
	count(b_ct.race) nibrs_b_arrests

	FROM nibrs_arrests_12m_county as b_ct
	WHERE b_ct.race ~* 'B'
	GROUP BY b_ct.county_no) b_arrestees
ON all_and_white.nibrs_county_no = b_arrestees.b_nibrs_county_no