UPDATE nibrs_arrests_13m SET robbery = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 120;

UPDATE nibrs_arrests_13m SET forcible_rape = 1, sex_offense_forcible = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 111;
UPDATE nibrs_arrests_13m SET forcible_sodomy = 1, sex_offense_forcible = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 112;
UPDATE nibrs_arrests_13m SET rape_object = 1, sex_offense_forcible = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 113;
UPDATE nibrs_arrests_13m SET forcible_fondling = 1, sex_offense_forcible = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 114;

UPDATE nibrs_arrests_13m SET incest = 1, sex_offense_nonforcible = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 361;
UPDATE nibrs_arrests_13m SET statutory_rape = 1, sex_offense_nonforcible = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 362;

UPDATE nibrs_arrests_13m SET stolen_property = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 280;

UPDATE nibrs_arrests_13m SET weapon = 1 WHERE nibrs_arrests_13m.ucr_offense_code = 520;

UPDATE nibrs_arrests_13m SET ucr_offense_code_unknown = 1 WHERE nibrs_arrests_13m.ucr_offense_code < 0;