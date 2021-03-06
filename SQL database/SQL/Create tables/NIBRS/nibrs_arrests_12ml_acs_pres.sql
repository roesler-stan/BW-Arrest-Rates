﻿-- Table: nibrs_arrests_12ml_acs_pres

-- DROP TABLE nibrs_arrests_12ml_acs_pres;

CREATE TABLE nibrs_arrests_12ml_acs_pres
(
  arrest_type character varying,
  ucr_offense character varying,
  gender character varying,
  state_no character varying,
  seqno character varying,
  age double precision,
  multiple_arrests character varying,
  state character varying,
  record_type character varying,
  incident character varying,
  transaction_number character varying,
  disposition_u18 character varying,
  race character varying,
  ori character varying,
  resident_status character varying,
  number_records double precision,
  ethnicity character varying,
  incident_date character varying,
  arrest_date character varying,
  internal_offender_id double precision NOT NULL,
  ori9 character varying,
  county_no character varying,
  agencyid character varying,
  lemas_type character varying,
  tribalpd character varying,
  countypd character varying,
  bjs_agencyname character varying,
  city character varying,
  statename character varying,
  statecode character varying,
  zipcode double precision,
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
  tech_crec_sum double precision,
  tech_crec_nar double precision,
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
  cw_zipcode double precision,
  acs_state character varying,
  acs_county character varying,
  acs_county_no character varying,
  total_votes double precision,
  rep_votes double precision,
  dem_votes double precision,
  reps_percent_total double precision,
  dems_percent_total double precision,
  third_percent_total double precision,
  reps_percent_majority double precision,
  dems_percent_majority double precision,
  plurality_party character varying,
  CONSTRAINT nibrs_arrests_12ml_acs_pres_pkey PRIMARY KEY (internal_offender_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_arrests_12ml_acs_pres
  OWNER TO roesler;