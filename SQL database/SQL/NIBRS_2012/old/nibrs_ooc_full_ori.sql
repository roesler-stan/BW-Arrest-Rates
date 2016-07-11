--nibrs_ooc_full_ori
--All charges with UCR codes in NIBRS data
SELECT * FROM
((SELECT
	ct.ori ori,
	avg(ct.age) age,
	max(ct.gender) gender,
	max(ct.race) race,
	-- Total number of offenders
	count(offender_id) offender_count,
	-- Total number of offenses
	sum(ct.offense_count) offense_count_sum,
	-- Average number of offenses per offender, as counted from known offensees
	avg(ct.offense_count) offense_count_avg,
	-- Average number of offenses per offender, as provided by data
	avg(ct.number_offenses) number_offenses_avg,
	-- Total offenders who had at least one of the given charge
	sum(ct.arson) arson_sum, sum(ct.aggravated_assault) aggravated_assault_sum, sum(ct.simple_assault) simple_assault_sum,
	sum(ct.intimidation) intimidation_sum, sum(ct.bribery) bribery_sum, sum(ct.burglary) burglary_sum, sum(ct.forgery) forgery_sum, 
	sum(ct.vandalism) vandalism_sum, sum(ct.drugs_narcotics) drugs_narcotics_sum, sum(ct.drug_equipment) drug_equipment_sum,
	sum(ct.embezzlement) embezzlement_sum, sum(ct.extortion) extortion_sum, sum(ct.false_pretenses) false_pretenses_sum,
	sum(ct.credit_card) credit_card_sum, sum(ct.impersonation) impersonation_sum,  sum(ct.welfare_fraud) welfare_fraud_sum,
	sum(ct.wire_fraud) wire_fraud_sum, sum(ct.betting) betting_sum, sum(ct.operating_gambling) operating_gambling_sum,
	sum(ct.gambling_equipment) gambling_equipment_sum, sum(ct.sports_tampering) sports_tampering_sum,  sum(ct.murder) murder_sum,
	sum(ct.negligent_manslaughter) negligent_manslaughter_sum, sum(ct.justifiable_homicide) justifiable_homicide_sum, 
	sum(ct.sex_trafficking) sex_trafficking_sum,  sum(ct.labor_trafficking) labor_trafficking_sum,  sum(ct.kidnapping) kidnapping_sum,
	sum(ct.pocket_picking) pocket_picking_sum, sum(ct.purse_snatching) purse_snatching_sum, sum(ct.shoplifting) shoplifting_sum,
	sum(ct.building_theft) building_theft_sum, sum(ct.theft_from_machine) theft_from_machine_sum,
	sum(ct.theft_from_auto) theft_from_auto_sum, sum(ct.auto_parts_theft) auto_parts_theft_sum, sum(ct.other_theft) other_theft_sum,
	sum(ct.auto_theft) auto_theft_sum, sum(ct.pornography) pornography_sum, sum(ct.prostitution) prostitution_sum,
	sum(ct.prostitution_promotion) prostitution_promotion_sum, sum(ct.prostitution_purchase) prostitution_purchase_sum,
	sum(ct.robbery) robbery_sum, sum(ct.forcible_rape) forcible_rape_sum, sum(ct.forcible_sodomy) forcible_rape_sum, sum(ct.rape_object) rape_object_sum, 
	sum(ct.forcible_fondling) forcible_fondling_sum,  sum(ct.incest) incest_sum,  sum(ct.statutory_rape) statutory_rape_sum,  sum(ct.stolen_property) stolen_property_sum, 
	sum(ct.weapon) weapon_sum, sum(ct.assault_general) assault_general_sum, sum(ct.drugs_general) drugs_general_sum, sum(ct.fraud_general) fraud_general_sum,
	sum(ct.gambling_general) gambling_general_sum, sum(ct.homicide_general) homicide_general_sum, sum(ct.trafficking_general) trafficking_general_sum,
	sum(ct.theft_general) theft_general_sum, sum(ct.prostitution_general) prostitution_general_sum,
	sum(ct.sex_offense_forcible) sex_offense_forcible_sum, sum(ct.sex_offense_nonforcible) sex_offense_nonforcible_sum
	FROM nibrs_oo_charges as ct
	WHERE ct.race IS NOT NULL
	GROUP BY ct.ori) all_offenders
LEFT OUTER JOIN
(SELECT
	w_ct.ori w_ori,
	avg(w_ct.age) w_age,
	max(w_ct.gender) w_gender,
	max(w_ct.race) w_race,
	-- Total number of offenders
	count(offender_id) w_offender_count,
	-- Total number of offenses
	sum(w_ct.offense_count) w_offense_count_sum,
	-- Average number of offenses per offender, as counted from known offensees
	avg(w_ct.offense_count) w_offense_count_avg,
	-- Average number of offenses per offender, as provided by data
	avg(w_ct.number_offenses) w_number_offenses_avg,
	-- Total offenders who had at least one of the given charge
	sum(w_ct.arson) w_arson_sum, sum(w_ct.aggravated_assault) w_aggravated_assault_sum, sum(w_ct.simple_assault) w_simple_assault_sum,
	sum(w_ct.intimidation) w_intimidation_sum, sum(w_ct.bribery) w_bribery_sum, sum(w_ct.burglary) w_burglary_sum, sum(w_ct.forgery) w_forgery_sum, 
	sum(w_ct.vandalism) w_vandalism_sum, sum(w_ct.drugs_narcotics) w_drugs_narcotics_sum, sum(w_ct.drug_equipment) w_drug_equipment_sum,
	sum(w_ct.embezzlement) w_embezzlement_sum, sum(w_ct.extortion) w_extortion_sum, sum(w_ct.false_pretenses) w_false_pretenses_sum,
	sum(w_ct.credit_card) w_credit_card_sum, sum(w_ct.impersonation) w_impersonation_sum,  sum(w_ct.welfare_fraud) w_welfare_fraud_sum,
	sum(w_ct.wire_fraud) w_wire_fraud_sum, sum(w_ct.betting) w_betting_sum, sum(w_ct.operating_gambling) w_operating_gambling_sum,
	sum(w_ct.gambling_equipment) w_gambling_equipment_sum, sum(w_ct.sports_tampering) w_sports_tampering_sum,  sum(w_ct.murder) w_murder_sum,
	sum(w_ct.negligent_manslaughter) w_negligent_manslaughter_sum, sum(w_ct.justifiable_homicide) w_justifiable_homicide_sum, 
	sum(w_ct.sex_trafficking) w_sex_trafficking_sum,  sum(w_ct.labor_trafficking) w_labor_trafficking_sum,  sum(w_ct.kidnapping) w_kidnapping_sum,
	sum(w_ct.pocket_picking) w_pocket_picking_sum, sum(w_ct.purse_snatching) w_purse_snatching_sum, sum(w_ct.shoplifting) w_shoplifting_sum,
	sum(w_ct.building_theft) w_building_theft_sum, sum(w_ct.theft_from_machine) w_theft_from_machine_sum,
	sum(w_ct.theft_from_auto) w_theft_from_auto_sum, sum(w_ct.auto_parts_theft) w_auto_parts_theft_sum, sum(w_ct.other_theft) w_other_theft_sum,
	sum(w_ct.auto_theft) w_auto_theft_sum, sum(w_ct.pornography) w_pornography_sum, sum(w_ct.prostitution) w_prostitution_sum,
	sum(w_ct.prostitution_promotion) w_prostitution_promotion_sum, sum(w_ct.prostitution_purchase) w_prostitution_purchase_sum,
	sum(w_ct.robbery) w_robbery_sum, sum(w_ct.forcible_rape) w_forcible_rape_sum, sum(w_ct.forcible_sodomy) w_forcible_rape_sum, sum(w_ct.rape_objew_ct) w_rape_objew_ct_sum, 
	sum(w_ct.forcible_fondling) w_forcible_fondling_sum,  sum(w_ct.incest) w_incest_sum,  sum(w_ct.statutory_rape) w_statutory_rape_sum,  sum(w_ct.stolen_property) w_stolen_property_sum, 
	sum(w_ct.weapon) w_weapon_sum, sum(w_ct.assault_general) w_assault_general_sum, sum(w_ct.drugs_general) w_drugs_general_sum, sum(w_ct.fraud_general) w_fraud_general_sum,
	sum(w_ct.gambling_general) w_gambling_general_sum, sum(w_ct.homicide_general) w_homicide_general_sum, sum(w_ct.trafficking_general) w_trafficking_general_sum,
	sum(w_ct.theft_general) w_theft_general_sum, sum(w_ct.prostitution_general) w_prostitution_general_sum,
	sum(w_ct.sex_offense_forcible) w_sex_offense_forcible_sum, sum(w_ct.sex_offense_nonforcible) w_sex_offense_nonforcible_sum
	FROM nibrs_oo_charges as w_ct
	WHERE w_ct.race ~* 'W'
	GROUP BY w_ct.ori) w_offenders
ON all_offenders.ori = w_offenders.w_ori) all_and_white
LEFT OUTER JOIN
(SELECT
	b_ct.ori b_ori,
	avg(b_ct.age) b_age,
	max(b_ct.gender) b_gender,
	max(b_ct.race) b_race,
	-- Total number of offenders
	count(offender_id) b_offender_count,
	-- Total number of offenses
	sum(b_ct.offense_count) b_offense_count_sum,
	-- Average number of offenses per offender, as counted from known offensees
	avg(b_ct.offense_count) b_offense_count_avg,
	-- Average number of offenses per offender, as provided by data
	avg(b_ct.number_offenses) b_number_offenses_avg,
	-- Total offenders who had at least one of the given charge
	sum(b_ct.arson) b_arson_sum, sum(b_ct.aggravated_assault) b_aggravated_assault_sum, sum(b_ct.simple_assault) b_simple_assault_sum,
	sum(b_ct.intimidation) b_intimidation_sum, sum(b_ct.bribery) b_bribery_sum, sum(b_ct.burglary) b_burglary_sum, sum(b_ct.forgery) b_forgery_sum, 
	sum(b_ct.vandalism) b_vandalism_sum, sum(b_ct.drugs_narcotics) b_drugs_narcotics_sum, sum(b_ct.drug_equipment) b_drug_equipment_sum,
	sum(b_ct.embezzlement) b_embezzlement_sum, sum(b_ct.extortion) b_extortion_sum, sum(b_ct.false_pretenses) b_false_pretenses_sum,
	sum(b_ct.credit_card) b_credit_card_sum, sum(b_ct.impersonation) b_impersonation_sum,  sum(b_ct.welfare_fraud) b_welfare_fraud_sum,
	sum(b_ct.wire_fraud) b_wire_fraud_sum, sum(b_ct.betting) b_betting_sum, sum(b_ct.operating_gambling) b_operating_gambling_sum,
	sum(b_ct.gambling_equipment) b_gambling_equipment_sum, sum(b_ct.sports_tampering) b_sports_tampering_sum,  sum(b_ct.murder) b_murder_sum,
	sum(b_ct.negligent_manslaughter) b_negligent_manslaughter_sum, sum(b_ct.justifiable_homicide) b_justifiable_homicide_sum, 
	sum(b_ct.sex_trafficking) b_sex_trafficking_sum,  sum(b_ct.labor_trafficking) b_labor_trafficking_sum,  sum(b_ct.kidnapping) b_kidnapping_sum,
	sum(b_ct.pocket_picking) b_pocket_picking_sum, sum(b_ct.purse_snatching) b_purse_snatching_sum, sum(b_ct.shoplifting) b_shoplifting_sum,
	sum(b_ct.building_theft) b_building_theft_sum, sum(b_ct.theft_from_machine) b_theft_from_machine_sum,
	sum(b_ct.theft_from_auto) b_theft_from_auto_sum, sum(b_ct.auto_parts_theft) b_auto_parts_theft_sum, sum(b_ct.other_theft) b_other_theft_sum,
	sum(b_ct.auto_theft) b_auto_theft_sum, sum(b_ct.pornography) b_pornography_sum, sum(b_ct.prostitution) b_prostitution_sum,
	sum(b_ct.prostitution_promotion) b_prostitution_promotion_sum, sum(b_ct.prostitution_purchase) b_prostitution_purchase_sum,
	sum(b_ct.robbery) b_robbery_sum, sum(b_ct.forcible_rape) b_forcible_rape_sum, sum(b_ct.forcible_sodomy) b_forcible_rape_sum, sum(b_ct.rape_objeb_ct) b_rape_objeb_ct_sum, 
	sum(b_ct.forcible_fondling) b_forcible_fondling_sum,  sum(b_ct.incest) b_incest_sum,  sum(b_ct.statutory_rape) b_statutory_rape_sum,  sum(b_ct.stolen_property) b_stolen_property_sum, 
	sum(b_ct.weapon) b_weapon_sum, sum(b_ct.assault_general) b_assault_general_sum, sum(b_ct.drugs_general) b_drugs_general_sum, sum(b_ct.fraud_general) b_fraud_general_sum,
	sum(b_ct.gambling_general) b_gambling_general_sum, sum(b_ct.homicide_general) b_homicide_general_sum, sum(b_ct.trafficking_general) b_trafficking_general_sum,
	sum(b_ct.theft_general) b_theft_general_sum, sum(b_ct.prostitution_general) b_prostitution_general_sum,
	sum(b_ct.sex_offense_forcible) b_sex_offense_forcible_sum, sum(b_ct.sex_offense_nonforcible) b_sex_offense_nonforcible_sum
	FROM nibrs_oo_charges as b_ct
	WHERE b_ct.race ~* 'B'
	GROUP BY b_ct.ori) b_offenders
ON all_and_white.ori = b_offenders.b_ori