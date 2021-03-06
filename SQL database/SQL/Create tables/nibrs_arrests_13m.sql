﻿-- Table: nibrs_arrests_13m

-- DROP TABLE nibrs_arrests_13m;

CREATE TABLE nibrs_arrests_13m
(
  agency_indicator double precision,
  recsarr double precision,
  resident_status double precision,
  pop_group double precision,
  record_type character varying,
  ucr_offense_code double precision,
  disposition_u18 double precision,
  multiple_arrests double precision,
  recsofs double precision,
  recsofr double precision,
  state_no double precision,
  state character varying,
  fips_county3 double precision,
  fips_county2 double precision,
  fips_county1 double precision,
  covered_ori character varying,
  ethnicity character varying,
  fips_county5 double precision,
  fips_county4 double precision,
  recsadm double precision,
  arrest_seqno double precision,
  recsvic double precision,
  core_city double precision,
  country_division double precision,
  months_reported double precision,
  arrest_type double precision,
  incident character varying,
  ori character varying,
  city_name character varying,
  ucr_county4 double precision,
  ucr_county5 double precision,
  ucr_county2 double precision,
  ucr_county3 double precision,
  ucr_county1 double precision,
  recsprp double precision,
  gender character varying,
  region double precision,
  ucr_offense_code3 double precision,
  transaction_number character varying,
  race character varying,
  ucr_offense_code1 double precision,
  attempted2 double precision,
  attempted3 double precision,
  attempted1 double precision,
  ucr_offense_code2 double precision,
  fips_county1_digits double precision,
  fips_county1_no double precision,
  fips_county2_digits double precision,
  fips_county2_no double precision,
  fips_county3_digits double precision,
  fips_county3_no double precision,
  fips_county4_digits double precision,
  fips_county4_no double precision,
  fips_county5_digits double precision,
  fips_county5_no double precision,
  incident_date character varying,
  arrest_date character varying,
  age double precision,
  number_records double precision,
  internal_offender_id double precision NOT NULL,
  CONSTRAINT nibrs_arrests_13m_pkey PRIMARY KEY (internal_offender_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_arrests_13m
  OWNER TO roesler;