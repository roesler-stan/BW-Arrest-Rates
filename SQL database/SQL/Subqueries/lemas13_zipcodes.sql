﻿-- lemas_13_zipcodes
-- This is the averages for zipcodes, using LEMAS agency data
SELECT lc.zipcode lemas_zipcode,
	count(lc.ori9) agency_count,
	-- Agency Info
	-- count(lc.lemas_type) agency_types,
	--basewt, nradjust, finalwt
	-- avg(lc.tribalpd) tribalpd,
	-- Racial and Gender Demographics
	avg(lc.ftsworn) ftsworn, avg(lc.ptsworn) ptsworn,
	avg(lc.ftciv) ftciv, avg(lc.ptciv) ptciv,
	avg(lc.pers_fts_blk) b_officers, avg(lc.pers_fts_wht) w_officers,
	avg(lc.pers_fts_hsp) h_officers, avg(lc.pers_fts_ind) n_officers,
	avg(lc.pers_fts_asn) a_officers, avg(lc.pers_fts_haw) ai_officers,
	avg(lc.pers_fts_two) mult_officers, avg(lc.pers_fts_unk) u_officers,
	avg(lc.pers_fts_racetot) racetot_officers,
	avg(lc.pers_pdsw_mft) male_officers_ft, avg(lc.pers_pdsw_mpt) male_officers_pt,
	avg(lc.pers_pdsw_fft) female_officers_ft, avg(lc.pers_pdsw_fpt) female_officers_pt,	
	-- Budget, forfeiture - total county budget and forfeiture
	avg(lc.bdgt_ttl) bdgt_ttl,
	avg(lc.bdgt_src_mnc) bdgt_src_mnc, avg(lc.bdgt_src_cnty) bdgt_src_cnty,
	avg(lc.bdgt_src_state) bdgt_src_state, avg(lc.bdgt_src_fed) bdgt_src_fed,
	avg(lc.bdgt_src_cont) bdgt_src_cont, avg(lc.bdgt_src_asst) bdgt_src_asst,
	avg(lc.bdgt_src_fee) bdgt_src_fee, avg(lc.bdgt_src_othr) bdgt_src_othr,
	-- Types of pay, e.g. merit-based
	avg(lc.pay_inct_edu) pay_inct_edu, avg(lc.pay_inct_voc) pay_inct_voc,
	avg(lc.pay_inct_lang) pay_inct_lang, avg(lc.pay_inct_spcl) pay_inct_spcl,
	avg(lc.pay_inct_hzrd) pay_inct_hzrd, avg(lc.pay_inct_sd) pay_inct_sd,
	avg(lc.pay_inct_rinc) pay_inct_rinc, avg(lc.pay_inct_mrt) pay_inct_mrt,
	-- Amount Paid - averages
	avg(lc.pay_sal_exc_min) pay_sal_exc_min, avg(lc.pay_sal_exc_max) pay_sal_exc_max,
	avg(lc.pay_sal_sgt_min) pay_sal_sgt_min, avg(lc.pay_sal_sgt_max) pay_sal_sgt_max,
	avg(lc.pay_sal_ofcr_min) pay_sal_ofcr_min, avg(lc.pay_sal_ofcr_max) pay_sal_ofcr_max,
	-- Hiring / Screening Practices
	avg(lc.hir_trn_no_l) hir_trn_no_l, avg(lc.hir_trn_no_p) hir_trn_no_p,
	avg(lc.hir_trn_crs_l) hir_trn_crs_l, avg(lc.hir_trn_crs_p) hir_trn_crs_p,
	avg(lc.hir_trn_fld_l) hir_trn_fld_l, avg(lc.hir_trn_fld_p) hir_trn_fld_p,
	avg(lc.hir_edu_no) hir_edu_no, avg(lc.hir_edu_hs) hir_edu_hs,
	avg(lc.hir_edu_scol) hir_edu_scol, avg(lc.hir_edu_ad) hir_edu_ad,
	avg(lc.hir_edu_bd) hir_edu_bd, avg(lc.hir_mil) hir_mil,
	avg(lc.hir_bd_var) hir_bd_var,
	-- Community Policing
	avg(lc.com_mis) com_mis,
	--avg(lc.com_trn_rec) com_trn_rec, avg(lc.com_trn_insrv) com_trn_insrv,
	avg(lc.com_sara) com_sara,
	avg(lc.com_nsara) com_nsara, avg(lc.com_col) com_col,
	avg(lc.com_ptnr) com_ptnr, avg(lc.com_bt) com_bt,
	avg(lc.com_nbt) com_nbt, avg(lc.com_surv) com_surv,
	-- Technology
	avg(lc.tech_typ_gun) tech_typ_gun, avg(lc.tech_typ_lic) tech_typ_lic,
	avg(lc.tech_typ_vpub) tech_typ_vpub, avg(lc.tech_typ_vveh) tech_typ_vveh,
	avg(lc.tech_typ_vpat) tech_typ_vpat, avg(lc.tech_typ_vwpn) tech_typ_vwpn,
	avg(lc.tech_eac_mrec) tech_eac_mrec, avg(lc.tech_eac_drec) tech_eac_drec,
	avg(lc.tech_eac_crim) tech_eac_crim, avg(lc.tech_eac_warr) tech_eac_warr,
	avg(lc.tech_eac_prot) tech_eac_prot, avg(lc.tech_eac_adrs) tech_eac_adrs,
	avg(lc.tech_crs) tech_crs, avg(lc.tech_cred_sum) tech_cred_sum,
	avg(lc.tech_cred_nar) tech_cred_nar,
	avg(lc.tech_rec_sus) tech_rec_sus,
	avg(lc.tech_who_no) tech_who_no, avg(lc.tech_who_staff) tech_who_staff,
	avg(lc.tech_who_extr) tech_who_extr, avg(lc.tech_many_fts) tech_many_fts,
	avg(lc.tech_many_ftns) tech_many_ftns, avg(lc.tech_out_law) tech_out_law,
	avg(lc.tech_out_gov) tech_out_gov, avg(lc.tech_out_univ) tech_out_univ,
	avg(lc.tech_out_vend) tech_out_vend, avg(lc.tech_out_othr) tech_out_othr,
	avg(lc.tech_web_none) tech_web_none, avg(lc.tech_web_jur) tech_web_jur,
	avg(lc.tech_publ_file) tech_publ_file, avg(lc.tech_media_tw) tech_media_tw,
	avg(lc.tech_media_fb) tech_media_fb, avg(lc.tech_media_ytbe) tech_media_ytbe,
	--avg(lc.safe_finc) safe_finc,
	avg(lc.safe_finc_binary) safe_finc_binary,
	avg(lc.no_record_force) no_record_force, avg(lc.safe_frc_inc) safe_frc_inc,
	avg(lc.safe_frc_offc) safe_frc_offc, avg(lc.safe_fttl) safe_fttl,
	avg(lc.safe_fttl_est) safe_fttl_est, avg(lc.safe_fttl_unk) safe_fttl_unk,
	avg(lc.safe_sepr) safe_sepr, avg(lc.safe_sepr_est) safe_sepr_est,
	avg(lc.safe_sepr_unk) safe_sepr_unk
	FROM lemas_13 as lc
	GROUP BY lc.zipcode