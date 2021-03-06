-- Table: nibrs_offenders_arrestees_13_lemas_acs

-- DROP TABLE nibrs_offenders_arrestees_13_lemas_acs;

CREATE TABLE nibrs_offenders_arrestees_13_lemas_acs
(
  arrest_date2 character varying,
  arrest_date3 character varying,
  arrest_date1 character varying,
  record_type character varying,
  arrest_transaction3 character varying,
  recsarr double precision,
  arrest_transaction2 character varying,
  fips_county5_digits double precision,
  fips_county1 double precision,
  arrest_type2 double precision,
  arrest_type3 double precision,
  arrest_type1 double precision,
  arrest_date character varying,
  recsvic double precision,
  arrest_seqno3 double precision,
  arrest_seqno2 double precision,
  arrest_seqno1 double precision,
  fips_county4 double precision,
  offender_seqno1 double precision,
  offender_seqno3 double precision,
  offender_seqno2 double precision,
  arrest_transaction1 character varying,
  ucr_county4 double precision,
  ucr_county5 double precision,
  ucr_county2 double precision,
  ucr_county3 double precision,
  ucr_county1 double precision,
  recsprp double precision,
  gender character varying,  
  fips_county3_no double precision,
  race character varying,
  fips_county2_no double precision,
  allofns character varying,
  fips_county3 double precision,
  fips_county2 double precision,
  state character varying,
  fips_county5 double precision,
  internal_offender_id double precision,
  arrestee_disposition_u18_1 double precision,
  arrestee_disposition_u18_3 double precision,
  arrestee_disposition_u18_2 double precision,
  fips_county4_no double precision,
  incident character varying,
  ori character varying,
  arrestee_gender1 character varying,
  arrestee_gender3 character varying,
  arrestee_gender2 character varying,
  arrestee_race3 character varying,
  arrestee_race2 character varying,
  arrestee_race1 character varying,
  arrestee_resident_status2 double precision,
  arrestee_resident_status3 double precision,
  arrestee_resident_status1 double precision,
  number_records double precision,
  multiple_arrests1 double precision,
  multiple_arrests2 double precision,
  multiple_arrests3 double precision,
  arrestee_age3 double precision,
  fips_county5_no double precision,
  pop_group double precision,
  fips_county4_digits double precision,
  recsofs double precision,
  recsofr double precision,
  fips_county3_digits double precision,
  state_no double precision,
  offense_segments double precision,
  core_city double precision,
  arrestee_ethnicity2 character varying,
  arrestee_ethnicity3 character varying,
  arrestee_ethnicity1 character varying,
  region double precision,
  agency_indicator double precision,
  fips_county2_digits double precision,
  ethnicity character varying,
  incident_date character varying,
  fips_county1_no double precision,
  offender_seqno double precision,
  arrest_seqno double precision,
  covered_ori character varying,
  recsadm double precision,
  country_division double precision,
  fips_county1_digits double precision,
  arrestee_age2 double precision,
  months_reported double precision,
  arrestee_age1 double precision,
  city_name character varying,
  ucr_arrest_offense_code1 double precision,
  ucr_arrest_offense_code3 double precision,
  ucr_arrest_offense_code2 double precision,
  ucr_offense_code1 double precision,
  age double precision,
  ucr_offense_code3 double precision,
  ucr_offense_code2 double precision,
  transaction_number character varying,
  attempted2 double precision,
  attempted3 double precision,
  attempted1 double precision,
  cw_ori9 character varying,
  zipcode double precision,
  lemas_ori7 character varying,
  lemas_ori9 character varying,
  agencyid character varying,
  lemas_type character varying,
  tribalpd character varying,
  countypd character varying,
  bjs_agencyname character varying,
  lemas_city character varying,
  lemas_statename character varying,
  lemas_statecode character varying,
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
  b_unemp double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_offenders_arrestees_13_lemas_acs
  OWNER TO roesler;