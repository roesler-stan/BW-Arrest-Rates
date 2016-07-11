-- Table: ucr_counties

-- DROP TABLE ucr_counties;

CREATE TABLE ucr_counties
(
  ori_count double precision,
  ucr_county_no character varying,
  ucr_pop double precision,
  b_arrests double precision,
  w_arrests double precision,
  i_arrests double precision,
  a_arrests double precision,
  h_arrests double precision,
  nonh_arrests double precision
)

WITH (
  OIDS=FALSE
);
ALTER TABLE ucr_counties
  OWNER TO roesler;

-- Index: ucr_counties_county_idx

-- DROP INDEX ucr_counties_county_idx;

CREATE INDEX ucr_counties_county_idx
  ON ucr_counties
  USING btree
  (ucr_county_no COLLATE pg_catalog."default");