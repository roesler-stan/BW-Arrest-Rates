ALTER TABLE charges_m1 DROP COLUMN ucr_charge;

ALTER TABLE charges_m1
	DROP COLUMN mar_poss,
	DROP COLUMN coc_poss, DROP COLUMN othdrug_poss,
	DROP COLUMN drug_poss,
	DROP COLUMN mar_sale, DROP COLUMN coc_sale,
	DROP COLUMN othdrug_sale, DROP COLUMN drug_sale,
	DROP COLUMN drugs,
	DROP COLUMN prost_only, DROP COLUMN prost_pimp, DROP COLUMN prost_traf,
	DROP COLUMN any_prost, DROP COLUMN ipv,
	DROP COLUMN dui, DROP COLUMN drunk_public, DROP COLUMN disorder,
	DROP COLUMN vagrancy, DROP COLUMN suspicion, DROP COLUMN loiter,
	DROP COLUMN parole_probat;