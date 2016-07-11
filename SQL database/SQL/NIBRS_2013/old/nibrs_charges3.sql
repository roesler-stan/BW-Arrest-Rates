--UPDATE nibrs_arrests_13m SET false_pretenses = 1, fraud_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 261;
--UPDATE nibrs_arrests_13m SET credit_card = 1, fraud_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 262;
--UPDATE nibrs_arrests_13m SET impersonation = 1, fraud_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 263;
UPDATE nibrs_arrests_13m SET welfare_fraud = 1, fraud_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 264;
UPDATE nibrs_arrests_13m SET wire_fraud = 1, fraud_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 265;

UPDATE nibrs_arrests_13m SET betting = 1, gambling_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 391;
UPDATE nibrs_arrests_13m SET operating_gambling = 1, gambling_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 392;
UPDATE nibrs_arrests_13m SET gambling_equipment = 1, gambling_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 393;
UPDATE nibrs_arrests_13m SET sports_tampering = 1, gambling_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 394;

UPDATE nibrs_arrests_13m SET murder = 1, homicide_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 91;
UPDATE nibrs_arrests_13m SET negligent_manslaughter = 1, homicide_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 92;
UPDATE nibrs_arrests_13m SET justifiable_homicide = 1, homicide_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 93;

UPDATE nibrs_arrests_13m SET sex_trafficking = 1, trafficking_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 641;
UPDATE nibrs_arrests_13m SET labor_trafficking = 1, trafficking_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 642;

UPDATE nibrs_arrests_13m SET kidnapping = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 100;