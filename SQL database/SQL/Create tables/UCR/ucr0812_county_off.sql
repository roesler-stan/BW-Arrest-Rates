-- Table: ucr0812_county_off

-- DROP TABLE ucr0812_county_off;

CREATE TABLE ucr0812_county_off
(
  county_no character varying,
  offense character varying,
  ori_count double precision,
  avg_year double precision,
  state character varying,
  population double precision,
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
ALTER TABLE ucr0812_county_off
  OWNER TO roesler;
