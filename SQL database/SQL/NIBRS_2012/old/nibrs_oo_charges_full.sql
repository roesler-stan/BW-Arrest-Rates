--nibrs_oo_charges
--All charges with UCR codes in NIBRS data
SELECT
	ct.offender_id offender_id,
	max(ct.ori) ori,
	max(ct.incident) incident,
	max(ct.date) date,
	avg(ct.age) age,
	max(ct.gender) gender,
	max(ct.race) race,
	avg(ct.number_offenses) number_offenses,
	count(ct.offense) offense_count,
	--
	max(ct.arson) arson, max(ct.aggravated_assault) aggravated_assault, max(ct.simple_assault) simple_assault,
	max(ct.intimidation) intimidation, max(ct.bribery) bribery, max(ct.burglary) burglary, max(ct.forgery) forgery, 
	max(ct.vandalism) vandalism, max(ct.drugs_narcotics) drugs_narcotics, max(ct.drug_equipment) drug_equipment,
	max(ct.embezzlement) embezzlement, max(ct.extortion) extortion, max(ct.false_pretenses) false_pretenses,
	max(ct.credit_card) credit_card, max(ct.impersonation) impersonation,  max(ct.welfare_fraud) welfare_fraud,
	max(ct.wire_fraud) wire_fraud, max(ct.betting) betting, max(ct.operating_gambling) operating_gambling,
	max(ct.gambling_equipment) gambling_equipment, max(ct.sports_tampering) sports_tampering,  max(ct.murder) murder,
	max(ct.negligent_manslaughter) negligent_manslaughter, max(ct.justifiable_homicide) justifiable_homicide, 
	max(ct.sex_trafficking) sex_trafficking,  max(ct.labor_trafficking) labor_trafficking,  max(ct.kidnapping) kidnapping,
	max(ct.pocket_picking) pocket_picking, max(ct.purse_snatching) purse_snatching, max(ct.shoplifting) shoplifting,
	max(ct.building_theft) building_theft, max(ct.theft_from_machine) theft_from_machine,
	max(ct.theft_from_auto) theft_from_auto, max(ct.auto_parts_theft) auto_parts_theft, max(ct.other_theft) other_theft,
	max(ct.auto_theft) auto_theft, max(ct.pornography) pornography, max(ct.prostitution) prostitution,
	max(ct.prostitution_promotion) prostitution_promotion, max(ct.prostitution_purchase) prostitution_purchase,
	max(ct.robbery) robbery, max(ct.forcible_rape) forcible_rape, max(ct.forcible_sodomy) forcible_sodomy, max(ct.rape_object) rape_object, 
	max(ct.forcible_fondling) forcible_fondling,  max(ct.incest) incest,  max(ct.statutory_rape) statutory_rape,  max(ct.stolen_property) stolen_property, 
	max(ct.weapon) weapon, max(ct.assault_general) assault_general, max(ct.drugs_general) drugs_general, max(ct.fraud_general) fraud_general,
	max(ct.gambling_general) gambling_general, max(ct.homicide_general) homicide_general, max(ct.trafficking_general) trafficking_general,
	max(ct.theft_general) theft_general, max(ct.prostitution_general) prostitution_general,
	max(ct.sex_offense_forcible) sex_offense_forcible, max(ct.sex_offense_nonforcible) sex_offense_nonforcible
	FROM nibrs_offenders_offenses_12 as ct
	WHERE ct.offense IS NOT NULL and ct.attempted ~* 'C'
	GROUP BY ct.offender_id