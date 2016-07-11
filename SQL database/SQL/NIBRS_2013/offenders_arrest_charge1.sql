-- Code charges for nibrs_offenders_arrestees_13_lemas_acs_pres12

UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_arson = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 200 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 200 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 200;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_aggravated_assault = 1, arrest_assault_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 131 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 131 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 131;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_simple_assault = 1, arrest_assault_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 132 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 132 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 132;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_intimidation = 1, arrest_assault_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 133 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 133 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 133;

UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_bribery = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 510 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 510 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 510;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_burglary = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 220 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 220 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 220;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_forgery = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 250 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 250 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 250;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_vandalism = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 290 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 290 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 290;

UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_drugs_narcotics = 1, arrest_drugs_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 351 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 351 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 351;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_drug_equipment = 1, arrest_drugs_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 352 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 352 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 352;

UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_embezzlement = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 270 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 270 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 270;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_extortion = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 210 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 210 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 210;

UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_false_pretenses = 1, arrest_fraud_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 261 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 261 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 261;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_credit_card = 1, arrest_fraud_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 262 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 262 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 262;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_impersonation = 1, arrest_fraud_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 263 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 263 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 263;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_welfare_fraud = 1, arrest_fraud_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 264 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 264 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 264;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_wire_fraud = 1, arrest_fraud_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 265 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 265 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 265;

UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_betting = 1, arrest_gambling_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 391 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 391 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 391;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_operating_gambling = 1, arrest_gambling_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 392 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 392 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 392;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_gambling_equipment = 1, arrest_gambling_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 393 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 393 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 393;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_sports_tampering = 1, arrest_gambling_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 394 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 394 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 394;

UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_murder = 1, arrest_homicide_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 91 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 91 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 91;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_negligent_manslaughter = 1, arrest_homicide_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 92 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 92 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 92;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_justifiable_homicide = 1, arrest_homicide_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 93 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 93 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 93;

UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_sex_trafficking = 1, arrest_trafficking_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 641 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 641 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 641;
UPDATE nibrs_offenders_arrestees_13_lemas_acs_pres12 SET arrest_labor_trafficking = 1, arrest_trafficking_general = 1 WHERE nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code1 = 642 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code2 = 642 or nibrs_offenders_arrestees_13_lemas_acs_pres12.ucr_arrest_offense_code3 = 642;