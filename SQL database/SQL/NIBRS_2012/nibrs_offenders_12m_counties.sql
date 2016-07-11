--nibrs_offenders_12m_counties

SELECT * FROM
((SELECT
	ct.offender_county_no offenders_county_no,
	avg(ct.age) offenders_age,
	count(ct.race) offenders_race_known,
	-- Total offenders who had at least one of the given charge
	sum(ct.burglary) offenders_burglary, sum(ct.forgery) offenders_forgery, sum(ct.drugs_narcotics) offenders_drugs_narcotics,
	sum(ct.embezzlement) offenders_embezzlement, sum(ct.murder) offenders_murder,
	sum(ct.auto_theft) offenders_auto_theft, sum(ct.robbery) offenders_robbery, sum(ct.forcible_rape) offenders_forcible_rape, sum(ct.stolen_property) offenders_stolen_property,
	sum(ct.assault_general) offenders_assault_general, sum(ct.drugs_general) offenders_drugs_general, sum(ct.fraud_general) offenders_fraud_general,
	sum(ct.homicide_general) offenders_homicide_general, sum(ct.theft_general) offenders_theft_general
	FROM nibrs_offenders_12mc_offense as ct
	GROUP BY ct.offender_county_no) all_offenders
LEFT OUTER JOIN
(SELECT
	w_ct.offender_county_no w_offenders_county_no,
	avg(w_ct.age) w_offenders_age,
	count(w_ct.race) w_offenders,
	-- Total offenders who had at least one of the given charge
	sum(w_ct.burglary) w_offenders_burglary, sum(w_ct.forgery) w_offenders_forgery, sum(w_ct.drugs_narcotics) w_offenders_drugs_narcotics,
	sum(w_ct.embezzlement) w_offenders_embezzlement, sum(w_ct.murder) w_offenders_murder,
	sum(w_ct.auto_theft) w_offenders_auto_theft, sum(w_ct.robbery) w_offenders_robbery, sum(w_ct.forcible_rape) w_offenders_forcible_rape, sum(w_ct.stolen_property) w_offenders_stolen_property,
	sum(w_ct.assault_general) w_offenders_assault_general, sum(w_ct.drugs_general) w_offenders_drugs_general, sum(w_ct.fraud_general) w_offenders_fraud_general,
	sum(w_ct.homicide_general) w_offenders_homicide_general, sum(w_ct.theft_general) w_offenders_theft_general
	FROM nibrs_offenders_12mc_offense as w_ct
	WHERE w_ct.race ~* 'W'
	GROUP BY w_ct.offender_county_no) w_offenders
ON all_offenders.offenders_county_no = w_offenders.w_offenders_county_no) all_and_white
LEFT OUTER JOIN
(SELECT
	b_ct.offender_county_no b_offenders_county_no,
	avg(b_ct.age) b_offenders_age,
	count(b_ct.race) b_offenders,
	-- Total offenders who had at least one of the given charge
	sum(b_ct.burglary) b_offenders_burglary, sum(b_ct.forgery) b_offenders_forgery, sum(b_ct.drugs_narcotics) b_offenders_drugs_narcotics,
	sum(b_ct.embezzlement) b_offenders_embezzlement, sum(b_ct.murder) b_offenders_murder,
	sum(b_ct.auto_theft) b_offenders_auto_theft, sum(b_ct.robbery) b_offenders_robbery, sum(b_ct.forcible_rape) b_offenders_forcible_rape, sum(b_ct.stolen_property) b_offenders_stolen_property,
	sum(b_ct.assault_general) b_offenders_assault_general, sum(b_ct.drugs_general) b_offenders_drugs_general, sum(b_ct.fraud_general) b_offenders_fraud_general,
	sum(b_ct.homicide_general) b_offenders_homicide_general, sum(b_ct.theft_general) b_offenders_theft_general
	FROM nibrs_offenders_12mc_offense as b_ct
	WHERE b_ct.race ~* 'B'
	GROUP BY b_ct.offender_county_no) b_offenders
ON all_and_white.offenders_county_no = b_offenders.b_offenders_county_no