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
	max(ct.burglary) burglary, max(ct.forgery) forgery, 
	max(ct.vandalism) vandalism, max(ct.drugs_narcotics) drugs_narcotics, max(ct.drug_equipment) drug_equipment,
	max(ct.embezzlement) embezzlement, max(ct.extortion) extortion,
	max(ct.credit_card) credit_card, max(ct.welfare_fraud) welfare_fraud,
	max(ct.murder) murder, max(ct.kidnapping) kidnapping,
	max(ct.pocket_picking) pocket_picking, max(ct.purse_snatching) purse_snatching, max(ct.shoplifting) shoplifting,
	max(ct.auto_theft) auto_theft, max(ct.pornography) pornography, max(ct.prostitution) prostitution,
	max(ct.prostitution_promotion) prostitution_promotion, max(ct.prostitution_purchase) prostitution_purchase,
	max(ct.robbery) robbery, max(ct.stolen_property) stolen_property, 
	max(ct.weapon) weapon, max(ct.assault_general) assault_general, max(ct.drugs_general) drugs_general, max(ct.fraud_general) fraud_general,
	max(ct.homicide_general) homicide_general, max(ct.theft_general) theft_general, max(ct.prostitution_general) prostitution_general
	FROM nibrs_offenders_offenses_12 as ct
	WHERE ct.offense IS NOT NULL and ct.attempted ~* 'C'
	GROUP BY ct.offender_id