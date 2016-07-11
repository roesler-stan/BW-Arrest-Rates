-- Table: lemas_13_counties

-- DROP TABLE lemas_13_counties;

CREATE TABLE lemas_13_counties
(
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
-- Budget
bdgt_ttl double precision,
 bdgt_src_mnc double precision,
 bdgt_src_cnty double precision,
 bdgt_src_state double precision,
 bdgt_src_fed double precision,
 bdgt_src_cont double precision,
 bdgt_src_asst double precision,
 bdgt_src_fee double precision,
 bdgt_src_othr double precision,
-- Types of pay double precision, e.g. merit-based
 pay_inct_edu double precision,
 pay_inct_voc double precision,
 pay_inct_lang double precision,
 pay_inct_spcl double precision,
 pay_inct_hzrd double precision,
 pay_inct_sd double precision,
 pay_inct_rinc double precision,
 pay_inct_mrt double precision,
-- Amount Paid - averages
 pay_sal_exc_min double precision,
 pay_sal_exc_max double precision,
 pay_sal_sgt_min double precision,
 pay_sal_sgt_max double precision,
 pay_sal_ofcr_min double precision,
 pay_sal_ofcr_max double precision,
-- Hiring / Screening Practices
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
-- Community Policing
 com_mis double precision,
--com_trn_rec com_trn_rec double precision,
--com_trn_insrv double precision,
 com_sara double precision,
 com_nsara double precision,
 com_col double precision,
 com_ptnr double precision,
 com_bt double precision,
 com_nbt double precision,
 com_surv double precision,
-- Technology
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
--safe_finc safe_finc double precision,
 safe_finc_binary double precision,
 no_record_force double precision,
 safe_frc_inc double precision,
 safe_frc_offc double precision,
 safe_fttl double precision,
 safe_fttl_est double precision,
 safe_fttl_unk double precision,
 safe_sepr double precision,
 safe_sepr_est double precision,
 safe_sepr_unk double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE lemas_13_counties
  OWNER TO roesler;

-- Index: lemas13_countoes_idx

-- DROP INDEX lemas13_countoes_idx;

CREATE INDEX lemas13_countoes_idx
  ON lemas_13_counties
  USING btree
  (lemas_county_no COLLATE pg_catalog."default");