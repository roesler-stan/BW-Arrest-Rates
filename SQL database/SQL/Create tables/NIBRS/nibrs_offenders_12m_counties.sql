-- Table: nibrs_offenders_12m_counties

-- DROP TABLE nibrs_offenders_12m_counties;

CREATE TABLE nibrs_offenders_12m_counties
(
  offenders_county_no character varying NOT NULL,
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
  CONSTRAINT nibrs_offenders_12m_counties_pkey PRIMARY KEY (offenders_county_no)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_offenders_12m_counties
  OWNER TO roesler;