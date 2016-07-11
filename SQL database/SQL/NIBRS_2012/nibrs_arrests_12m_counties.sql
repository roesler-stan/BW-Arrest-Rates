--nibrs_arrests_12m_counties

SELECT * FROM
((SELECT
	ct.county_no arrests_county_no,
	avg(ct.age) arrests_age,
	count(ct.race) arrests_race_known,
	-- Total arrests who had at least one of the given charge
	sum(ct.burglary) arrests_burglary, sum(ct.forgery) arrests_forgery, sum(ct.drugs_narcotics) arrests_drugs_narcotics,
	sum(ct.embezzlement) arrests_embezzlement, sum(ct.murder) arrests_murder,
	sum(ct.auto_theft) arrests_auto_theft, sum(ct.robbery) arrests_robbery, sum(ct.forcible_rape) arrests_forcible_rape, sum(ct.stolen_property) arrests_stolen_property,
	sum(ct.assault_general) arrests_assault_general, sum(ct.drugs_general) arrests_drugs_general, sum(ct.fraud_general) arrests_fraud_general,
	sum(ct.homicide_general) arrests_homicide_general, sum(ct.theft_general) arrests_theft_general,
	sum(bad_check) bad_check, sum(loitering) loitering, sum(disorder) disorder, sum(dui) dui,
	sum(drunk) drunk, sum(family_nonv) family_nonv, sum(liquor_law) liquor_law, sum(peeping_tom) peeping_tom,
	sum(runaway) runaway, sum(trespass) trespass, sum(other_offense) other_offense
	FROM nibrs_arrests_12m_county as ct
	GROUP BY ct.county_no) all_arrests
LEFT OUTER JOIN
(SELECT
	w_ct.county_no w_arrests_county_no,
	avg(w_ct.age) w_arrests_age,
	count(w_ct.race) w_arrests,
	-- Total arrests who had at least one of the given charge
	sum(w_ct.burglary) w_arrests_burglary, sum(w_ct.forgery) w_arrests_forgery, sum(w_ct.drugs_narcotics) w_arrests_drugs_narcotics,
	sum(w_ct.embezzlement) w_arrests_embezzlement, sum(w_ct.murder) w_arrests_murder,
	sum(w_ct.auto_theft) w_arrests_auto_theft, sum(w_ct.robbery) w_arrests_robbery, sum(w_ct.forcible_rape) w_arrests_forcible_rape, sum(w_ct.stolen_property) w_arrests_stolen_property,
	sum(w_ct.assault_general) w_arrests_assault_general, sum(w_ct.drugs_general) w_arrests_drugs_general, sum(w_ct.fraud_general) w_arrests_fraud_general,
	sum(w_ct.homicide_general) w_arrests_homicide_general, sum(w_ct.theft_general) w_arrests_theft_general,
	sum(bad_check) w_bad_check, sum(loitering) w_loitering, sum(disorder) w_disorder, sum(dui) w_dui,
	sum(drunk) w_drunk, sum(family_nonv) w_family_nonv, sum(liquor_law) w_liquor_law, sum(peeping_tom) w_peeping_tom,
	sum(runaway) w_runaway, sum(trespass) w_trespass, sum(other_offense) w_other_offense
	FROM nibrs_arrests_12m_county as w_ct
	WHERE w_ct.race ~* 'W'
	GROUP BY w_ct.county_no) w_arrests
ON all_arrests.arrests_county_no = w_arrests.w_arrests_county_no) all_and_white
LEFT OUTER JOIN
(SELECT
	b_ct.county_no b_arrests_county_no,
	avg(b_ct.age) b_arrests_age,
	count(b_ct.race) b_arrests,
	-- Total arrests who had at least one of the given charge
	sum(b_ct.burglary) b_arrests_burglary, sum(b_ct.forgery) b_arrests_forgery, sum(b_ct.drugs_narcotics) b_arrests_drugs_narcotics,
	sum(b_ct.embezzlement) b_arrests_embezzlement, sum(b_ct.murder) b_arrests_murder,
	sum(b_ct.auto_theft) b_arrests_auto_theft, sum(b_ct.robbery) b_arrests_robbery, sum(b_ct.forcible_rape) b_arrests_forcible_rape, sum(b_ct.stolen_property) b_arrests_stolen_property,
	sum(b_ct.assault_general) b_arrests_assault_general, sum(b_ct.drugs_general) b_arrests_drugs_general, sum(b_ct.fraud_general) b_arrests_fraud_general,
	sum(b_ct.homicide_general) b_arrests_homicide_general, sum(b_ct.theft_general) b_arrests_theft_general,
	sum(bad_check) b_bad_check, sum(loitering) b_loitering, sum(disorder) b_disorder, sum(dui) b_dui,
	sum(drunk) b_drunk, sum(family_nonv) b_family_nonv, sum(liquor_law) b_liquor_law, sum(peeping_tom) b_peeping_tom,
	sum(runaway) b_runaway, sum(trespass) b_trespass, sum(other_offense) b_other_offense
	FROM nibrs_arrests_12m_county as b_ct
	WHERE b_ct.race ~* 'B'
	GROUP BY b_ct.county_no) b_arrests
ON all_and_white.arrests_county_no = b_arrests.b_arrests_county_no