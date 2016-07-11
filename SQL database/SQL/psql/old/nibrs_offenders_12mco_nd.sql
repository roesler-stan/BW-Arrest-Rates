--nibrs_offenders_12mco_nd

COPY
(SELECT
  ot.record_type,
  ot.state_no,
  ot.state,
  ot.ori,
  ot.incident,
  ot.incident_date,
  ot.seqno,
  ot.age,
  ot.gender,
  ot.race,
  ot.number_offenses,
  ot.internal_offender_id,
  ot.offender_ori9,
  ot.offender_county_no,
  ot.offenses_incident,
  ot.offender_ori9,
  ot.ucr_offense,
  ot.attempted
FROM nibrs_offenders_12mc_offense as ot);