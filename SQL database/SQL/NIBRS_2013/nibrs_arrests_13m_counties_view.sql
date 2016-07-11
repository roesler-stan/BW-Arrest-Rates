--nibrs_arrests_13m_counties_view

CREATE VIEW nibrs_arrests_13m_counties_view AS
(SELECT * FROM
((SELECT
	ct.fips_county1_no arrests_county_no,
	avg(ct.age) arrests_age,
	count(ct.race) arrests_race_known,
	-- Total arrests who had at least one of the given charge
	sum(ct.arson) arrests_arson, sum(ct.aggravated_assault) arrests_aggravated_assault, sum(ct.simple_assault) arrests_simple_assault,
	sum(ct.intimidation) arrests_intimidation, sum(ct.assault_general) arrests_assault_general, sum(ct.bribery) arrests_bribery,
	sum(ct.burglary) arrests_burglary,
	sum(ct.forgery) arrests_forgery, sum(ct.vandalism) arrests_vandalism, sum(ct.drugs_narcotics) arrests_drugs_narcotics,
	sum(ct.drug_equipment) arrests_drug_equipment, sum(ct.embezzlement) arrests_embezzlement, sum(ct.extortion) arrests_extortion,
	sum(ct.false_pretenses) arrests_false_pretenses, sum(ct.credit_card) arrests_credit_card, sum(ct.impersonation) arrests_impersonation,
	sum(ct.welfare_fraud) arrests_welfare_fraud, sum(ct.wire_fraud) arrests_wire_fraud, sum(ct.fraud_general) arrests_fraud_general,
	sum(ct.betting) arrests_betting, sum(ct.operating_gambling) arrests_operating_gambling, sum(ct.gambling_equipment) arrests_gambling_equipment,
	sum(ct.sports_tampering) arrests_sports_tampering, sum(gambling_general) arrests_gambling_general, sum(ct.murder) arrests_murder,
	sum(ct.negligent_manslaughter) arrests_negligent_manslaughter, sum(ct.justifiable_homicide) arrests_justifiable_homicide,
	sum(ct.homicide_general) arrests_homicide_general, sum(ct.sex_trafficking) arrests_sex_trafficking, sum(ct.labor_trafficking) arrests_labor_trafficking,
	sum(ct.trafficking_general) arrests_trafficking_general, sum(ct.kidnapping) arrests_kidnapping, sum(ct.pocket_picking) arrests_pocket_picking,
	sum(ct.purse_snatching) arrests_purse_snatching, sum(ct.shoplifting) arrests_shoplifting, sum(ct.building_theft) arrests_building_theft,
	sum(ct.theft_from_machine) arrests_theft_from_machine, sum(ct.theft_from_auto) arrests_theft_from_auto, sum(ct.auto_parts_theft) arrests_auto_parts_theft,
	sum(ct.other_theft) arrests_other_theft, sum(ct.theft_general) arrests_theft_general, sum(ct.auto_theft) arrests_auto_theft,
	sum(ct.pornography) arrests_pornography, sum(ct.prostitution) arrests_prostitution, sum(ct.prostitution_promotion) arrests_prostitution_promotion,
	sum(ct.prostitution_purchase) arrests_prostitution_purchase, sum(ct.prostitution_general) arrests_prostitution_general,
	sum(ct.robbery) arrests_robbery, sum(ct.forcible_rape) arrests_forcible_rape, sum(ct.forcible_sodomy) arrests_forcible_sodomy,
	sum(ct.rape_object) arrests_rape_object, sum(ct.forcible_fondling) arrests_forcible_fondling, sum(ct.sex_offense_forcible) arrests_sex_offense_forcible,
	sum(ct.incest) arrests_incest, sum(ct.statutory_rape) arrests_statutory_rape, sum(ct.sex_offense_nonforcible) arrests_sex_offense_nonforcible,
	sum(ct.stolen_property) arrests_stolen_property, sum(ct.weapon) arrests_weapon, sum(ct.ucr_offense_code_unknown) arrests_ucr_offense_code_unknown,
	-- Offense B Arrest Charges
	sum(ct.bad_check) arrests_bad_check, sum(ct.loitering) arrests_loitering, sum(ct.disorder) arrests_disorder,
	sum(ct.dui) arrests_dui, sum(ct.family_nonv) arrests_family_nonv, sum(ct.liquor_law) arrests_liquor_law, sum(ct.peeping_tom) arrests_peeping_tom,
	sum(ct.runaway) arrests_runaway, sum(ct.trespass) arrests_trespass, sum(ct.other_offense) arrests_other_offense
	FROM nibrs_arrests_13m as ct
	WHERE ct.race IS NOT NULL
	GROUP BY ct.fips_county1_no) all_arrests
LEFT OUTER JOIN
(SELECT
	w_ct.fips_county1_no w_arrests_county_no,
	avg(w_ct.age) w_arrests_age,
	count(w_ct.race) w_arrests_race_known,
	-- Total arrests who had at least one of the given charge
	sum(w_ct.arson) w_arrests_arson, sum(w_ct.aggravated_assault) w_arrests_aggravated_assault, sum(w_ct.simple_assault) w_arrests_simple_assault,
	sum(w_ct.intimidation) w_arrests_intimidation, sum(w_ct.assault_general) w_arrests_assault_general, sum(w_ct.bribery) w_arrests_bribery,
	sum(w_ct.burglary) w_arrests_burglary,
	sum(w_ct.forgery) w_arrests_forgery, sum(w_ct.vandalism) w_arrests_vandalism, sum(w_ct.drugs_narcotics) w_arrests_drugs_narcotics,
	sum(w_ct.drug_equipment) w_arrests_drug_equipment, sum(w_ct.embezzlement) w_arrests_embezzlement, sum(w_ct.extortion) w_arrests_extortion,
	sum(w_ct.false_pretenses) w_arrests_false_pretenses, sum(w_ct.credit_card) w_arrests_credit_card, sum(w_ct.impersonation) w_arrests_impersonation,
	sum(w_ct.welfare_fraud) w_arrests_welfare_fraud, sum(w_ct.wire_fraud) w_arrests_wire_fraud, sum(w_ct.fraud_general) w_arrests_fraud_general,
	sum(w_ct.betting) w_arrests_betting, sum(w_ct.operating_gambling) w_arrests_operating_gambling, sum(w_ct.gambling_equipment) w_arrests_gambling_equipment,
	sum(w_ct.sports_tampering) w_arrests_sports_tampering, sum(gambling_general) w_arrests_gambling_general, sum(w_ct.murder) w_arrests_murder,
	sum(w_ct.negligent_manslaughter) w_arrests_negligent_manslaughter, sum(w_ct.justifiable_homicide) w_arrests_justifiable_homicide,
	sum(w_ct.homicide_general) w_arrests_homicide_general, sum(w_ct.sex_trafficking) w_arrests_sex_trafficking, sum(w_ct.labor_trafficking) w_arrests_labor_trafficking,
	sum(w_ct.trafficking_general) w_arrests_trafficking_general, sum(w_ct.kidnapping) w_arrests_kidnapping, sum(w_ct.pocket_picking) w_arrests_pocket_picking,
	sum(w_ct.purse_snatching) w_arrests_purse_snatching, sum(w_ct.shoplifting) w_arrests_shoplifting, sum(w_ct.building_theft) w_arrests_building_theft,
	sum(w_ct.theft_from_machine) w_arrests_theft_from_machine, sum(w_ct.theft_from_auto) w_arrests_theft_from_auto, sum(w_ct.auto_parts_theft) w_arrests_auto_parts_theft,
	sum(w_ct.other_theft) w_arrests_other_theft, sum(w_ct.theft_general) w_arrests_theft_general, sum(w_ct.auto_theft) w_arrests_auto_theft,
	sum(w_ct.pornography) w_arrests_pornography, sum(w_ct.prostitution) w_arrests_prostitution, sum(w_ct.prostitution_promotion) w_arrests_prostitution_promotion,
	sum(w_ct.prostitution_purchase) w_arrests_prostitution_purchase, sum(w_ct.prostitution_general) w_arrests_prostitution_general,
	sum(w_ct.robbery) w_arrests_robbery, sum(w_ct.forcible_rape) w_arrests_forcible_rape, sum(w_ct.forcible_sodomy) w_arrests_forcible_sodomy,
	sum(w_ct.rape_object) w_arrests_rape_object, sum(w_ct.forcible_fondling) w_arrests_forcible_fondling, sum(w_ct.sex_offense_forcible) w_arrests_sex_offense_forcible,
	sum(w_ct.incest) w_arrests_incest, sum(w_ct.statutory_rape) w_arrests_statutory_rape, sum(w_ct.sex_offense_nonforcible) w_arrests_sex_offense_nonforcible,
	sum(w_ct.stolen_property) w_arrests_stolen_property, sum(w_ct.weapon) w_arrests_weapon, sum(w_ct.ucr_offense_code_unknown) w_arrests_ucr_offense_code_unknown,
	-- Offense B Arrest Charges
	sum(w_ct.bad_check) w_arrests_bad_check, sum(w_ct.loitering) w_arrests_loitering, sum(w_ct.disorder) w_arrests_disorder,
	sum(w_ct.dui) w_arrests_dui, sum(w_ct.family_nonv) w_arrests_family_nonv, sum(w_ct.liquor_law) w_arrests_liquor_law, sum(w_ct.peeping_tom) w_arrests_peeping_tom,
	sum(w_ct.runaway) w_arrests_runaway, sum(w_ct.trespass) w_arrests_trespass, sum(w_ct.other_offense) w_arrests_other_offense
	FROM nibrs_arrests_13m as w_ct
	WHERE w_ct.race = 'white'
	GROUP BY w_ct.fips_county1_no) w_arrests
ON all_arrests.arrests_county_no = w_arrests.w_arrests_county_no) all_and_white
LEFT OUTER JOIN
(SELECT
	b_ct.fips_county1_no b_arrests_county_no,
	avg(b_ct.age) b_arrests_age,
	count(b_ct.race) b_arrests_race_known,
	-- Total arrests who had at least one of the given charge
	sum(b_ct.arson) b_arrests_arson, sum(b_ct.aggravated_assault) b_arrests_aggravated_assault, sum(b_ct.simple_assault) b_arrests_simple_assault,
	sum(b_ct.intimidation) b_arrests_intimidation, sum(b_ct.assault_general) b_arrests_assault_general, sum(b_ct.bribery) b_arrests_bribery,
	sum(b_ct.burglary) b_arrests_burglary,
	sum(b_ct.forgery) b_arrests_forgery, sum(b_ct.vandalism) b_arrests_vandalism, sum(b_ct.drugs_narcotics) b_arrests_drugs_narcotics,
	sum(b_ct.drug_equipment) b_arrests_drug_equipment, sum(b_ct.embezzlement) b_arrests_embezzlement, sum(b_ct.extortion) b_arrests_extortion,
	sum(b_ct.false_pretenses) b_arrests_false_pretenses, sum(b_ct.credit_card) b_arrests_credit_card, sum(b_ct.impersonation) b_arrests_impersonation,
	sum(b_ct.welfare_fraud) b_arrests_welfare_fraud, sum(b_ct.wire_fraud) b_arrests_wire_fraud, sum(b_ct.fraud_general) b_arrests_fraud_general,
	sum(b_ct.betting) b_arrests_betting, sum(b_ct.operating_gambling) b_arrests_operating_gambling, sum(b_ct.gambling_equipment) b_arrests_gambling_equipment,
	sum(b_ct.sports_tampering) b_arrests_sports_tampering, sum(gambling_general) b_arrests_gambling_general, sum(b_ct.murder) b_arrests_murder,
	sum(b_ct.negligent_manslaughter) b_arrests_negligent_manslaughter, sum(b_ct.justifiable_homicide) b_arrests_justifiable_homicide,
	sum(b_ct.homicide_general) b_arrests_homicide_general, sum(b_ct.sex_trafficking) b_arrests_sex_trafficking, sum(b_ct.labor_trafficking) b_arrests_labor_trafficking,
	sum(b_ct.trafficking_general) b_arrests_trafficking_general, sum(b_ct.kidnapping) b_arrests_kidnapping, sum(b_ct.pocket_picking) b_arrests_pocket_picking,
	sum(b_ct.purse_snatching) b_arrests_purse_snatching, sum(b_ct.shoplifting) b_arrests_shoplifting, sum(b_ct.building_theft) b_arrests_building_theft,
	sum(b_ct.theft_from_machine) b_arrests_theft_from_machine, sum(b_ct.theft_from_auto) b_arrests_theft_from_auto, sum(b_ct.auto_parts_theft) b_arrests_auto_parts_theft,
	sum(b_ct.other_theft) b_arrests_other_theft, sum(b_ct.theft_general) b_arrests_theft_general, sum(b_ct.auto_theft) b_arrests_auto_theft,
	sum(b_ct.pornography) b_arrests_pornography, sum(b_ct.prostitution) b_arrests_prostitution, sum(b_ct.prostitution_promotion) b_arrests_prostitution_promotion,
	sum(b_ct.prostitution_purchase) b_arrests_prostitution_purchase, sum(b_ct.prostitution_general) b_arrests_prostitution_general,
	sum(b_ct.robbery) b_arrests_robbery, sum(b_ct.forcible_rape) b_arrests_forcible_rape, sum(b_ct.forcible_sodomy) b_arrests_forcible_sodomy,
	sum(b_ct.rape_object) b_arrests_rape_object, sum(b_ct.forcible_fondling) b_arrests_forcible_fondling, sum(b_ct.sex_offense_forcible) b_arrests_sex_offense_forcible,
	sum(b_ct.incest) b_arrests_incest, sum(b_ct.statutory_rape) b_arrests_statutory_rape, sum(b_ct.sex_offense_nonforcible) b_arrests_sex_offense_nonforcible,
	sum(b_ct.stolen_property) b_arrests_stolen_property, sum(b_ct.weapon) b_arrests_weapon, sum(b_ct.ucr_offense_code_unknown) b_arrests_ucr_offense_code_unknown,
	-- Offense B Arrest Charges
	sum(b_ct.bad_check) b_arrests_bad_check, sum(b_ct.loitering) b_arrests_loitering, sum(b_ct.disorder) b_arrests_disorder,
	sum(b_ct.dui) b_arrests_dui, sum(b_ct.family_nonv) b_arrests_family_nonv, sum(b_ct.liquor_law) b_arrests_liquor_law, sum(b_ct.peeping_tom) b_arrests_peeping_tom,
	sum(b_ct.runaway) b_arrests_runaway, sum(b_ct.trespass) b_arrests_trespass, sum(b_ct.other_offense) b_arrests_other_offense
	FROM nibrs_arrests_13m as b_ct
	WHERE b_ct.race = 'black'
	GROUP BY b_ct.fips_county1_no) b_arrests
ON all_and_white.arrests_county_no = b_arrests.b_arrests_county_no)