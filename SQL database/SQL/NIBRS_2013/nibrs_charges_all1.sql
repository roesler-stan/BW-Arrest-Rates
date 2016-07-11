-- Code charges for nibrs_arrests_13m

UPDATE nibrs_arrests_13m SET arson = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 200 or nibrs_arrests_13m.ucr_offense_code1 = 200 or nibrs_arrests_13m.ucr_offense_code2 = 200 or nibrs_arrests_13m.ucr_offense_code3 = 200;
UPDATE nibrs_arrests_13m SET aggravated_assault = 1, assault_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 131 or nibrs_arrests_13m.ucr_offense_code1 = 131 or nibrs_arrests_13m.ucr_offense_code2 = 131 or nibrs_arrests_13m.ucr_offense_code3 = 131;
UPDATE nibrs_arrests_13m SET simple_assault = 1, assault_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 132 or nibrs_arrests_13m.ucr_offense_code1 = 132 or nibrs_arrests_13m.ucr_offense_code2 = 132 or nibrs_arrests_13m.ucr_offense_code3 = 132;
UPDATE nibrs_arrests_13m SET intimidation = 1, assault_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 133 or nibrs_arrests_13m.ucr_offense_code1 = 133 or nibrs_arrests_13m.ucr_offense_code2 = 133 or nibrs_arrests_13m.ucr_offense_code3 = 133;

UPDATE nibrs_arrests_13m SET bribery = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 510 or nibrs_arrests_13m.ucr_offense_code1 = 510 or nibrs_arrests_13m.ucr_offense_code2 = 510 or nibrs_arrests_13m.ucr_offense_code3 = 510;
UPDATE nibrs_arrests_13m SET burglary = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 220 or nibrs_arrests_13m.ucr_offense_code1 = 220 or nibrs_arrests_13m.ucr_offense_code2 = 220 or nibrs_arrests_13m.ucr_offense_code3 = 220;
UPDATE nibrs_arrests_13m SET forgery = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 250 or nibrs_arrests_13m.ucr_offense_code1 = 250 or nibrs_arrests_13m.ucr_offense_code2 = 250 or nibrs_arrests_13m.ucr_offense_code3 = 250;
UPDATE nibrs_arrests_13m SET vandalism = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 290 or nibrs_arrests_13m.ucr_offense_code1 = 290 or nibrs_arrests_13m.ucr_offense_code2 = 290 or nibrs_arrests_13m.ucr_offense_code3 = 290;

UPDATE nibrs_arrests_13m SET drugs_narcotics = 1, drugs_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 351 or nibrs_arrests_13m.ucr_offense_code1 = 351 or nibrs_arrests_13m.ucr_offense_code2 = 351 or nibrs_arrests_13m.ucr_offense_code3 = 351;
UPDATE nibrs_arrests_13m SET drug_equipment = 1, drugs_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 352 or nibrs_arrests_13m.ucr_offense_code1 = 352 or nibrs_arrests_13m.ucr_offense_code2 = 352 or nibrs_arrests_13m.ucr_offense_code3 = 352;

UPDATE nibrs_arrests_13m SET embezzlement = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 270 or nibrs_arrests_13m.ucr_offense_code1 = 270 or nibrs_arrests_13m.ucr_offense_code2 = 270 or nibrs_arrests_13m.ucr_offense_code3 = 270;
UPDATE nibrs_arrests_13m SET extortion = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 210 or nibrs_arrests_13m.ucr_offense_code1 = 210 or nibrs_arrests_13m.ucr_offense_code2 = 210 or nibrs_arrests_13m.ucr_offense_code3 = 210;

UPDATE nibrs_arrests_13m SET false_pretenses = 1, fraud_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 261 or nibrs_arrests_13m.ucr_offense_code1 = 261 or nibrs_arrests_13m.ucr_offense_code2 = 261 or nibrs_arrests_13m.ucr_offense_code3 = 261;
UPDATE nibrs_arrests_13m SET credit_card = 1, fraud_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 262 or nibrs_arrests_13m.ucr_offense_code1 = 262 or nibrs_arrests_13m.ucr_offense_code2 = 262 or nibrs_arrests_13m.ucr_offense_code3 = 262;
UPDATE nibrs_arrests_13m SET impersonation = 1, fraud_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 263 or nibrs_arrests_13m.ucr_offense_code1 = 263 or nibrs_arrests_13m.ucr_offense_code2 = 263 or nibrs_arrests_13m.ucr_offense_code3 = 263;
UPDATE nibrs_arrests_13m SET welfare_fraud = 1, fraud_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 264 or nibrs_arrests_13m.ucr_offense_code1 = 264 or nibrs_arrests_13m.ucr_offense_code2 = 264 or nibrs_arrests_13m.ucr_offense_code3 = 264;
UPDATE nibrs_arrests_13m SET wire_fraud = 1, fraud_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 265 or nibrs_arrests_13m.ucr_offense_code1 = 265 or nibrs_arrests_13m.ucr_offense_code2 = 265 or nibrs_arrests_13m.ucr_offense_code3 = 265;