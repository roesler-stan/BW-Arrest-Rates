--nibrs_offenders_13m_zip_view

CREATE VIEW nibrs_offenders_13m_zip_view AS
(SELECT * FROM
((SELECT
	ct.zipcode offenders_zipcode,
	avg(ct.age) offenders_age,
	count(ct.race) offenders_race_known,
	-- Total arrests who had at least one of the given charge
	sum(ct.offense_arson) offenders_arson, sum(ct.offense_aggravated_assault) offenders_aggravated_assault, sum(ct.offense_simple_assault) offenders_simple_assault,
	sum(ct.offense_intimidation) offenders_intimidation, sum(ct.offense_assault_general) offenders_assault_general, sum(ct.offense_bribery) offenders_bribery,
	sum(ct.offense_burglary) offenders_burglary,
	sum(ct.offense_forgery) offenders_forgery, sum(ct.offense_vandalism) offenders_vandalism, sum(ct.offense_drugs_narcotics) offenders_drugs_narcotics,
	sum(ct.offense_drug_equipment) offenders_drug_equipment, sum(ct.offense_embezzlement) offenders_embezzlement, sum(ct.offense_extortion) offenders_extortion,
	sum(ct.offense_false_pretenses) offenders_false_pretenses, sum(ct.offense_credit_card) offenders_credit_card, sum(ct.offense_impersonation) offenders_impersonation,
	sum(ct.offense_welfare_fraud) offenders_welfare_fraud, sum(ct.offense_wire_fraud) offenders_wire_fraud, sum(ct.offense_fraud_general) offenders_fraud_general,
	sum(ct.offense_betting) offenders_betting, sum(ct.offense_operating_gambling) offenders_operating_gambling, sum(ct.offense_gambling_equipment) offenders_gambling_equipment,
	sum(ct.offense_sports_tampering) offenders_sports_tampering, sum(ct.offense_gambling_general) offenders_gambling_general, sum(ct.offense_murder) offenders_murder,
	sum(ct.offense_negligent_manslaughter) offenders_negligent_manslaughter, sum(ct.offense_justifiable_homicide) offenders_justifiable_homicide,
	sum(ct.offense_homicide_general) offenders_homicide_general, sum(ct.offense_sex_trafficking) offenders_sex_trafficking, sum(ct.offense_labor_trafficking) offenders_labor_trafficking,
	sum(ct.offense_trafficking_general) offenders_trafficking_general, sum(ct.offense_kidnapping) offenders_kidnapping, sum(ct.offense_pocket_picking) offenders_pocket_picking,
	sum(ct.offense_purse_snatching) offenders_purse_snatching, sum(ct.offense_shoplifting) offenders_shoplifting, sum(ct.offense_building_theft) offenders_building_theft,
	sum(ct.offense_theft_from_machine) offenders_theft_from_machine, sum(ct.offense_theft_from_auto) offenders_theft_from_auto, sum(ct.offense_auto_parts_theft) offenders_auto_parts_theft,
	sum(ct.offense_other_theft) offenders_other_theft, sum(ct.offense_theft_general) offenders_theft_general, sum(ct.offense_auto_theft) offenders_auto_theft,
	sum(ct.offense_pornography) offenders_pornography, sum(ct.offense_prostitution) offenders_prostitution, sum(ct.offense_prostitution_promotion) offenders_prostitution_promotion,
	sum(ct.offense_prostitution_purchase) offenders_prostitution_purchase, sum(ct.offense_prostitution_general) offenders_prostitution_general,
	sum(ct.offense_robbery) offenders_robbery, sum(ct.offense_forcible_rape) offenders_forcible_rape, sum(ct.offense_forcible_sodomy) offenders_forcible_sodomy,
	sum(ct.offense_rape_object) offenders_rape_object, sum(ct.offense_forcible_fondling) offenders_forcible_fondling, sum(ct.offense_sex_offense_forcible) offenders_sex_offense_forcible,
	sum(ct.offense_incest) offenders_incest, sum(ct.offense_statutory_rape) offenders_statutory_rape, sum(ct.offense_sex_offense_nonforcible) offenders_sex_offense_nonforcible,
	sum(ct.offense_stolen_property) offenders_stolen_property, sum(ct.offense_weapon) offenders_weapon, sum(ct.offense_ucr_offense_code_unknown) offenders_ucr_offense_code_unknown
	FROM nibrs_offenders_13m_zip as ct
	WHERE ct.race IS NOT NULL and ct.zipcode IS NOT NULL
	GROUP BY ct.zipcode) all_offenders
LEFT OUTER JOIN
(SELECT
	w_ct.zipcode w_offenders_zipcode,
	avg(w_ct.age) w_offenders_age,
	count(w_ct.race) w_offenders_race_known,
	-- Total arrests who had at least one of the given charge
	sum(w_ct.offense_arson) w_offenders_arson, sum(w_ct.offense_aggravated_assault) w_offenders_aggravated_assault, sum(w_ct.offense_simple_assault) w_offenders_simple_assault,
	sum(w_ct.offense_intimidation) w_offenders_intimidation, sum(w_ct.offense_assault_general) w_offenders_assault_general, sum(w_ct.offense_bribery) w_offenders_bribery,
	sum(w_ct.offense_burglary) w_offenders_burglary,
	sum(w_ct.offense_forgery) w_offenders_forgery, sum(w_ct.offense_vandalism) w_offenders_vandalism, sum(w_ct.offense_drugs_narcotics) w_offenders_drugs_narcotics,
	sum(w_ct.offense_drug_equipment) w_offenders_drug_equipment, sum(w_ct.offense_embezzlement) w_offenders_embezzlement, sum(w_ct.offense_extortion) w_offenders_extortion,
	sum(w_ct.offense_false_pretenses) w_offenders_false_pretenses, sum(w_ct.offense_credit_card) w_offenders_credit_card, sum(w_ct.offense_impersonation) w_offenders_impersonation,
	sum(w_ct.offense_welfare_fraud) w_offenders_welfare_fraud, sum(w_ct.offense_wire_fraud) w_offenders_wire_fraud, sum(w_ct.offense_fraud_general) w_offenders_fraud_general,
	sum(w_ct.offense_betting) w_offenders_betting, sum(w_ct.offense_operating_gambling) w_offenders_operating_gambling, sum(w_ct.offense_gambling_equipment) w_offenders_gambling_equipment,
	sum(w_ct.offense_sports_tampering) w_offenders_sports_tampering, sum(w_ct.offense_gambling_general) w_offenders_gambling_general, sum(w_ct.offense_murder) w_offenders_murder,
	sum(w_ct.offense_negligent_manslaughter) w_offenders_negligent_manslaughter, sum(w_ct.offense_justifiable_homicide) w_offenders_justifiable_homicide,
	sum(w_ct.offense_homicide_general) w_offenders_homicide_general, sum(w_ct.offense_sex_trafficking) w_offenders_sex_trafficking, sum(w_ct.offense_labor_trafficking) w_offenders_labor_trafficking,
	sum(w_ct.offense_trafficking_general) w_offenders_trafficking_general, sum(w_ct.offense_kidnapping) w_offenders_kidnapping, sum(w_ct.offense_pocket_picking) w_offenders_pocket_picking,
	sum(w_ct.offense_purse_snatching) w_offenders_purse_snatching, sum(w_ct.offense_shoplifting) w_offenders_shoplifting, sum(w_ct.offense_building_theft) w_offenders_building_theft,
	sum(w_ct.offense_theft_from_machine) w_offenders_theft_from_machine, sum(w_ct.offense_theft_from_auto) w_offenders_theft_from_auto, sum(w_ct.offense_auto_parts_theft) w_offenders_auto_parts_theft,
	sum(w_ct.offense_other_theft) w_offenders_other_theft, sum(w_ct.offense_theft_general) w_offenders_theft_general, sum(w_ct.offense_auto_theft) w_offenders_auto_theft,
	sum(w_ct.offense_pornography) w_offenders_pornography, sum(w_ct.offense_prostitution) w_offenders_prostitution, sum(w_ct.offense_prostitution_promotion) w_offenders_prostitution_promotion,
	sum(w_ct.offense_prostitution_purchase) w_offenders_prostitution_purchase, sum(w_ct.offense_prostitution_general) w_offenders_prostitution_general,
	sum(w_ct.offense_robbery) w_offenders_robbery, sum(w_ct.offense_forcible_rape) w_offenders_forcible_rape, sum(w_ct.offense_forcible_sodomy) w_offenders_forcible_sodomy,
	sum(w_ct.offense_rape_object) w_offenders_rape_object, sum(w_ct.offense_forcible_fondling) w_offenders_forcible_fondling, sum(w_ct.offense_sex_offense_forcible) w_offenders_sex_offense_forcible,
	sum(w_ct.offense_incest) w_offenders_incest, sum(w_ct.offense_statutory_rape) w_offenders_statutory_rape, sum(w_ct.offense_sex_offense_nonforcible) w_offenders_sex_offense_nonforcible,
	sum(w_ct.offense_stolen_property) w_offenders_stolen_property, sum(w_ct.offense_weapon) w_offenders_weapon, sum(w_ct.offense_ucr_offense_code_unknown) w_offenders_ucr_offense_code_unknown
	FROM nibrs_offenders_13m_zip as w_ct
	WHERE w_ct.race = 'white' and w_ct.zipcode IS NOT NULL
	GROUP BY w_ct.zipcode) w_offenders
ON all_offenders.offenders_zipcode = w_offenders.w_offenders_zipcode) all_and_white
LEFT OUTER JOIN
(SELECT
	b_ct.zipcode b_offenders_zipcode,
	avg(b_ct.age) b_offenders_age,
	count(b_ct.race) b_offenders_race_known,
	-- Total arrests who had at least one of the given charge
	sum(b_ct.offense_arson) b_offenders_arson, sum(b_ct.offense_aggravated_assault) b_offenders_aggravated_assault, sum(b_ct.offense_simple_assault) b_offenders_simple_assault,
	sum(b_ct.offense_intimidation) b_offenders_intimidation, sum(b_ct.offense_assault_general) b_offenders_assault_general, sum(b_ct.offense_bribery) b_offenders_bribery,
	sum(b_ct.offense_burglary) b_offenders_burglary,
	sum(b_ct.offense_forgery) b_offenders_forgery, sum(b_ct.offense_vandalism) b_offenders_vandalism, sum(b_ct.offense_drugs_narcotics) b_offenders_drugs_narcotics,
	sum(b_ct.offense_drug_equipment) b_offenders_drug_equipment, sum(b_ct.offense_embezzlement) b_offenders_embezzlement, sum(b_ct.offense_extortion) b_offenders_extortion,
	sum(b_ct.offense_false_pretenses) b_offenders_false_pretenses, sum(b_ct.offense_credit_card) b_offenders_credit_card, sum(b_ct.offense_impersonation) b_offenders_impersonation,
	sum(b_ct.offense_welfare_fraud) b_offenders_welfare_fraud, sum(b_ct.offense_wire_fraud) b_offenders_wire_fraud, sum(b_ct.offense_fraud_general) b_offenders_fraud_general,
	sum(b_ct.offense_betting) b_offenders_betting, sum(b_ct.offense_operating_gambling) b_offenders_operating_gambling, sum(b_ct.offense_gambling_equipment) b_offenders_gambling_equipment,
	sum(b_ct.offense_sports_tampering) b_offenders_sports_tampering, sum(b_ct.offense_gambling_general) b_offenders_gambling_general, sum(b_ct.offense_murder) b_offenders_murder,
	sum(b_ct.offense_negligent_manslaughter) b_offenders_negligent_manslaughter, sum(b_ct.offense_justifiable_homicide) b_offenders_justifiable_homicide,
	sum(b_ct.offense_homicide_general) b_offenders_homicide_general, sum(b_ct.offense_sex_trafficking) b_offenders_sex_trafficking, sum(b_ct.offense_labor_trafficking) b_offenders_labor_trafficking,
	sum(b_ct.offense_trafficking_general) b_offenders_trafficking_general, sum(b_ct.offense_kidnapping) b_offenders_kidnapping, sum(b_ct.offense_pocket_picking) b_offenders_pocket_picking,
	sum(b_ct.offense_purse_snatching) b_offenders_purse_snatching, sum(b_ct.offense_shoplifting) b_offenders_shoplifting, sum(b_ct.offense_building_theft) b_offenders_building_theft,
	sum(b_ct.offense_theft_from_machine) b_offenders_theft_from_machine, sum(b_ct.offense_theft_from_auto) b_offenders_theft_from_auto, sum(b_ct.offense_auto_parts_theft) b_offenders_auto_parts_theft,
	sum(b_ct.offense_other_theft) b_offenders_other_theft, sum(b_ct.offense_theft_general) b_offenders_theft_general, sum(b_ct.offense_auto_theft) b_offenders_auto_theft,
	sum(b_ct.offense_pornography) b_offenders_pornography, sum(b_ct.offense_prostitution) b_offenders_prostitution, sum(b_ct.offense_prostitution_promotion) b_offenders_prostitution_promotion,
	sum(b_ct.offense_prostitution_purchase) b_offenders_prostitution_purchase, sum(b_ct.offense_prostitution_general) b_offenders_prostitution_general,
	sum(b_ct.offense_robbery) b_offenders_robbery, sum(b_ct.offense_forcible_rape) b_offenders_forcible_rape, sum(b_ct.offense_forcible_sodomy) b_offenders_forcible_sodomy,
	sum(b_ct.offense_rape_object) b_offenders_rape_object, sum(b_ct.offense_forcible_fondling) b_offenders_forcible_fondling, sum(b_ct.offense_sex_offense_forcible) b_offenders_sex_offense_forcible,
	sum(b_ct.offense_incest) b_offenders_incest, sum(b_ct.offense_statutory_rape) b_offenders_statutory_rape, sum(b_ct.offense_sex_offense_nonforcible) b_offenders_sex_offense_nonforcible,
	sum(b_ct.offense_stolen_property) b_offenders_stolen_property, sum(b_ct.offense_weapon) b_offenders_weapon, sum(b_ct.offense_ucr_offense_code_unknown) b_offenders_ucr_offense_code_unknown
	FROM nibrs_offenders_13m_zip as b_ct
	WHERE b_ct.race = 'black' and b_ct.zipcode IS NOT NULL
	GROUP BY b_ct.zipcode) b_offenders
ON all_and_white.offenders_zipcode = b_offenders.b_offenders_zipcode)