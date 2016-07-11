-- Table: nibrs_ooc_county

-- DROP TABLE nibrs_ooc_county;

CREATE TABLE nibrs_ooc_county
(
  offender_id double precision,
  ori character varying,
  incident character varying,
  date character varying,
  age double precision,
  gender character varying,
  race character varying,
  number_offenses double precision,
  offense_count double precision,
  burglary double precision,
  forgery double precision,
  drugs_narcotics double precision,
  embezzlement double precision,
  murder double precision,
  auto_theft double precision,
  robbery double precision,
  forcible_rape double precision,
  stolen_property double precision,
  assault_general double precision,
  drugs_general double precision,
  fraud_general double precision,
  homicide_general double precision,
  theft_general double precision,
  ori9 character varying,
  county_no character varying
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_ooc_county
  OWNER TO roesler;

-- Index: nibrs_ooc_county_idx

-- DROP INDEX nibrs_ooc_county_idx;

CREATE INDEX nibrs_ooc_county_idx
  ON nibrs_ooc_county
  USING btree
  (county_no COLLATE pg_catalog."default");