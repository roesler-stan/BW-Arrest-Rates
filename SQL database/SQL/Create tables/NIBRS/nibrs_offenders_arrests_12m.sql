--small, without charge dummies
-- Table: nibrs_offenders_arrests_12m

-- DROP TABLE nibrs_offenders_arrests_12m;

CREATE TABLE nibrs_offenders_arrests_12m
(
  offender_record_type character varying,
  offender_state_no character varying,
  offender_state character varying,
  offender_ori character varying,
  offender_incident character varying,
  offender_incident_date character varying,
  offender_seqno double precision,
  offender_age double precision,
  offender_gender character varying,
  offender_race character varying,
  offender_number_offenses double precision,
  offender_internal_offender_id double precision NOT NULL,
  offender_offender_ori9 character varying,
  offender_county_no character varying,
  offender_offenses_incident character varying,
  offender_ori9 character varying,
  offender_ucr_offense character varying,
  offender_attempted character varying,
  arrest_type character varying,
  arrest_ucr_offense character varying,
  arrest_gender character varying,
  arrest_state_no character varying,
  arrest_seqno character varying,
  arrest_age double precision,
  arrest_multiple_arrests character varying,
  arrest_state character varying,
  arrest_record_type character varying,
  arrest_incident character varying,
  arrest_transaction_number character varying,
  arrest_disposition_u18 character varying,
  arrest_race character varying,
  arrest_ori character varying,
  arrest_resident_status character varying,
  arrest_number_records double precision,
  arrest_ethnicity character varying,
  arrest_incident_date character varying,
  arrest_date character varying,
  arrest_internal_offender_id double precision,
  arrest_ori9 character varying,
  arrest_county_no character varying
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_offenders_arrests_12m
  OWNER TO roesler;
