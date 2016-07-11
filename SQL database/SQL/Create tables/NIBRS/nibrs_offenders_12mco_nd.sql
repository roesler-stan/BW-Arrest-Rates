-- Table: nibrs_offenders_12mco_nd

-- DROP TABLE nibrs_offenders_12mco_nd;

CREATE TABLE nibrs_offenders_12mco_nd
(
  record_type character varying,
  state_no character varying,
  state character varying,
  ori character varying,
  incident character varying,
  incident_date character varying,
  seqno double precision,
  age double precision,
  gender character varying,
  race character varying,
  number_offenses double precision,
  internal_offender_id double precision NOT NULL,
  offender_ori9 character varying,
  offender_county_no character varying,
  offenses_incident character varying,
  offenses_ori character varying,
  ucr_offense character varying,
  attempted character varying
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_offenders_12mco_nd
  OWNER TO roesler;

-- Index: nibrs_oori_idx

-- DROP INDEX nibrs_oori_idx;

CREATE INDEX nibrs_oori_idx
  ON nibrs_offenders_12mco_nd
  USING btree
  (ori COLLATE pg_catalog."default");

CREATE INDEX nibrs_oincident_idx
  ON nibrs_offenders_12mco_nd
  USING btree
  (incident COLLATE pg_catalog."default");