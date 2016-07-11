--nibrs_12mc_offenders_arrestees - small, without charge dummies

SELECT * FROM
(SELECT
  ot.record_type offender_record_type,
  ot.state_no offender_state_no,
  ot.state offender_state,
  ot.ori offender_ori,
  ot.incident offender_incident,
  ot.incident_date offender_incident_date,
  ot.seqno,
  ot.age,
  ot.gender offender_gender,
  ot.race offender_race,
  ot.number_offenses offender_number_offenses,
  ot.internal_offender_id offender_internal_offender_id,
  ot.offender_ori9 offender_offender_ori9,
  ot.offender_county_no offender_county_no,
  ot.offenses_incident offender_offenses_incident,
  ot.offender_ori9 offender_ori9,
  ot.ucr_offense offender_ucr_offense,
  ot.attempted offender_attempted
FROM nibrs_offenders_12mc_offense as ot) offenders
FULL OUTER JOIN
(SELECT 
  at.arrest_type arrest_type,
  at.ucr_offense arrest_ucr_offense,
  at.gender arrest_gender,
  at.state_no arrest_state_no,
  at.seqno arrest_seqno,
  at.age arrest_age,
  at.multiple_arrests arrest_multiple_arrests,
  at.state arrest_state,
  at.record_type arrest_record_type,
  at.incident arrest_incident,
  at.transaction_number arrest_transaction_number,
  at.disposition_u18 arrest_disposition_u18,
  at.race arrest_race,
  at.ori arrest_ori,
  at.resident_status arrest_resident_status,
  at.number_records arrest_number_records,
  at.ethnicity arrest_ethnicity,
  at.incident_date arrest_incident_date,
  at.arrest_date arrest_date,
  at.internal_offender_id arrest_internal_offender_id,
  at.ori9 arrest_ori9,
  at.county_no arrest_county_no
FROM nibrs_arrests_12m_county as at) arrests
ON offenders.offender_incident = arrests.arrest_incident AND offenders.offender_ori = arrests.arrest_ori