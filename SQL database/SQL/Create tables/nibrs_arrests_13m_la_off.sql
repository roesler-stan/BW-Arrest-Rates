-- Table: nibrs_arrests_13m_la_off

-- DROP TABLE nibrs_arrests_13m_la_off;

CREATE TABLE nibrs_arrests_13m_la_off
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
  lemas_ori7 character varying,
  lemas_ori9 character varying,
  agencyid character varying,
  lemas_type character varying,
  tribalpd character varying,
  countypd character varying,
  bjs_agencyname character varying,
  city character varying,
  statename character varying,
  statecode character varying,
  lemas_zipcode character varying,
  sampletype_final character varying,
  stratcode character varying,
  pers_pdsw_mft double precision,
  pers_pdsw_mpt double precision,
  pers_pdsw_fft double precision,
  pers_pdsw_fpt double precision,
  pers_fts_wht double precision,
  pers_fts_blk double precision,
  pers_fts_hsp double precision,
  pers_fts_ind double precision,
  pers_fts_asn double precision,
  pers_fts_haw double precision,
  pers_fts_two double precision,
  pers_fts_unk double precision,
  pers_fts_racetot double precision,
  pay_sal_exc_min double precision,
  pay_sal_exc_max double precision,
  pay_sal_sgt_min double precision,
  pay_sal_sgt_max double precision,
  pay_sal_ofcr_min double precision,
  pay_sal_ofcr_max double precision,
  pay_inct_edu double precision,
  pay_inct_voc double precision,
  pay_inct_lang double precision,
  pay_inct_spcl double precision,
  pay_inct_hzrd double precision,
  pay_inct_sd double precision,
  pay_inct_rinc double precision,
  pay_inct_mrt double precision,
  hir_trn_no_l double precision,
  hir_trn_no_p double precision,
  hir_trn_crs_l double precision,
  hir_trn_crs_p double precision,
  hir_trn_fld_l double precision,
  hir_trn_fld_p double precision,
  hir_edu_no double precision,
  hir_edu_hs double precision,
  hir_edu_scol double precision,
  hir_edu_ad double precision,
  hir_edu_bd double precision,
  hir_mil double precision,
  hir_bd_var double precision,
  bdgt_mnth character varying,
  bdgt_ttl double precision,
  bdgt_ttl_est double precision,
  bdgt_src_mnc double precision,
  bdgt_src_cnty double precision,
  bdgt_src_state double precision,
  bdgt_src_fed double precision,
  bdgt_src_cont double precision,
  bdgt_src_asst double precision,
  bdgt_src_fee double precision,
  bdgt_src_othr double precision,
  bdgt_src_spec character varying,
  com_mis double precision,
  com_trn_rec character varying,
  com_trn_insrv character varying,
  com_sara double precision,
  com_nsara double precision,
  com_col double precision,
  com_ptnr double precision,
  com_bt double precision,
  com_nbt double precision,
  com_surv double precision,
  tech_typ_gun double precision,
  tech_typ_lic double precision,
  tech_typ_vpub double precision,
  tech_typ_vveh double precision,
  tech_typ_vpat double precision,
  tech_typ_vwpn double precision,
  tech_typ_vothr double precision,
  tech_eac_mrec double precision,
  tech_eac_drec double precision,
  tech_eac_crim double precision,
  tech_eac_warr double precision,
  tech_eac_prot double precision,
  tech_eac_adrs double precision,
  tech_crs double precision,
  tech_cred_sum double precision,
  tech_cred_nar double precision,
  tech_rec_sus double precision,
  tech_who_no double precision,
  tech_who_staff double precision,
  tech_who_extr double precision,
  tech_many_fts double precision,
  tech_many_ftns double precision,
  tech_out_law double precision,
  tech_out_gov double precision,
  tech_out_univ double precision,
  tech_out_vend double precision,
  tech_out_othr double precision,
  tech_web_none double precision,
  tech_web_jur double precision,
  tech_publ_file double precision,
  tech_media_tw double precision,
  tech_media_fb double precision,
  tech_media_ytbe double precision,
  safe_finc character varying,
  no_record_force double precision,
  safe_frc_inc double precision,
  safe_frc_offc double precision,
  safe_fttl double precision,
  safe_fttl_est double precision,
  safe_fttl_unk double precision,
  safe_sepr double precision,
  safe_sepr_est double precision,
  safe_sepr_unk double precision,
  basewt double precision,
  nradjust double precision,
  finalwt double precision,
  ftsworn double precision,
  ptsworn double precision,
  ftciv double precision,
  ptciv double precision,
  safe_finc_binary double precision,
  acs_zipcode double precision,
  total_residents double precision,
  w_residents double precision,
  b_residents double precision,
  i_residents double precision,
  a_residents double precision,
  h_residents double precision,
  o_residents double precision,
  m_residents double precision,
  mi_residents double precision,
  mt_residents double precision,
  b_residents_percent double precision,
  w_residents_percent double precision,
  nonw_residents_percent double precision,
  nonw_residents_percent_sq double precision,
  b_residents_percent_sq double precision,
  w_residents_percent_sq double precision,
  total_gender double precision,
  male_residents double precision,
  total_15_19 double precision,
  male_15_19 double precision,
  total_20_24 double precision,
  male_20_24 double precision,
  percent_male double precision,
  w_total double precision,
  w_male double precision,
  w_male_18_19 double precision,
  w_male_20_24 double precision,
  w_male_18_24 double precision,
  b_total double precision,
  b_male double precision,
  b_male_18_19 double precision,
  b_male_20_24 double precision,
  b_male_18_24 double precision,
  total_inc_households double precision,
  mean_inc double precision,
  binc_125to150 double precision,
  binc_20to25 double precision,
  binc_25to30 double precision,
  binc_60to75 double precision,
  binc_under10 double precision,
  binc_15to20 double precision,
  binc_30to35 double precision,
  binc_40to45 double precision,
  binc_50to60 double precision,
  binc_100to125 double precision,
  binc_200more double precision,
  binc_35to40 double precision,
  binc_75to100 double precision,
  binc_45to50 double precision,
  binc_150to200 double precision,
  binc_households double precision,
  binc_10to15 double precision,
  winc_125to150 double precision,
  winc_20to25 double precision,
  winc_25to30 double precision,
  winc_60to75 double precision,
  winc_under10 double precision,
  winc_15to20 double precision,
  winc_30to35 double precision,
  winc_40to45 double precision,
  winc_50to60 double precision,
  winc_100to125 double precision,
  winc_200more double precision,
  winc_35to40 double precision,
  winc_75to100 double precision,
  winc_45to50 double precision,
  winc_150to200 double precision,
  winc_households double precision,
  winc_10to15 double precision,
  binc_under10_percent double precision,
  binc_under20 double precision,
  binc_under20_percent double precision,
  binc_under40 double precision,
  binc_under40_percent double precision,
  winc_under10_percent double precision,
  winc_under20 double precision,
  winc_under20_percent double precision,
  winc_under40 double precision,
  winc_under40_percent double precision,
  total_unemp double precision,
  one_race_unemp double precision,
  w_unemp double precision,
  b_unemp double precision,
  offenders_zipcode double precision,
  offenders_age double precision,
  offenders_race_known double precision,
  offenders_arson double precision,
  offenders_aggravated_assault double precision,
  offenders_simple_assault double precision,
  offenders_intimidation double precision,
  offenders_assault_general double precision,
  offenders_bribery double precision,
  offenders_burglary double precision,
  offenders_forgery double precision,
  offenders_vandalism double precision,
  offenders_drugs_narcotics double precision,
  offenders_drug_equipment double precision,
  offenders_embezzlement double precision,
  offenders_extortion double precision,
  offenders_false_pretenses double precision,
  offenders_credit_card double precision,
  offenders_impersonation double precision,
  offenders_welfare_fraud double precision,
  offenders_wire_fraud double precision,
  offenders_fraud_general double precision,
  offenders_betting double precision,
  offenders_operating_gambling double precision,
  offenders_gambling_equipment double precision,
  offenders_sports_tampering double precision,
  offenders_gambling_general double precision,
  offenders_murder double precision,
  offenders_negligent_manslaughter double precision,
  offenders_justifiable_homicide double precision,
  offenders_homicide_general double precision,
  offenders_sex_trafficking double precision,
  offenders_labor_trafficking double precision,
  offenders_trafficking_general double precision,
  offenders_kidnapping double precision,
  offenders_pocket_picking double precision,
  offenders_purse_snatching double precision,
  offenders_shoplifting double precision,
  offenders_building_theft double precision,
  offenders_theft_from_machine double precision,
  offenders_theft_from_auto double precision,
  offenders_auto_parts_theft double precision,
  offenders_other_theft double precision,
  offenders_theft_general double precision,
  offenders_auto_theft double precision,
  offenders_pornography double precision,
  offenders_prostitution double precision,
  offenders_prostitution_promotion double precision,
  offenders_prostitution_purchase double precision,
  offenders_prostitution_general double precision,
  offenders_robbery double precision,
  offenders_forcible_rape double precision,
  offenders_forcible_sodomy double precision,
  offenders_rape_object double precision,
  offenders_forcible_fondling double precision,
  offenders_sex_offense_forcible double precision,
  offenders_incest double precision,
  offenders_statutory_rape double precision,
  offenders_sex_offense_nonforcible double precision,
  offenders_stolen_property double precision,
  offenders_weapon double precision,
  offenders_ucr_offense_code_unknown double precision,
  w_offenders_zipcode double precision,
  w_offenders_age double precision,
  w_offenders_race_known double precision,
  w_offenders_arson double precision,
  w_offenders_aggravated_assault double precision,
  w_offenders_simple_assault double precision,
  w_offenders_intimidation double precision,
  w_offenders_assault_general double precision,
  w_offenders_bribery double precision,
  w_offenders_burglary double precision,
  w_offenders_forgery double precision,
  w_offenders_vandalism double precision,
  w_offenders_drugs_narcotics double precision,
  w_offenders_drug_equipment double precision,
  w_offenders_embezzlement double precision,
  w_offenders_extortion double precision,
  w_offenders_false_pretenses double precision,
  w_offenders_credit_card double precision,
  w_offenders_impersonation double precision,
  w_offenders_welfare_fraud double precision,
  w_offenders_wire_fraud double precision,
  w_offenders_fraud_general double precision,
  w_offenders_betting double precision,
  w_offenders_operating_gambling double precision,
  w_offenders_gambling_equipment double precision,
  w_offenders_sports_tampering double precision,
  w_offenders_gambling_general double precision,
  w_offenders_murder double precision,
  w_offenders_negligent_manslaughter double precision,
  w_offenders_justifiable_homicide double precision,
  w_offenders_homicide_general double precision,
  w_offenders_sex_trafficking double precision,
  w_offenders_labor_trafficking double precision,
  w_offenders_trafficking_general double precision,
  w_offenders_kidnapping double precision,
  w_offenders_pocket_picking double precision,
  w_offenders_purse_snatching double precision,
  w_offenders_shoplifting double precision,
  w_offenders_building_theft double precision,
  w_offenders_theft_from_machine double precision,
  w_offenders_theft_from_auto double precision,
  w_offenders_auto_parts_theft double precision,
  w_offenders_other_theft double precision,
  w_offenders_theft_general double precision,
  w_offenders_auto_theft double precision,
  w_offenders_pornography double precision,
  w_offenders_prostitution double precision,
  w_offenders_prostitution_promotion double precision,
  w_offenders_prostitution_purchase double precision,
  w_offenders_prostitution_general double precision,
  w_offenders_robbery double precision,
  w_offenders_forcible_rape double precision,
  w_offenders_forcible_sodomy double precision,
  w_offenders_rape_object double precision,
  w_offenders_forcible_fondling double precision,
  w_offenders_sex_offense_forcible double precision,
  w_offenders_incest double precision,
  w_offenders_statutory_rape double precision,
  w_offenders_sex_offense_nonforcible double precision,
  w_offenders_stolen_property double precision,
  w_offenders_weapon double precision,
  w_offenders_ucr_offense_code_unknown double precision,
  b_offenders_zipcode double precision,
  b_offenders_age double precision,
  b_offenders_race_known double precision,
  b_offenders_arson double precision,
  b_offenders_aggravated_assault double precision,
  b_offenders_simple_assault double precision,
  b_offenders_intimidation double precision,
  b_offenders_assault_general double precision,
  b_offenders_bribery double precision,
  b_offenders_burglary double precision,
  b_offenders_forgery double precision,
  b_offenders_vandalism double precision,
  b_offenders_drugs_narcotics double precision,
  b_offenders_drug_equipment double precision,
  b_offenders_embezzlement double precision,
  b_offenders_extortion double precision,
  b_offenders_false_pretenses double precision,
  b_offenders_credit_card double precision,
  b_offenders_impersonation double precision,
  b_offenders_welfare_fraud double precision,
  b_offenders_wire_fraud double precision,
  b_offenders_fraud_general double precision,
  b_offenders_betting double precision,
  b_offenders_operating_gambling double precision,
  b_offenders_gambling_equipment double precision,
  b_offenders_sports_tampering double precision,
  b_offenders_gambling_general double precision,
  b_offenders_murder double precision,
  b_offenders_negligent_manslaughter double precision,
  b_offenders_justifiable_homicide double precision,
  b_offenders_homicide_general double precision,
  b_offenders_sex_trafficking double precision,
  b_offenders_labor_trafficking double precision,
  b_offenders_trafficking_general double precision,
  b_offenders_kidnapping double precision,
  b_offenders_pocket_picking double precision,
  b_offenders_purse_snatching double precision,
  b_offenders_shoplifting double precision,
  b_offenders_building_theft double precision,
  b_offenders_theft_from_machine double precision,
  b_offenders_theft_from_auto double precision,
  b_offenders_auto_parts_theft double precision,
  b_offenders_other_theft double precision,
  b_offenders_theft_general double precision,
  b_offenders_auto_theft double precision,
  b_offenders_pornography double precision,
  b_offenders_prostitution double precision,
  b_offenders_prostitution_promotion double precision,
  b_offenders_prostitution_purchase double precision,
  b_offenders_prostitution_general double precision,
  b_offenders_robbery double precision,
  b_offenders_forcible_rape double precision,
  b_offenders_forcible_sodomy double precision,
  b_offenders_rape_object double precision,
  b_offenders_forcible_fondling double precision,
  b_offenders_sex_offense_forcible double precision,
  b_offenders_incest double precision,
  b_offenders_statutory_rape double precision,
  b_offenders_sex_offense_nonforcible double precision,
  b_offenders_stolen_property double precision,
  b_offenders_weapon double precision,
  b_offenders_ucr_offense_code_unknown double precision,
  CONSTRAINT nibrs_arrests_13m_la_off_pkey PRIMARY KEY (internal_offender_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_arrests_13m_la_off
  OWNER TO roesler;

-- Index: nibrs_arrests_13m_la_off_idx

-- DROP INDEX nibrs_arrests_13m_la_off_idx;

CREATE INDEX nibrs_arrests_13m_la_off_idx
  ON nibrs_arrests_13m_la_off
  USING btree
  (ori COLLATE pg_catalog."default");