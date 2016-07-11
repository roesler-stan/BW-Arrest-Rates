CREATE VIEW offenders_view AS
(SELECT
  ot.record_type offender_record_type,
  ot.state_no offender_state_no,
  ot.state offender_state,
  ot.ori offender_ori,
  ot.incident offender_incident,
  ot.incident_date offender_incident_date,
  ot.seqno offender_seqno,
  ot.age offender_age,
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
FROM nibrs_offenders_12mco_nd as ot);