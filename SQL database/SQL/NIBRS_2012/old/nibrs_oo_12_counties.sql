--nibrs_oo_12_counties
--offenders data
SELECT * FROM
((SELECT
	ct.county_no nibrs_county_no,
	avg(ct.age) nibrs_age,
	-- Total number of offenders
	count(offender_id) nibrs_offender_count,
	-- Total number of offenses
	sum(ct.offense_count) nibrs_offense_count_sum,
	-- Average number of offenses per offender, as counted from known offensees
	avg(ct.offense_count) nibrs_offense_count_avg,
	-- Average number of offenses per offender, as provided by data
	avg(ct.number_offenses) nibrs_number_offenses_avg,
	-- Total offenders who had at least one of the given charge
	sum(ct.burglary) nibrs_burglary, sum(ct.forgery) nibrs_forgery, sum(ct.drugs_narcotics) nibrs_drugs_narcotics,
	sum(ct.embezzlement) nibrs_embezzlement, sum(ct.murder) nibrs_murder,
	sum(ct.auto_theft) nibrs_auto_theft, sum(ct.robbery) nibrs_robbery, sum(ct.forcible_rape) nibrs_forcible_rape, sum(ct.stolen_property) nibrs_stolen_property,
	sum(ct.assault_general) nibrs_assault_general, sum(ct.drugs_general) nibrs_drugs_general, sum(ct.fraud_general) nibrs_fraud_general,
	sum(ct.homicide_general) nibrs_homicide_general, sum(ct.theft_general) nibrs_theft_general
	FROM nibrs_ooc_county as ct
	WHERE ct.race IS NOT NULL
	GROUP BY ct.county_no) all_offenders
LEFT OUTER JOIN
(SELECT
	w_ct.county_no w_nibrs_county_no,
	avg(w_ct.age) w_nibrs_age,
	-- Total number of offenders
	count(offender_id) w_nibrs_offender_count,
	-- Total number of offenses
	sum(w_ct.offense_count) w_nibrs_offense_count_sum,
	-- Average number of offenses per offender, as counted from known offensees
	avg(w_ct.offense_count) w_nibrs_offense_count_avg,
	-- Average number of offenses per offender, as provided by data
	avg(w_ct.number_offenses) w_nibrs_number_offenses_avg,
	-- Total offenders who had at least one of the given charge
	sum(w_ct.burglary) w_nibrs_burglary, sum(w_ct.forgery) w_nibrs_forgery, sum(w_ct.drugs_narcotics) w_nibrs_drugs_narcotics,
	sum(w_ct.embezzlement) w_nibrs_embezzlement, sum(w_ct.murder) w_nibrs_murder,
	sum(w_ct.auto_theft) w_nibrs_auto_theft, sum(w_ct.robbery) w_nibrs_robbery, sum(w_ct.forcible_rape) w_nibrs_forcible_rape, sum(w_ct.stolen_property) w_nibrs_stolen_property,
	sum(w_ct.assault_general) w_nibrs_assault_general, sum(w_ct.drugs_general) w_nibrs_drugs_general, sum(w_ct.fraud_general) w_nibrs_fraud_general,
	sum(w_ct.homicide_general) w_nibrs_homicide_general, sum(w_ct.theft_general) w_nibrs_theft_general
	FROM nibrs_ooc_county as w_ct
	WHERE w_ct.race ~* 'W'
	GROUP BY w_ct.county_no) w_offenders
ON all_offenders.nibrs_county_no = w_offenders.w_nibrs_county_no) all_and_white
LEFT OUTER JOIN
(SELECT
	b_ct.county_no b_nibrs_county_no,
	avg(b_ct.age) b_nibrs_age,
	-- Total number of offenders
	count(offender_id) b_nibrs_offender_count,
	-- Total number of offenses
	sum(b_ct.offense_count) b_nibrs_offense_count_sum,
	-- Average number of offenses per offender, as counted from known offensees
	avg(b_ct.offense_count) b_nibrs_offense_count_avg,
	-- Average number of offenses per offender, as provided by data
	avg(b_ct.number_offenses) b_nibrs_number_offenses_avg,
	-- Total offenders who had at least one of the given charge
	sum(b_ct.burglary) b_nibrs_burglary, sum(b_ct.forgery) b_nibrs_forgery, sum(b_ct.drugs_narcotics) b_nibrs_drugs_narcotics,
	sum(b_ct.embezzlement) b_nibrs_embezzlement, sum(b_ct.murder) b_nibrs_murder,
	sum(b_ct.auto_theft) b_nibrs_auto_theft, sum(b_ct.robbery) b_nibrs_robbery, sum(b_ct.forcible_rape) b_nibrs_forcible_rape, sum(b_ct.stolen_property) b_nibrs_stolen_property,
	sum(b_ct.assault_general) b_nibrs_assault_general, sum(b_ct.drugs_general) b_nibrs_drugs_general, sum(b_ct.fraud_general) b_nibrs_fraud_general,
	sum(b_ct.homicide_general) b_nibrs_homicide_general, sum(b_ct.theft_general) b_nibrs_theft_general
	FROM nibrs_ooc_county as b_ct
	WHERE b_ct.race ~* 'B'
	GROUP BY b_ct.county_no) b_offenders
ON all_and_white.nibrs_county_no = b_offenders.b_nibrs_county_no