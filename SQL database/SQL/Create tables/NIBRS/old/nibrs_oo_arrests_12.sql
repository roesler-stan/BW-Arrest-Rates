-- Table: nibrs_oo_arrests_12

-- DROP TABLE nibrs_oo_arrests_12;

CREATE TABLE nibrs_oo_arrests_12
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
  attempted character varying,
  arrest_incident character varying,
  arrest_ori character varying,
  arrest_type character varying,
  arrest_offense character varying,
  arrest_date character varying,
  arrest_race character varying,
  arrest_ethnicity character varying,
  number_records double precision,
  disposition_u18 character varying
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_oo_arrests_12
  OWNER TO roesler;

-- Index: ooa_incident_ori

-- DROP INDEX ooa_incident_ori;

CREATE INDEX ooa_incident_ori
  ON nibrs_oo_arrests_12
  USING btree
  (incident COLLATE pg_catalog."default", ori COLLATE pg_catalog."default");