--nibrs_oo_arrests_12
--joining offender-offense data to arrest data
--incident is unique within ORI's
--internal_offender_id is unique within offenders_12

SELECT * FROM
(nibrs_offenders_offenses_12
LEFT OUTER JOIN
(SELECT at.incident arrest_incident,
at.ori arrest_ori,
at.arrest_type arrest_type,
at.ucr_offense arrest_offense,
at.arrest_date arrest_date,
at.race arrest_race,
at.ethnicity arrest_ethnicity,
at.number_records number_records,
at.disposition_u18 disposition_u18
FROM nibrs_arrests_12 as at) arrests_table
ON nibrs_offenders_offenses_12.incident = arrests_table.arrest_incident AND nibrs_offenders_offenses_12.ori = arrests_table.arrest_ori)