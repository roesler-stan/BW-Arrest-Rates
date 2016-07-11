-- Code charges for nibrs_offenders_ucr_offenses_12 or nibrs_arrests_13m or nibrs_arrests_13m, part 2

UPDATE nibrs_arrests_13m SET arson = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 200;
UPDATE nibrs_arrests_13m SET aggravated_assault = 1, assault_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 131;
UPDATE nibrs_arrests_13m SET simple_assault = 1, assault_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 132;
UPDATE nibrs_arrests_13m SET intimidation = 1, assault_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 133;

UPDATE nibrs_arrests_13m SET bribery = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 510;
UPDATE nibrs_arrests_13m SET burglary = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 220;
UPDATE nibrs_arrests_13m SET forgery = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 250;
UPDATE nibrs_arrests_13m SET vandalism = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 290;

UPDATE nibrs_arrests_13m SET drugs_narcotics = 1, drugs_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 351;
UPDATE nibrs_arrests_13m SET drug_equipment = 1, drugs_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 352;

UPDATE nibrs_arrests_13m SET embezzlement = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 270;
UPDATE nibrs_arrests_13m SET extortion = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 210;