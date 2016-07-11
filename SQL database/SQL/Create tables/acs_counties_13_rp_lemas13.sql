﻿-- Table: acs_counties_13_rp_lemas13

-- DROP TABLE acs_counties_13_rp_lemas13;

CREATE TABLE acs_counties_13_rp_lemas13
(
  acs_county_no character varying NOT NULL,
  total_residents double precision,
  w_residents double precision,
  b_residents double precision,
  i_residents double precision,
  a_residents double precision,
  h_residents double precision,
  o_residents double precision,
  m_residents double precision,
  mi_residents double precision,
  mno_residents double precision,
  b_residents_percent double precision,
  w_residents_percent double precision,
  bw_residents_pdiff double precision,
  bw_residents_ratio double precision,
  nonw_residents_percent double precision,
  nonw_residents_percent_sq double precision,
  b_residents_percent_sq double precision,
  w_residents_percent_sq double precision,
  bw_residents_percent double precision,
  prop_residents_wnotb double precision,
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
  ai_total double precision,
  ai_male double precision,
  ai_male_18_19 double precision,
  ai_male_20_24 double precision,
  ai_male_18_24 double precision,
  a_total double precision,
  a_male double precision,
  a_male_18_19 double precision,
  a_male_20_24 double precision,
  a_male_18_24 double precision,
  hw_total double precision,
  hw_male double precision,
  hw_male_18_19 double precision,
  hw_male_20_24 double precision,
  hw_male_18_24 double precision,
  o_total double precision,
  o_male double precision,
  o_male_18_19 double precision,
  o_male_20_24 double precision,
  o_male_18_24 double precision,
  unemployed double precision,
  inc_households double precision,
  under10 double precision,
  under10_percent double precision,
  inc_10to15 double precision,
  inc_10to15_percent double precision,
  inc_15to25 double precision,
  inc_15to25_percent double precision,
  inc_25to35 double precision,
  inc_25to35_percent double precision,
  inc_35to50 double precision,
  inc_35to50_percent double precision,
  inc_50to75 double precision,
  inc_50to75_percent double precision,
  inc_75to100 double precision,
  inc_75to100_percent double precision,
  inc_100to150 double precision,
  inc_100to150_percent double precision,
  inc_150to200 double precision,
  inc_150to200_percent double precision,
  inc_200more double precision,
  inc_200more_percent double precision,
  inc_median double precision,
  inc_mean double precision,
  b_inc_total double precision,
  b_inc_under10 double precision,
  b_inc_10to15 double precision,
  b_inc_15to20 double precision,
  b_inc_20to25 double precision,
  b_inc_25to30 double precision,
  b_inc_30to35 double precision,
  b_inc_35to40 double precision,
  b_inc_40to45 double precision,
  b_inc_45to50 double precision,
  b_inc_50to60 double precision,
  b_inc_60to75 double precision,
  b_inc_75to100 double precision,
  b_inc_100to125 double precision,
  b_inc_125to150 double precision,
  b_inc_150to200 double precision,
  b_inc_200more double precision,
  w_inc_total double precision,
  w_inc_under10 double precision,
  w_inc_10to15 double precision,
  w_inc_15to20 double precision,
  w_inc_20to25 double precision,
  w_inc_25to30 double precision,
  w_inc_30to35 double precision,
  w_inc_35to40 double precision,
  w_inc_40to45 double precision,
  w_inc_45to50 double precision,
  w_inc_50to60 double precision,
  w_inc_60to75 double precision,
  w_inc_75to100 double precision,
  w_inc_100to125 double precision,
  w_inc_125to150 double precision,
  w_inc_150to200 double precision,
  w_inc_200more double precision,
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
  bwinc_under40_pdiff double precision,
  bwinc_under20_pdiff double precision,
  ginc_total double precision,
  male_inc double precision,
  male_inc_alone double precision,
  female_inc double precision,
  female_inc_alone double precision,
  total_unemp double precision,
  one_race_unemp double precision,
  w_unemp double precision,
  b_unemp double precision,
  male_worked_ft double precision,
  w_male_empdata double precision,
  w_male_worked_ft double precision,
  w_m_unemp_ft double precision,
  b_male_empdata double precision,
  b_male_worked_ft double precision,
  b_m_unemp_ft double precision,
  cw_county_no character varying,
  region double precision,
  total_votes double precision,
  rep_votes double precision,
  dem_votes double precision,
  reps_percent_total double precision,
  dems_percent_total double precision,
  third_percent_total double precision,
  other_percent_total double precision,
  reps_percent_majority double precision,
  dems_percent_majority double precision,
  plurality_party character varying,
  lemas_county_no character varying,
  agency_count double precision,
  ftsworn double precision,
  ptsworn double precision,
  ftciv double precision,
  ptciv double precision,
  b_officers double precision,
  w_officers double precision,
  h_officers double precision,
  n_officers double precision,
  a_officers double precision,
  ai_officers double precision,
  mult_officers double precision,
  u_officers double precision,
  racetot_officers double precision,
  male_officers_ft double precision,
  male_officers_pt double precision,
  female_officers_ft double precision,
  female_officers_pt double precision,
  bdgt_ttl double precision,
  bdgt_src_mnc double precision,
  bdgt_src_cnty double precision,
  bdgt_src_state double precision,
  bdgt_src_fed double precision,
  bdgt_src_cont double precision,
  bdgt_src_asst double precision,
  bdgt_src_fee double precision,
  bdgt_src_othr double precision,
  pay_inct_edu double precision,
  pay_inct_voc double precision,
  pay_inct_lang double precision,
  pay_inct_spcl double precision,
  pay_inct_hzrd double precision,
  pay_inct_sd double precision,
  pay_inct_rinc double precision,
  pay_inct_mrt double precision,
  pay_sal_exc_min double precision,
  pay_sal_exc_max double precision,
  pay_sal_sgt_min double precision,
  pay_sal_sgt_max double precision,
  pay_sal_ofcr_min double precision,
  pay_sal_ofcr_max double precision,
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
  com_mis double precision,
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
  safe_finc_binary double precision,
  no_record_force double precision,
  safe_frc_inc double precision,
  safe_frc_offc double precision,
  safe_fttl double precision,
  safe_fttl_est double precision,
  safe_fttl_unk double precision,
  safe_sepr double precision,
  safe_sepr_est double precision,
  safe_sepr_unk double precision,
  CONSTRAINT acs_counties_rpl_13_pkey PRIMARY KEY (acs_county_no)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE acs_counties_13_rp_lemas13
  OWNER TO roesler;