UPDATE nibrs_arrests_13m SET auto_theft = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 240 or nibrs_arrests_13m.ucr_offense_code1 = 240 or nibrs_arrests_13m.ucr_offense_code2 = 240 or nibrs_arrests_13m.ucr_offense_code3 = 240;

UPDATE nibrs_arrests_13m SET pornography = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 370 or nibrs_arrests_13m.ucr_offense_code1 = 370 or nibrs_arrests_13m.ucr_offense_code2 = 370 or nibrs_arrests_13m.ucr_offense_code3 = 370;

UPDATE nibrs_arrests_13m SET prostitution = 1, prostitution_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 401 or nibrs_arrests_13m.ucr_offense_code1 = 401 or nibrs_arrests_13m.ucr_offense_code2 = 401 or nibrs_arrests_13m.ucr_offense_code3 = 401;
UPDATE nibrs_arrests_13m SET prostitution_promotion = 1, prostitution_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 402 or nibrs_arrests_13m.ucr_offense_code1 = 402 or nibrs_arrests_13m.ucr_offense_code2 = 402 or nibrs_arrests_13m.ucr_offense_code3 = 402;
UPDATE nibrs_arrests_13m SET prostitution_purchase = 1, prostitution_general = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 403 or nibrs_arrests_13m.ucr_offense_code1 = 403 or nibrs_arrests_13m.ucr_offense_code2 = 403 or nibrs_arrests_13m.ucr_offense_code3 = 403;

UPDATE nibrs_arrests_13m SET robbery = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 120 or nibrs_arrests_13m.ucr_offense_code1 = 120 or nibrs_arrests_13m.ucr_offense_code2 = 120 or nibrs_arrests_13m.ucr_offense_code3 = 120;

UPDATE nibrs_arrests_13m SET forcible_rape = 1, sex_offense_forcible = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 111 or nibrs_arrests_13m.ucr_offense_code1 = 111 or nibrs_arrests_13m.ucr_offense_code2 = 111 or nibrs_arrests_13m.ucr_offense_code3 = 111;
UPDATE nibrs_arrests_13m SET forcible_sodomy = 1, sex_offense_forcible = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 112 or nibrs_arrests_13m.ucr_offense_code1 = 112 or nibrs_arrests_13m.ucr_offense_code2 = 112 or nibrs_arrests_13m.ucr_offense_code3 = 112;
UPDATE nibrs_arrests_13m SET rape_object = 1, sex_offense_forcible = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 113 or nibrs_arrests_13m.ucr_offense_code1 = 113 or nibrs_arrests_13m.ucr_offense_code2 = 113 or nibrs_arrests_13m.ucr_offense_code3 = 113;
UPDATE nibrs_arrests_13m SET forcible_fondling = 1, sex_offense_forcible = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 114 or nibrs_arrests_13m.ucr_offense_code1 = 114 or nibrs_arrests_13m.ucr_offense_code2 = 114 or nibrs_arrests_13m.ucr_offense_code3 = 114;

UPDATE nibrs_arrests_13m SET incest = 1, sex_offense_nonforcible = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 361 or nibrs_arrests_13m.ucr_offense_code1 = 361 or nibrs_arrests_13m.ucr_offense_code2 = 361 or nibrs_arrests_13m.ucr_offense_code3 = 361;
UPDATE nibrs_arrests_13m SET statutory_rape = 1, sex_offense_nonforcible = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 362 or nibrs_arrests_13m.ucr_offense_code1 = 362 or nibrs_arrests_13m.ucr_offense_code2 = 362 or nibrs_arrests_13m.ucr_offense_code3 = 362;

UPDATE nibrs_arrests_13m SET stolen_property = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 280 or nibrs_arrests_13m.ucr_offense_code1 = 280 or nibrs_arrests_13m.ucr_offense_code2 = 280 or nibrs_arrests_13m.ucr_offense_code3 = 280;

UPDATE nibrs_arrests_13m SET weapon = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 520 or nibrs_arrests_13m.ucr_offense_code1 = 520 or nibrs_arrests_13m.ucr_offense_code2 = 520 or nibrs_arrests_13m.ucr_offense_code3 = 520;

UPDATE nibrs_arrests_13m SET ucr_offense_code_unknown = 1 WHERE nibrs_arrests_13m.ucr_offense_code < 0;