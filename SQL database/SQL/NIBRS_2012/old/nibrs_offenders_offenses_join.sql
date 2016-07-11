--nibrs_offenders_offenses_12
--joining offense data to offender data
--incident is unique within ORI's
--offender_id is unique within offenders_12, and is later expanded to offender_id - offense rows

SELECT * FROM
((SELECT
  offenders.ori,
  offenders.incident,
  offenders.incident_date,
  offenders.age,
  offenders.gender,
  offenders.race,
  offenders.number_offenses,
  offenders.internal_offender_id
FROM nibrs_offenders_12 as offenders) offenders_table
LEFT OUTER JOIN
(SELECT nibrs_offenses_12.incident offenses_incident,
nibrs_offenses_12.ori offenses_ori,
nibrs_offenses_12.ucr_offense offense,
nibrs_offenses_12.attempted attempted
FROM nibrs_offenses_12) offenses_table
ON offenders_table.incident = offenses_table.offenses_incident AND offenders_table.ori = offenses_table.offenses_ori)