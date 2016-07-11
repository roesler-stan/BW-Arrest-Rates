-- lemas_07_counties
-- This is the averages for counties, using LEMAS agency data
SELECT crosswalk.county_no lemas_county_no,
	count(lemas_07.lemas_ori) agency_count,
	-- Agency Info
	count(lemas_07.agcytype) agcytype_count,
	-- Weights, Imputation
	-- avg(lemas_07.finalwt_page1) finalwt_page1, avg(lemas_07.finalwt_page2on) finalwt_page2on,
	-- max(lemas_07.formtype) formtype,
	avg(lemas_07.impbudget) impbudget, avg(lemas_07.impcarcam) impcarcam,
	avg(lemas_07.impgender) impgender, avg(lemas_07.imprace) imprace,
	-- Average agency population (not sure meaningful)
	--avg(lemas_07.population) lemas_07_pop,
	-- Number and Types of Officers
	avg(lemas_07.swnauthemp) swnauthemp,
	avg(lemas_07.swnftemp) swnftemp,
	avg(lemas_07.ftgangoff) ftgangoff, avg(lemas_07.ptgangoff) ptgangoff,
	avg(lemas_07.ftdrugoff) drugs_ft, avg(lemas_07.ptdrugoff) drugs_pt,
	-- Racial and Gender Demographics
	avg(lemas_07.black) b_officers, avg(lemas_07.white) w_officers,
	avg(lemas_07.hispanic) h_officers, avg(lemas_07.asian) a_officers,
	avg(lemas_07.nathaw) n_officers, avg(lemas_07.amerind) ai_officers,
	avg(lemas_07.multrace) mult_officers, avg(lemas_07.unkrace) u_officers,
	avg(lemas_07.male) male_officers, avg(lemas_07.female) female_officers,
	avg(lemas_07.totgender) totgender,
	-- Budget, forfeiture - total county budget and forfeiture
	--vars ending in "est" is whether it's an est
	avg(lemas_07.opbudget) opbudget, avg(lemas_07.opbudgest) opbudgest,
	avg(lemas_07.drugforf) drugforf, avg(lemas_07.gambforf) gambforf,
	avg(lemas_07.othrforf) othrforf, avg(lemas_07.asforest) asforest,
	-- Requirements for becoming officer - average to get % counties with policy
	avg(lemas_07.mineduc) mineduc, avg(lemas_07.edreqexm) edreqexm,
	avg(lemas_07.backgrnd) backgrnd, avg(lemas_07.credhis) credhis,
	avg(lemas_07.crimhis) crimhis, avg(lemas_07.drivhis) drivhis,
	avg(lemas_07.intervw) intervw, avg(lemas_07.perstest) perstest,
	avg(lemas_07.polyexam) polyexam, avg(lemas_07.psycheval) psycheval,
	avg(lemas_07.voicestress) voicestress, avg(lemas_07.writaptest) writaptest,
	avg(lemas_07.anprobsolv) anprobsolv, avg(lemas_07.cultdiv) cultdiv,
	avg(lemas_07.confmgt) confmgt, avg(lemas_07.seclang) seclang,
	avg(lemas_07.volhis) volhis, avg(lemas_07.drugtest) drugtest,
	avg(lemas_07.medexam) medexam, avg(lemas_07.phystest) phystest,
	avg(lemas_07.totacad) totacad, avg(lemas_07.totfield) totfield,
	avg(lemas_07.totinsrv) totinsrv,
	-- Bilingual support
	-- avg(lemas_07.swnbiling) swnbiling,
	--avg(lemas_07.civbiling) civbiling, avg(lemas_07.swninterp) swninterp,
	--avg(lemas_07.civinterp) civinterp, avg(lemas_07.volinterp) volinterp,
	--avg(lemas_07.coninterp) coninterp, avg(lemas_07.othinterp) othinterp,
	-- Types of pay, e.g. merit-based
	avg(lemas_07.educpay) educpay, avg(lemas_07.hazardpay) hazardpay,
	avg(lemas_07.meritpay) meritpay, avg(lemas_07.shiftpay) shiftpay,
	avg(lemas_07.skillpay) skillpay, avg(lemas_07.langpay) langpay,
	avg(lemas_07.tuitionpay) tuitionpay, avg(lemas_07.milpay) milpay,
	avg(lemas_07.collbarg) collbarg, avg(lemas_07.respay) respay,
	-- Amount Paid - averages
	avg(lemas_07.chiefmin) chiefmin, avg(lemas_07.chiefmax) chiefmax,
	avg(lemas_07.sgtmin) sgtmin, avg(lemas_07.sgtmax) sgtmax,
	avg(lemas_07.entrymin) entrymin, avg(lemas_07.entrymax) entrymax,
	-- Community Policing
	avg(lemas_07.cptrnnew) cptrnnew, avg(lemas_07.cptrninserv) cptrninserv,
	avg(lemas_07.cpmission) cpmission, avg(lemas_07.cpacademy) cpacademy,
	avg(lemas_07.cpplan) cpplan, avg(lemas_07.cppartner) cppartner,
	avg(lemas_07.cpsurvey) cpsurvey, avg(lemas_07.cpunit) cpunit,
	avg(lemas_07.cpnone) cpnone,
	-- Contact with Community, Emergency Notification
	--avg(lemas_07.webstats) webstats,
	--avg(lemas_07.rev911not) rev911not, avg(lemas_07.massnotnum) massnotnum,
	--avg(lemas_07.ereporting) ereporting, avg(lemas_07.ecrimerep) ecrimerep,
	-- Cars and Cameras in Cars
	avg(lemas_07.nummrkcars) nummrkcars, avg(lemas_07.numumkcars) numumkcars,
	avg(lemas_07.numcarcam) numcarcam,
	-- Policies - average to get % with given policy
	avg(lemas_07.earlywarn) earlywarn, avg(lemas_07.codecondplcy) codecondplcy,
	avg(lemas_07.offdemplplcy) offdemplplcy, avg(lemas_07.maxhoursplcy) maxhoursplcy,
	avg(lemas_07.offdcondplcy) offdcondplcy, avg(lemas_07.mediaplcy) mediaplcy,
	avg(lemas_07.eapplcy) eapplcy, avg(lemas_07.mentillplcy) mentillplcy,
	avg(lemas_07.homelessplcy) homelessplcy, avg(lemas_07.domdispplcy) domdispplcy,
	avg(lemas_07.juvenileplcy) juvenileplcy, avg(lemas_07.limitengplcy) limitengplcy,
	avg(lemas_07.incusdthplcy) incusdthplcy,
	avg(lemas_07.deadforcplcy) deadforcplcy, avg(lemas_07.lessthanplcy) lessthanplcy,
	avg(lemas_07.racialprplcy) racialprplcy, avg(lemas_07.citcompplcy) citcompplcy,
	avg(lemas_07.immstatplcy) immstatplcy,
	avg(lemas_07.numuofsust) numuofsust,
	avg(lemas_07.numuofoth) numuofoth, avg(lemas_07.numuofpend) numuofpend,
	avg(lemas_07.numuoftot) numuoftot, avg(lemas_07.ccrb) ccrb,
	avg(lemas_07.ccrbpowers) ccrbpowers, avg(lemas_07.outsideinv) outsideinv
	FROM lemas_07, crosswalk
	WHERE crosswalk.ori7 = lemas_07.lemas_ori
	GROUP BY crosswalk.county_no