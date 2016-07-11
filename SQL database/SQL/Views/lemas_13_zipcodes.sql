-- lemas_13_zipcodes
-- This is the averages for zipcodes, using LEMAS agency data
CREATE VIEW lemas_13_zipcodes AS
(SELECT lt.zipcode lemas_zipcode,
	count(lt.agencyid) agency_count,
	-- Agency Info
	-- count(lt.lemas_type) agency_types,
	--basewt, nradjust, finalwt
	-- avg(lt.tribalpd) tribalpd,
	-- Racial and Gender Demographics
	avg(lt.ftsworn) ftsworn, avg(lt.ptsworn) ptsworn,
	avg(lt.ftciv) ftciv, avg(lt.ptciv) ptciv,
	avg(lt.pers_fts_blk) b_officers, avg(lt.pers_fts_wht) w_officers,
	avg(lt.pers_fts_hsp) h_officers, avg(lt.pers_fts_ind) n_officers,
	avg(lt.pers_fts_asn) a_officers, avg(lt.pers_fts_haw) ai_officers,
	avg(lt.pers_fts_two) mult_officers, avg(lt.pers_fts_unk) u_officers,
	avg(lt.pers_fts_racetot) racetot_officers,
	avg(lt.pers_pdsw_mft) male_officers_ft, avg(lt.pers_pdsw_mpt) male_officers_pt,
	avg(lt.pers_pdsw_fft) female_officers_ft, avg(lt.pers_pdsw_fpt) female_officers_pt,	
	-- Budget, forfeiture - total county budget and forfeiture
	avg(lt.bdgt_ttl) bdgt_ttl,
	avg(lt.bdgt_src_mnc) bdgt_src_mnc, avg(lt.bdgt_src_cnty) bdgt_src_cnty,
	avg(lt.bdgt_src_state) bdgt_src_state, avg(lt.bdgt_src_fed) bdgt_src_fed,
	avg(lt.bdgt_src_cont) bdgt_src_cont, avg(lt.bdgt_src_asst) bdgt_src_asst,
	avg(lt.bdgt_src_fee) bdgt_src_fee, avg(lt.bdgt_src_othr) bdgt_src_othr,
	-- Types of pay, e.g. merit-based
	avg(lt.pay_inct_edu) pay_inct_edu, avg(lt.pay_inct_voc) pay_inct_voc,
	avg(lt.pay_inct_lang) pay_inct_lang, avg(lt.pay_inct_spcl) pay_inct_spcl,
	avg(lt.pay_inct_hzrd) pay_inct_hzrd, avg(lt.pay_inct_sd) pay_inct_sd,
	avg(lt.pay_inct_rinc) pay_inct_rinc, avg(lt.pay_inct_mrt) pay_inct_mrt,
	-- Amount Paid - averages
	avg(lt.pay_sal_exc_min) pay_sal_exc_min, avg(lt.pay_sal_exc_max) pay_sal_exc_max,
	avg(lt.pay_sal_sgt_min) pay_sal_sgt_min, avg(lt.pay_sal_sgt_max) pay_sal_sgt_max,
	avg(lt.pay_sal_ofcr_min) pay_sal_ofcr_min, avg(lt.pay_sal_ofcr_max) pay_sal_ofcr_max,
	-- Hiring / Screening Practices
	avg(lt.hir_trn_no_l) hir_trn_no_l, avg(lt.hir_trn_no_p) hir_trn_no_p,
	avg(lt.hir_trn_crs_l) hir_trn_crs_l, avg(lt.hir_trn_crs_p) hir_trn_crs_p,
	avg(lt.hir_trn_fld_l) hir_trn_fld_l, avg(lt.hir_trn_fld_p) hir_trn_fld_p,
	avg(lt.hir_edu_no) hir_edu_no, avg(lt.hir_edu_hs) hir_edu_hs,
	avg(lt.hir_edu_scol) hir_edu_scol, avg(lt.hir_edu_ad) hir_edu_ad,
	avg(lt.hir_edu_bd) hir_edu_bd, avg(lt.hir_mil) hir_mil,
	avg(lt.hir_bd_var) hir_bd_var,
	-- Community Policing
	avg(lt.com_mis) com_mis,
	--avg(lt.com_trn_rec) com_trn_rec, avg(lt.com_trn_insrv) com_trn_insrv,
	avg(lt.com_sara) com_sara,
	avg(lt.com_nsara) com_nsara, avg(lt.com_col) com_col,
	avg(lt.com_ptnr) com_ptnr, avg(lt.com_bt) com_bt,
	avg(lt.com_nbt) com_nbt, avg(lt.com_surv) com_surv,
	-- Technology
	avg(lt.tech_typ_gun) tech_typ_gun, avg(lt.tech_typ_lic) tech_typ_lic,
	avg(lt.tech_typ_vpub) tech_typ_vpub, avg(lt.tech_typ_vveh) tech_typ_vveh,
	avg(lt.tech_typ_vpat) tech_typ_vpat, avg(lt.tech_typ_vwpn) tech_typ_vwpn,
	avg(lt.tech_eac_mrec) tech_eac_mrec, avg(lt.tech_eac_drec) tech_eac_drec,
	avg(lt.tech_eac_crim) tech_eac_crim, avg(lt.tech_eac_warr) tech_eac_warr,
	avg(lt.tech_eac_prot) tech_eac_prot, avg(lt.tech_eac_adrs) tech_eac_adrs,
	avg(lt.tech_crs) tech_crs, avg(lt.tech_crec_sum) tech_crec_sum,
	avg(lt.tech_crec_nar) tech_crec_nar,
	avg(lt.tech_rec_sus) tech_rec_sus,
	avg(lt.tech_who_no) tech_who_no, avg(lt.tech_who_staff) tech_who_staff,
	avg(lt.tech_who_extr) tech_who_extr, avg(lt.tech_many_fts) tech_many_fts,
	avg(lt.tech_many_ftns) tech_many_ftns, avg(lt.tech_out_law) tech_out_law,
	avg(lt.tech_out_gov) tech_out_gov, avg(lt.tech_out_univ) tech_out_univ,
	avg(lt.tech_out_vend) tech_out_vend, avg(lt.tech_out_othr) tech_out_othr,
	avg(lt.tech_web_none) tech_web_none, avg(lt.tech_web_jur) tech_web_jur,
	avg(lt.tech_publ_file) tech_publ_file, avg(lt.tech_media_tw) tech_media_tw,
	avg(lt.tech_media_fb) tech_media_fb, avg(lt.tech_media_ytbe) tech_media_ytbe,
	--avg(lt.safe_finc) safe_finc,
	avg(lt.safe_finc_binary) safe_finc_binary,
	avg(lt.no_record_force) no_record_force, avg(lt.safe_frc_inc) safe_frc_inc,
	avg(lt.safe_frc_offc) safe_frc_offc, avg(lt.safe_fttl) safe_fttl,
	avg(lt.safe_fttl_est) safe_fttl_est, avg(lt.safe_fttl_unk) safe_fttl_unk,
	avg(lt.safe_sepr) safe_sepr, avg(lt.safe_sepr_est) safe_sepr_est,
	avg(lt.safe_sepr_unk) safe_sepr_unk
	FROM lemas_13 as lt
	GROUP BY lt.zipcode);