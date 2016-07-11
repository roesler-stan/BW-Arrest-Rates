UPDATE nibrs_arrests_13m SET pocket_picking = 1, theft_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 231;
UPDATE nibrs_arrests_13m SET purse_snatching = 1, theft_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 232;
UPDATE nibrs_arrests_13m SET shoplifting = 1, theft_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 233;
UPDATE nibrs_arrests_13m SET building_theft = 1, theft_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 234;
UPDATE nibrs_arrests_13m SET theft_from_machine = 1, theft_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 235;
UPDATE nibrs_arrests_13m SET theft_from_auto = 1, theft_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 236;
UPDATE nibrs_arrests_13m SET auto_parts_theft = 1, theft_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 237;
UPDATE nibrs_arrests_13m SET other_theft = 1, theft_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 238;

UPDATE nibrs_arrests_13m SET auto_theft = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 240;

UPDATE nibrs_arrests_13m SET pornography = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 370;

UPDATE nibrs_arrests_13m SET prostitution = 1, prostitution_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 401;
UPDATE nibrs_arrests_13m SET prostitution_promotion = 1, prostitution_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 402;
UPDATE nibrs_arrests_13m SET prostitution_purchase = 1, prostitution_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 403;