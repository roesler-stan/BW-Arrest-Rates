-- Table: ucr0812_ori_off

-- DROP TABLE ucr0812_ori_off;

CREATE TABLE ucr0812_ori_off
(
  ori character varying,
  offense character varying,
  avg_year double precision,
  county_no character varying,
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
ALTER TABLE ucr0812_ori_off
  OWNER TO roesler;
