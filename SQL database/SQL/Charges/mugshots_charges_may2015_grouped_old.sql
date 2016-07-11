--mugshots_charges_july2015_grouped
SELECT
	ct.arrest_id charges_arrest_id,
	count(ct.charge) charge_string_count,
	sum(ct.charge_coded) charge_coded_count,
	max(ct.charge_coded) any_charge_coded,
	--
	max(ct.murder) murder, max(ct.rape) rape, max(ct.robbery) robbery,
	max(ct.assault) assault, max(ct.burglary) burglary,
	max(ct.theft) theft, max(ct.auto_theft) auto_theft,
	max(ct.fraud) fraud, max(ct.embez) embez,
	max(ct.mar_poss) mar_poss, max(ct.coc_poss) coc_poss,
	max(ct.othdrug_poss) othdrug_poss, max(ct.mar_sale) mar_sale,
	max(ct.coc_sale) coc_sale, max(ct.othdrug_sale) othdrug_sale,
	max(ct.sex_offense) sex_offense, max(ct.ipv) ipv, max(ct.dui) dui,
	max(ct.drunk_public) drunk_public, max(ct.disorder) disorder,
	max(ct.loiter_prowl) loiter_prowl, max(ct.driving) driving,
	max(ct.harass_stalk) harass_stalk, max(ct.child_sex_offense) child_sex_offense,
	max(ct.speeding) speeding, max(ct.reckless_driving) reckless_driving,
	max(ct.no_license) no_license, max(ct.attempted) any_attempted,
	--
	sum(ct.murder) murder_sum, sum(ct.rape) rape_sum, sum(ct.robbery) robbery_sum,
	sum(ct.assault) assault_sum, sum(ct.burglary) burglary_sum,
	sum(ct.theft) theft_sum, sum(ct.auto_theft) auto_theft_sum,
	sum(ct.fraud) fraud_sum, sum(ct.embez) embez_sum,
	sum(ct.mar_poss) mar_poss_sum, sum(ct.coc_poss) coc_poss_sum,
	sum(ct.othdrug_poss) othdrug_poss_sum, sum(ct.mar_sale) mar_sale_sum,
	sum(ct.coc_sale) coc_sale_sum, sum(ct.othdrug_sale) othdrug_sale_sum,
	sum(ct.sex_offense) sex_offense_sum, sum(ct.ipv) ipv_sum, sum(ct.dui) dui_sum,
	sum(ct.drunk_public) drunk_public_sum, sum(ct.disorder) disorder_sum,
	sum(ct.loiter_prowl) loiter_prowl_sum, sum(ct.driving) driving_sum,
	sum(ct.harass_stalk) harass_stalk_sum, sum(ct.child_sex_offense) child_sex_offense_sum,
	sum(ct.speeding) speeding_sum, sum(ct.reckless_driving) reckless_driving_sum,
	sum(ct.no_license) no_license_sum, sum(ct.attempted) attempted_sum
	FROM mugshots_charges_july2015 AS ct
	WHERE ct.charge IS NOT NULL
	GROUP BY ct.arrest_id