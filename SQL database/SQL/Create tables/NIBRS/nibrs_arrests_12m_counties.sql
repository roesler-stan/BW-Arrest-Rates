﻿-- Table: nibrs_arrests_12m_counties

-- DROP TABLE nibrs_arrests_12m_counties;

CREATE TABLE nibrs_arrests_12m_counties
(
  arrests_county_no character varying NOT NULL,
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
  CONSTRAINT nibrs_arrests_12m_counties_pkey PRIMARY KEY (arrests_county_no)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_arrests_12m_counties
  OWNER TO roesler;