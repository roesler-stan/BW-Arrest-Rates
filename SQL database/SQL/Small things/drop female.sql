--DELETE FROM nibrs_offenders_offenses_12 WHERE nibrs_offenders_offenses_12.gender ~* 'F';
--DELETE FROM nibrs_arrests_12 WHERE nibrs_arrests_12.gender ~* 'F';

DELETE FROM nibrs_arrests_12_male WHERE nibrs_arrests_12_male.gender ~* 'F';