-- Table: nibrs_offenders_12mc_offense

-- DROP TABLE nibrs_offenders_12mc_offense;

CREATE TABLE nibrs_offenders_12mc_offense
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
ALTER TABLE nibrs_offenders_12mc_offense
  OWNER TO roesler;

-- Index: nibrs_oo_idx

-- DROP INDEX nibrs_oo_idx;

CREATE INDEX nibrs_oo_idx
  ON nibrs_offenders_12mc_offense
  USING btree
  (offender_county_no COLLATE pg_catalog."default");