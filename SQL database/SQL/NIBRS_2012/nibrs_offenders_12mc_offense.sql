--nibrs_offenders_12mc_offense
--offender_id is unique within offenders_12, and is later expanded to offender_id - offense rows

SELECT * FROM
nibrs_offenders_12m_county
LEFT OUTER JOIN
(SELECT nibrs_offenses_12.incident offenses_incident,
nibrs_offenses_12.ori offenses_ori,
nibrs_offenses_12.ucr_offense ucr_offense,
nibrs_offenses_12.attempted attempted
FROM nibrs_offenses_12) offenses_table
ON nibrs_offenders_12m_county.incident = offenses_table.offenses_incident AND nibrs_offenders_12m_county.ori = offenses_table.offenses_ori