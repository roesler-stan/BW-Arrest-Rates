--nibrs_arrests_12m

DELETE FROM nibrs_arrests_12
WHERE nibrs_arrests_12.race IS NULL OR
nibrs_arrests_12.race ~* 'U' OR
nibrs_arrests_12.ucr_offense IS NULL
OR nibrs_arrests_12.gender ~* 'F'