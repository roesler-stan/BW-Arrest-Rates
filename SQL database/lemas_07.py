import sqlalchemy as sa

conn = sa.create_engine('postgresql://roesler:break_free15@mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com:5432/Mugshots', echo=False)
conn.connect()

metadata = sa.MetaData()

lemas_07 = sa.Table('lemas_07', metadata,
    sa.Column('zipcode', sa.String()), sa.Column('population', sa.Float), 
    sa.Column('csllea04_id', sa.Float), sa.Column('swnauthemp', sa.Float), 
    sa.Column('swnftemp', sa.Float), sa.Column('swnptemp', sa.Float), 
    sa.Column('civftemp', sa.Float),sa.Column('civptemp', sa.Float), 
    sa.Column('ftgangoff', sa.Float), sa.Column('ptgangoff', sa.Float), 
    sa.Column('ftdrugoff', sa.Float), sa.Column('ptdrugoff', sa.Float), 
    sa.Column('numpatr', sa.Float), sa.Column('numinvst', sa.Float), 
    sa.Column('white', sa.Float), sa.Column('black', sa.Float), 
    sa.Column('hispanic', sa.Float), sa.Column('asian', sa.Float), 
    sa.Column('nathaw', sa.Float), sa.Column('amerind', sa.Float), 
    sa.Column('multrace', sa.Float), sa.Column('unkrace', sa.Float), 
    sa.Column('male', sa.Float), sa.Column('female', sa.Float), 
    sa.Column('totgender', sa.Float), sa.Column('opbudget', sa.Float), 
    sa.Column('opbudgest', sa.Float), sa.Column('drugforf', sa.Float), 
    sa.Column('gambforf', sa.Float), sa.Column('othrforf', sa.Float), 
    sa.Column('asforest', sa.Float), sa.Column('totacad', sa.Float), 
    sa.Column('totfield', sa.Float), sa.Column('totinsrv', sa.Float), 
    sa.Column('chiefmin', sa.Float), sa.Column('chiefmax', sa.Float), 
    sa.Column('sgtmin', sa.Float), sa.Column('sgtmax', sa.Float), 
    sa.Column('entrymin', sa.Float), sa.Column('entrymax', sa.Float), 
    sa.Column('nummrkcars', sa.Float), sa.Column('numumkcars', sa.Float), 
    sa.Column('numcarcam', sa.Float), sa.Column('numuofsust', sa.Float),
    sa.Column('numuofoth', sa.Float), sa.Column('numuofpend', sa.Float), 
    sa.Column('numuoftot', sa.Float), sa.Column('impbudget', sa.Float), 
    sa.Column('impcarcam', sa.Float), sa.Column('impgender', sa.Float), 
    sa.Column('imprace', sa.Float), sa.Column('educpay', sa.Float), 
    sa.Column('cptrnnew', sa.Float), sa.Column('cptrninserv', sa.Float), 
    sa.Column('cpmission', sa.Float),
    sa.Column('cpacademy', sa.Float), sa.Column('cpplan', sa.Float), 
    sa.Column('cppartner', sa.Float), sa.Column('cpsurvey', sa.Float), 
    sa.Column('cpunit', sa.Float), sa.Column('cpnone', sa.Float), 
    sa.Column('writaptest', sa.Float), sa.Column('voicestress', sa.Float), 
    sa.Column('anprobsolv', sa.Float), sa.Column('cultdiv', sa.Float), 
    sa.Column('confmgt', sa.Float), sa.Column('psycheval', sa.Float), 
    sa.Column('polyexam', sa.Float), sa.Column('perstest', sa.Float), 
    sa.Column('intervw', sa.Float), sa.Column('drivhis', sa.Float), 
    sa.Column('mineduc', sa.Float), sa.Column('edreqexm', sa.Float), 
    sa.Column('backgrnd', sa.Float), sa.Column('credhis', sa.Float), 
    sa.Column('crimhis', sa.Float), sa.Column('seclang', sa.Float), 
    sa.Column('volhis', sa.Float), sa.Column('drugtest', sa.Float), 
    sa.Column('medexam', sa.Float), sa.Column('phystest', sa.Float), 
    sa.Column('hazardpay', sa.Float), sa.Column('meritpay', sa.Float), 
    sa.Column('shiftpay', sa.Float), sa.Column('skillpay', sa.Float), 
    sa.Column('langpay', sa.Float), 
    sa.Column('tuitionpay', sa.Float), sa.Column('milpay', sa.Float), 
    sa.Column('collbarg', sa.Float), sa.Column('respay', sa.Float), 
    sa.Column('ccrb', sa.Float), sa.Column('ccrbpowers', sa.Float), 
    sa.Column('outsideinv', sa.Float), sa.Column('agcytype', sa.Float), 
    sa.Column('agency', sa.String()), sa.Column('ori', sa.String()), 
    sa.Column('state', sa.String()), sa.Column('city', sa.String()), 
    sa.Column('earlywarn', sa.Float), sa.Column('deadforcplcy', sa.Float), 
    sa.Column('lessthanplcy', sa.Float), sa.Column('codecondplcy', sa.Float), 
    sa.Column('offdemplplcy', sa.Float), sa.Column('maxhoursplcy', sa.Float), 
    sa.Column('offdcondplcy', sa.Float), sa.Column('mediaplcy', sa.Float), 
    sa.Column('eapplcy', sa.Float), sa.Column('mentillplcy', sa.Float), 
    sa.Column('homelessplcy', sa.Float), sa.Column('domdispplcy', sa.Float), 
    sa.Column('juvenileplcy', sa.Float), sa.Column('limitengplcy', sa.Float), 
    sa.Column('incusdthplcy', sa.Float), sa.Column('racialprplcy', sa.Float), 
    sa.Column('citcompplcy', sa.Float), sa.Column('immstatplcy', sa.Float)
)

metadata.create_all(conn)


# In[8]:

conn = sa.create_engine('postgresql://roesler:break_free15@mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com:5432/Mugshots', echo=False)
conn.connect()

metadata = sa.MetaData()

lemas_13 = sa.Table('lemas_13', metadata,
    sa.Column('ori7', sa.String()), sa.Column('ori9', sa.String()), 
    sa.Column('agencyid', sa.String()), sa.Column('lemas_type', sa.String()), 
    sa.Column('tribalpd', sa.String()), sa.Column('countypd', sa.String()),
    sa.Column('bjs_agencyname', sa.String()), sa.Column('city', sa.String()),
    sa.Column('statename', sa.String()), sa.Column('statecode', sa.String()),
    sa.Column('zipcode', sa.String()), sa.Column('sampletype_final', sa.String()),
    sa.Column('stratcode', sa.String()),
    sa.Column('pers_pdsw_mft', sa.Float), sa.Column('pers_pdsw_mpt', sa.Float),
    sa.Column('pers_pdsw_fft', sa.Float), sa.Column('pers_pdsw_fpt', sa.Float),
    sa.Column('pers_fts_wht', sa.Float), sa.Column('pers_fts_blk', sa.Float),
    sa.Column('pers_fts_hsp', sa.Float), sa.Column('pers_fts_ind', sa.Float),
    sa.Column('pers_fts_asn', sa.Float), sa.Column('pers_fts_haw', sa.Float),
    sa.Column('pers_fts_two', sa.Float), sa.Column('pers_fts_unk', sa.Float),
    sa.Column('pers_fts_racetot', sa.Float), sa.Column('pay_sal_exc_min', sa.Float),
    sa.Column('pay_sal_exc_max', sa.Float), sa.Column('pay_sal_sgt_min', sa.Float),
    sa.Column('pay_sal_sgt_max', sa.Float), sa.Column('pay_sal_ofcr_min', sa.Float),
    sa.Column('pay_sal_ofcr_max', sa.Float),
    sa.Column('pay_inct_edu', sa.Float),
    sa.Column('pay_inct_voc', sa.Float), sa.Column('pay_inct_lang', sa.Float),
    sa.Column('pay_inct_spcl', sa.Float), sa.Column('pay_inct_hzrd', sa.Float),
    sa.Column('pay_inct_sd', sa.Float), sa.Column('pay_inct_rinc', sa.Float),
    sa.Column('pay_inct_mrt', sa.Float), sa.Column('hir_trn_no_l', sa.Float),
    sa.Column('hir_trn_no_p', sa.Float), sa.Column('hir_trn_crs_l', sa.Float),
    sa.Column('hir_trn_crs_p', sa.Float), sa.Column('hir_trn_fld_l', sa.Float),
    sa.Column('hir_trn_fld_p', sa.Float), sa.Column('hir_edu_no', sa.Float),
    sa.Column('hir_edu_hs', sa.Float), sa.Column('hir_edu_scol', sa.Float),
    sa.Column('hir_edu_ad', sa.Float), sa.Column('hir_edu_bd', sa.Float),
    sa.Column('hir_mil', sa.Float), sa.Column('hir_bd_var', sa.Float),
    sa.Column('bdgt_mnth', sa.String()), sa.Column('bdgt_ttl', sa.Float),
    sa.Column('bdgt_ttl_est', sa.Float), sa.Column('bdgt_src_mnc', sa.Float),
    sa.Column('bdgt_src_cnty', sa.Float), sa.Column('bdgt_src_state', sa.Float),
    sa.Column('bdgt_src_fed', sa.Float), sa.Column('bdgt_src_cont', sa.Float),
    sa.Column('bdgt_src_asst', sa.Float), sa.Column('bdgt_src_fee', sa.Float),
    sa.Column('bdgt_src_othr', sa.Float), sa.Column('bdgt_src_spec', sa.String()),
    sa.Column('com_mis', sa.Float), sa.Column('com_trn_rec', sa.String()),
    sa.Column('com_trn_insrv', sa.String()), sa.Column('com_sara', sa.Float),
    sa.Column('com_nsara', sa.Float), sa.Column('com_col', sa.Float),
    sa.Column('com_ptnr', sa.Float), sa.Column('com_bt', sa.Float),
    sa.Column('com_nbt', sa.Float), sa.Column('com_surv', sa.Float),
    sa.Column('tech_typ_gun', sa.Float), sa.Column('tech_typ_lic', sa.Float),
    sa.Column('tech_typ_vpub', sa.Float), sa.Column('tech_typ_vveh', sa.Float),
    sa.Column('tech_typ_vpat', sa.Float), sa.Column('tech_typ_vwpn', sa.Float),
    sa.Column('tech_typ_vothr', sa.Float), sa.Column('tech_eac_mrec', sa.Float),
    sa.Column('tech_eac_drec', sa.Float), sa.Column('tech_eac_crim', sa.Float),
    sa.Column('tech_eac_warr', sa.Float), sa.Column('tech_eac_prot', sa.Float),
    sa.Column('tech_eac_adrs', sa.Float), sa.Column('tech_crs', sa.Float),
    sa.Column('tech_cred_sum', sa.Float), sa.Column('tech_cred_nar', sa.Float),
    sa.Column('tech_rec_sus', sa.Float), sa.Column('tech_who_no', sa.Float),
    sa.Column('tech_who_staff', sa.Float), sa.Column('tech_who_extr', sa.Float),
    sa.Column('tech_many_fts', sa.Float), sa.Column('tech_many_ftns', sa.Float),
    sa.Column('tech_out_law', sa.Float), sa.Column('tech_out_gov', sa.Float),
    sa.Column('tech_out_univ', sa.Float), sa.Column('tech_out_vend', sa.Float),
    sa.Column('tech_out_othr', sa.Float), sa.Column('tech_web_none', sa.Float),
    sa.Column('tech_web_jur', sa.Float), sa.Column('tech_publ_file', sa.Float),
    sa.Column('tech_media_tw', sa.Float), sa.Column('tech_media_fb', sa.Float),
    sa.Column('tech_media_ytbe', sa.Float), sa.Column('safe_finc', sa.String()),
    sa.Column('no_record_force', sa.Float), sa.Column('safe_frc_inc', sa.Float),
    sa.Column('safe_frc_offc', sa.Float), sa.Column('safe_fttl', sa.Float),
    sa.Column('safe_fttl_est', sa.Float), sa.Column('safe_fttl_unk', sa.Float),
    sa.Column('safe_sepr', sa.Float), sa.Column('safe_sepr_est', sa.Float),
    sa.Column('safe_sepr_unk', sa.Float), sa.Column('basewt', sa.Float),
    sa.Column('nradjust', sa.Float), sa.Column('finalwt', sa.Float),
    sa.Column('ftsworn', sa.Float), sa.Column('ptsworn', sa.Float),
    sa.Column('ftciv', sa.Float), sa.Column('ptciv', sa.Float),
    sa.Column('safe_finc_binary', sa.Float)
)

metadata.create_all(conn)