--nibrs_offenders_12m

DELETE FROM nibrs_offenders_12m
WHERE nibrs_offenders_12m.race IS NULL
OR nibrs_offenders_12m.race ~* 'U'
OR nibrs_offenders_1m.ucr_offense IS NULL
OR nibrs_offenders_12m.gender ~* 'F'