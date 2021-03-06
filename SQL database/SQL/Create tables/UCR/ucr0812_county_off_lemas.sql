﻿-- Table: ucr0812_county_off_lemas

-- DROP TABLE ucr0812_county_off_lemas;

CREATE TABLE ucr0812_county_off_lemas
(
  county_no character varying,
  offense character varying,
  ori_count double precision,
  avg_year double precision,
  state character varying,
  population double precision,
  b_arrests double precision,
  w_arrests double precision,
  i_arrests double precision,
  a_arrests double precision,
  h_arrests double precision,
  nonh_arrests double precision,
  lemas_county_no character varying,
  agency_count double precision,
  agcytype_count double precision,
  impbudget double precision,
  impcarcam double precision,
  imgender double precision,
  imprace double precision,
  swnauthemp double precision,
  swnftemp double precision,
  ftgangoff double precision,
  ptgangoff double precision,
  drugs_ft double precision,
  drugs_pt double precision,
  b_officers double precision,
  w_officers double precision,
  h_officers double precision,
  a_officers double precision,
  n_officers double precision,
  ai_officers double precision,
  mult_officers double precision,
  u_officers double precision,
  male_officers double precision,
  female_officers double precision,
  totgender double precision,
  opbudget double precision,
  opbudgest double precision,
  drugforf double precision,
  gambforf double precision,
  othrforf double precision,
  asforest double precision,
  mineduc double precision,
  edreqexm double precision,
  backgrnd double precision,
  credhis double precision,
  crimhis double precision,
  drivhis double precision,
  intervw double precision,
  perstest double precision,
  polyexam double precision,
  psycheval double precision,
  voicestress double precision,
  writaptest double precision,
  anprobsolv double precision,
  cultdiv double precision,
  confmgt double precision,
  seclang double precision,
  volhis double precision,
  drugtest double precision,
  medexam double precision,
  phystest double precision,
  totacad double precision,
  totfield double precision,
  totinsrv double precision,
  educpay double precision,
  hazardpay double precision,
  meritpay double precision,
  shiftpay double precision,
  skillpay double precision,
  langpay double precision,
  tuitionpay double precision,
  milpay double precision,
  collbarg double precision,
  respay double precision,
  chiefmin double precision,
  chiefmax double precision,
  sgtmin double precision,
  sgtmax double precision,
  entrymin double precision,
  entrymax double precision,
  cptrnnew double precision,
  cptrninserv double precision,
  cpmission double precision,
  cpacademy double precision,
  cpplan double precision,
  cppartner double precision,
  cpsurvey double precision,
  cpunit double precision,
  cpnone double precision,
  nummrkcars double precision,
  numumkcars double precision,
  numcarcam double precision,
  earlywarn double precision,
  codecondplcy double precision,
  offdemplplcy double precision,
  maxhoursplcy double precision,
  offdcondplcy double precision,
  mediaplcy double precision,
  eapplcy double precision,
  mentillplcy double precision,
  homelessplcy double precision,
  domdispplcy double precision,
  juvenileplcy double precision,
  limitengplcy double precision,
  incusdthplcy double precision,
  deadforcplcy double precision,
  lessthanplcy double precision,
  racialprplcy double precision,
  citcompplcy double precision,
  immstatplcy double precision,
  numuofsust double precision,
  numuofoth double precision,
  numuofpend double precision,
  numuoftot double precision,
  ccrb double precision,
  ccrbpowers double precision,
  outsideinv double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE ucr0812_county_off_lemas
  OWNER TO roesler;
