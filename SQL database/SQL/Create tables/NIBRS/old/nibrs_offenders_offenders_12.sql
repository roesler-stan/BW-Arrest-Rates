-- Table: nibrs_offenders_offenses_12

-- DROP TABLE nibrs_offenders_offenses_12;

CREATE TABLE nibrs_offenders_offenses_12
(
  ori character varying,
  incident character varying,
  incident_date character varying,
  age double precision,
  gender character varying,
  race character varying,
  number_offenses double precision,
  internal_offender_id double precision,
  offenses_incident character varying,
  offenses_ori character varying,
  offense character varying,
  attempted character varying
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_offenders_offenses_12
  OWNER TO roesler;
