﻿-- Table: mugshots_july2015_male_acs_rpl_naois

-- DROP TABLE mugshots_july2015_male_acs_rpl_naois;

CREATE TABLE mugshots_july2015_male_acs_rpl_naois
(
  scraping_arrest_id integer,
  county character varying,
  state character varying,
  county_no character varying,
  name character varying,
  download_date timestamp without time zone,
  all_charges character varying,
  age double precision,
  gender character varying,
  zipcode double precision,
  date timestamp without time zone,
  birthday timestamp without time zone,
  race character varying,
  multi double precision,
  am_ind double precision,
  hispanic double precision,
  east_asian double precision,
  asian double precision,
  black double precision,
  white double precision,
  address character varying,
  page_views character varying,
  views_per_day double precision,
  views double precision,
  views_days double precision,
  views_date timestamp without time zone,
  multi_race_whisp double precision,
  multi_race_nohisp double precision,
  white_only double precision,
  am_ind_only double precision,
  asian_only double precision,
  east_asian_only double precision,
  hispanic_only double precision,
  black_only double precision,
  white_only_ighisp double precision,
  am_ind_only_ighisp double precision,
  asian_only_ighisp double precision,
  east_asian_only_ighisp double precision,
  black_only_ighisp double precision,
  black_not_white double precision,
  black_not_other_known double precision,
  racial_minority double precision,
  arrest_id character varying NOT NULL,
  date_year integer,
  date_month integer,
  charges_arrest_id character varying,
  charge_string_count integer,
  charge_coded_count integer,
  any_charge_coded integer,
  murder integer,
  rape integer,
  robbery integer,
  assault integer,
  burglary integer,
  theft integer,
  auto_theft integer,
  fraud integer,
  embez integer,
  mar_poss integer,
  coc_poss integer,
  othdrug_poss integer,
  mar_sale integer,
  coc_sale integer,
  othdrug_sale integer,
  sex_offense integer,
  ipv integer,
  dui integer,
  drunk_public integer,
  disorder integer,
  loiter_prowl integer,
  driving integer,
  harass_stalk integer,
  child_sex_offense integer,
  speeding integer,
  reckless_driving integer,
  no_license integer,
  any_attempted integer,
  murder_sum integer,
  rape_sum integer,
  robbery_sum integer,
  assault_sum integer,
  burglary_sum integer,
  theft_sum integer,
  auto_theft_sum integer,
  fraud_sum integer,
  embez_sum integer,
  mar_poss_sum integer,
  coc_poss_sum integer,
  othdrug_poss_sum integer,
  mar_sale_sum integer,
  coc_sale_sum integer,
  othdrug_sale_sum integer,
  sex_offense_sum integer,
  ipv_sum integer,
  dui_sum integer,
  drunk_public_sum integer,
  disorder_sum integer,
  loiter_prowl_sum integer,
  driving_sum integer,
  harass_stalk_sum integer,
  child_sex_offense_sum integer,
  speeding_sum integer,
  reckless_driving_sum integer,
  no_license_sum integer,
  attempted_sum integer,
  acs_county_no character varying,
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
  arrests_county_no character varying,
  arrests_age double precision,
  arrests_race_known double precision,
  arrests_burglary double precision,
  arrests_forgery double precision,
  arrests_drugs_narcotics double precision,
  arrests_embezzlement double precision,
  arrests_murder double precision,
  arrests_auto_theft double precision,
  arrests_robbery double precision,
  arrests_forcible_rape double precision,
  arrests_stolen_property double precision,
  arrests_assault_general double precision,
  arrests_drugs_general double precision,
  arrests_fraud_general double precision,
  arrests_homicide_general double precision,
  arrests_theft_general double precision,
  arrests_bad_check double precision,
  arrests_loitering double precision,
  arrests_disorder double precision,
  arrests_dui double precision,
  arrests_drunk double precision,
  arrests_family_nonv double precision,
  arrests_liquor_law double precision,
  arrests_peeping_tom double precision,
  arrests_runaway double precision,
  arrests_trespass double precision,
  arrests_other_offense double precision,
  w_arrests_county_no character varying,
  w_arrests_age double precision,
  w_arrests double precision,
  w_arrests_burglary double precision,
  w_arrests_forgery double precision,
  w_arrests_drugs_narcotics double precision,
  w_arrests_embezzlement double precision,
  w_arrests_murder double precision,
  w_arrests_auto_theft double precision,
  w_arrests_robbery double precision,
  w_arrests_forcible_rape double precision,
  w_arrests_stolen_property double precision,
  w_arrests_assault_general double precision,
  w_arrests_drugs_general double precision,
  w_arrests_fraud_general double precision,
  w_arrests_homicide_general double precision,
  w_arrests_theft_general double precision,
  w_arrests_bad_check double precision,
  w_arrests_loitering double precision,
  w_arrests_disorder double precision,
  w_arrests_dui double precision,
  w_arrests_drunk double precision,
  w_arrests_family_nonv double precision,
  w_arrests_liquor_law double precision,
  w_arrests_peeping_tom double precision,
  w_arrests_runaway double precision,
  w_arrests_trespass double precision,
  w_arrests_other_offense double precision,
  b_arrests_county_no character varying,
  b_arrests_age double precision,
  b_arrests double precision,
  b_arrests_burglary double precision,
  b_arrests_forgery double precision,
  b_arrests_drugs_narcotics double precision,
  b_arrests_embezzlement double precision,
  b_arrests_murder double precision,
  b_arrests_auto_theft double precision,
  b_arrests_robbery double precision,
  b_arrests_forcible_rape double precision,
  b_arrests_stolen_property double precision,
  b_arrests_assault_general double precision,
  b_arrests_drugs_general double precision,
  b_arrests_fraud_general double precision,
  b_arrests_homicide_general double precision,
  b_arrests_theft_general double precision,
  b_arrests_bad_check double precision,
  b_arrests_loitering double precision,
  b_arrests_disorder double precision,
  b_arrests_dui double precision,
  b_arrests_drunk double precision,
  b_arrests_family_nonv double precision,
  b_arrests_liquor_law double precision,
  b_arrests_peeping_tom double precision,
  b_arrests_runaway double precision,
  b_arrests_trespass double precision,
  b_arrests_other_offense double precision,
  offenders_county_no character varying,
  offenders_age double precision,
  offenders_race_known double precision,
  offenders_burglary double precision,
  offenders_forgery double precision,
  offenders_drugs_narcotics double precision,
  offenders_embezzlement double precision,
  offenders_murder double precision,
  offenders_auto_theft double precision,
  offenders_robbery double precision,
  offenders_forcible_rape double precision,
  offenders_stolen_property double precision,
  offenders_assault_general double precision,
  offenders_drugs_general double precision,
  offenders_fraud_general double precision,
  offenders_homicide_general double precision,
  offenders_theft_general double precision,
  w_offenders_county_no character varying,
  w_offenders_age double precision,
  w_offenders double precision,
  w_offenders_burglary double precision,
  w_offenders_forgery double precision,
  w_offenders_drugs_narcotics double precision,
  w_offenders_embezzlement double precision,
  w_offenders_murder double precision,
  w_offenders_auto_theft double precision,
  w_offenders_robbery double precision,
  w_offenders_forcible_rape double precision,
  w_offenders_stolen_property double precision,
  w_offenders_assault_general double precision,
  w_offenders_drugs_general double precision,
  w_offenders_fraud_general double precision,
  w_offenders_homicide_general double precision,
  w_offenders_theft_general double precision,
  b_offenders_county_no character varying,
  b_offenders_age double precision,
  b_offenders double precision,
  b_offenders_burglary double precision,
  b_offenders_forgery double precision,
  b_offenders_drugs_narcotics double precision,
  b_offenders_embezzlement double precision,
  b_offenders_murder double precision,
  b_offenders_auto_theft double precision,
  b_offenders_robbery double precision,
  b_offenders_forcible_rape double precision,
  b_offenders_stolen_property double precision,
  b_offenders_assault_general double precision,
  b_offenders_drugs_general double precision,
  b_offenders_fraud_general double precision,
  b_offenders_homicide_general double precision,
  b_offenders_theft_general double precision,
  county_no15 character varying,
  id_count15 double precision,
  id_count14p double precision,
  id_count13p double precision,
  acs_state character varying,
  cw_county_no2 character varying,
  CONSTRAINT mugshots_july2015_male_acs_rpl_naois_pkey PRIMARY KEY (arrest_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE mugshots_july2015_male_acs_rpl_naois
  OWNER TO roesler;