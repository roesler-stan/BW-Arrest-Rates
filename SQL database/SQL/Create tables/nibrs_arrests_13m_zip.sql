﻿-- Table: nibrs_arrests_13m_zip

-- DROP TABLE nibrs_arrests_13m_zip;

CREATE TABLE nibrs_arrests_13m_zip
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
  arson integer DEFAULT 0,
  aggravated_assault integer DEFAULT 0,
  simple_assault integer DEFAULT 0,
  intimidation integer DEFAULT 0,
  bribery integer DEFAULT 0,
  burglary integer DEFAULT 0,
  forgery integer DEFAULT 0,
  vandalism integer DEFAULT 0,
  drugs_narcotics integer DEFAULT 0,
  drug_equipment integer DEFAULT 0,
  embezzlement integer DEFAULT 0,
  extortion integer DEFAULT 0,
  false_pretenses integer DEFAULT 0,
  credit_card integer DEFAULT 0,
  impersonation integer DEFAULT 0,
  welfare_fraud integer DEFAULT 0,
  wire_fraud integer DEFAULT 0,
  betting integer DEFAULT 0,
  operating_gambling integer DEFAULT 0,
  gambling_equipment integer DEFAULT 0,
  sports_tampering integer DEFAULT 0,
  murder integer DEFAULT 0,
  negligent_manslaughter integer DEFAULT 0,
  justifiable_homicide integer DEFAULT 0,
  sex_trafficking integer DEFAULT 0,
  labor_trafficking integer DEFAULT 0,
  kidnapping integer DEFAULT 0,
  pocket_picking integer DEFAULT 0,
  purse_snatching integer DEFAULT 0,
  shoplifting integer DEFAULT 0,
  building_theft integer DEFAULT 0,
  theft_from_machine integer DEFAULT 0,
  theft_from_auto integer DEFAULT 0,
  auto_parts_theft integer DEFAULT 0,
  other_theft integer DEFAULT 0,
  auto_theft integer DEFAULT 0,
  pornography integer DEFAULT 0,
  prostitution integer DEFAULT 0,
  prostitution_promotion integer DEFAULT 0,
  prostitution_purchase integer DEFAULT 0,
  robbery integer DEFAULT 0,
  forcible_rape integer DEFAULT 0,
  forcible_sodomy integer DEFAULT 0,
  rape_object integer DEFAULT 0,
  forcible_fondling integer DEFAULT 0,
  incest integer DEFAULT 0,
  statutory_rape integer DEFAULT 0,
  stolen_property integer DEFAULT 0,
  weapon integer DEFAULT 0,
  assault_general integer DEFAULT 0,
  drugs_general integer DEFAULT 0,
  fraud_general integer DEFAULT 0,
  gambling_general integer DEFAULT 0,
  homicide_general integer DEFAULT 0,
  trafficking_general integer DEFAULT 0,
  theft_general integer DEFAULT 0,
  prostitution_general integer DEFAULT 0,
  sex_offense_forcible integer DEFAULT 0,
  sex_offense_nonforcible integer DEFAULT 0,
  bad_check integer DEFAULT 0,
  loitering integer DEFAULT 0,
  disorder integer DEFAULT 0,
  dui integer DEFAULT 0,
  drunk integer DEFAULT 0,
  family_nonv integer DEFAULT 0,
  liquor_law integer DEFAULT 0,
  peeping_tom integer DEFAULT 0,
  runaway integer DEFAULT 0,
  trespass integer DEFAULT 0,
  other_offense integer DEFAULT 0,
  ucr_offense_code_unknown integer DEFAULT 0,
  ori9 character varying,
  zipcode double precision,
  CONSTRAINT nibrs_arrests_13mz_pkey PRIMARY KEY (internal_offender_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_arrests_13m_zip
  OWNER TO roesler;

-- Index: nibrs_arrests_13mz_ori_idx

-- DROP INDEX nibrs_arrests_13mz_ori_idx;

CREATE INDEX nibrs_arrests_13mz_ori_idx
  ON nibrs_arrests_13m_zip
  USING btree
  (ori COLLATE pg_catalog."default");