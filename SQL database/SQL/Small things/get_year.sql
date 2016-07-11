ALTER TABLE mugshots_may2015_ac_male_1415 ADD COLUMN date_timestamp timestamp without time zone;
UPDATE mugshots_may2015_ac_male_1415 SET date_timestamp = to_timestamp(mugshots_may2015_ac_male_1415.date, 'YYYY-MM-DD HH24:MI:SS');

ALTER TABLE mugshots_may2015_ac_male_1415 ADD COLUMN date_year integer;
ALTER TABLE mugshots_may2015_ac_male_1415 ADD COLUMN date_month integer;

UPDATE mugshots_may2015_ac_male_1415 SET date_year = EXTRACT (YEAR FROM mugshots_may2015_ac_male_1415.date_timestamp);
UPDATE mugshots_may2015_ac_male_1415 SET date_month = EXTRACT (MONTH FROM mugshots_may2015_ac_male_1415.date_timestamp);