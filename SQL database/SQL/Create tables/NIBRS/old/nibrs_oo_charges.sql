-- Table: nibrs_oo_charges

-- DROP TABLE nibrs_oo_charges;

CREATE TABLE nibrs_oo_charges
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
  theft_general double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_oo_charges
  OWNER TO roesler;

-- Index: nibrs_ooc_ori_idx

-- DROP INDEX nibrs_ooc_ori_idx;

CREATE INDEX nibrs_ooc_ori_idx
  ON nibrs_oo_charges
  USING btree
  (ori COLLATE pg_catalog."default");