ALTER TABLE nibrs_offenders_arrests_12m ADD COLUMN ori character varying;

UPDATE nibrs_offenders_arrests_12m SET ori = nibrs_offenders_arrests_12m.offender_ori
WHERE nibrs_offenders_arrests_12m.offender_ori IS NOT NULL;

UPDATE nibrs_offenders_arrests_12m SET ori = nibrs_offenders_arrests_12m.arrest_ori
WHERE nibrs_offenders_arrests_12m.arrest_ori IS NOT NULL;