ALTER TABLE arrests ADD COLUMN race_int integer;
--UPDATE charges SET coc_not_mj = NULL

UPDATE arrests SET race_int = 1
	WHERE arrests.race LIKE 'white';

UPDATE arrests SET race_int = 2
	WHERE arrests.race LIKE 'black';