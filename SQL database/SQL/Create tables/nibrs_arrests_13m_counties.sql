﻿-- Table: nibrs_arrests_13m_counties

-- DROP TABLE nibrs_arrests_13m_counties;

CREATE TABLE nibrs_arrests_13m_counties
(
  arrests_county_no double precision,
  arrests_age double precision,
  arrests_race_known double precision,
  arrests_arson double precision,
  arrests_aggravated_assault double precision,
  arrests_simple_assault double precision,
  arrests_intimidation double precision,
  arrests_assault_general double precision,
  arrests_bribery double precision,
  arrests_burglary double precision,
  arrests_forgery double precision,
  arrests_vandalism double precision,
  arrests_drugs_narcotics double precision,
  arrests_drug_equipment double precision,
  arrests_embezzlement double precision,
  arrests_extortion double precision,
  arrests_false_pretenses double precision,
  arrests_credit_card double precision,
  arrests_impersonation double precision,
  arrests_welfare_fraud double precision,
  arrests_wire_fraud double precision,
  arrests_fraud_general double precision,
  arrests_betting double precision,
  arrests_operating_gambling double precision,
  arrests_gambling_equipment double precision,
  arrests_sports_tampering double precision,
  arrests_gambling_general double precision,
  arrests_murder double precision,
  arrests_negligent_manslaughter double precision,
  arrests_justifiable_homicide double precision,
  arrests_homicide_general double precision,
  arrests_sex_trafficking double precision,
  arrests_labor_trafficking double precision,
  arrests_trafficking_general double precision,
  arrests_kidnapping double precision,
  arrests_pocket_picking double precision,
  arrests_purse_snatching double precision,
  arrests_shoplifting double precision,
  arrests_building_theft double precision,
  arrests_theft_from_machine double precision,
  arrests_theft_from_auto double precision,
  arrests_auto_parts_theft double precision,
  arrests_other_theft double precision,
  arrests_theft_general double precision,
  arrests_auto_theft double precision,
  arrests_pornography double precision,
  arrests_prostitution double precision,
  arrests_prostitution_promotion double precision,
  arrests_prostitution_purchase double precision,
  arrests_prostitution_general double precision,
  arrests_robbery double precision,
  arrests_forcible_rape double precision,
  arrests_forcible_sodomy double precision,
  arrests_rape_object double precision,
  arrests_forcible_fondling double precision,
  arrests_sex_offense_forcible double precision,
  arrests_incest double precision,
  arrests_statutory_rape double precision,
  arrests_sex_offense_nonforcible double precision,
  arrests_stolen_property double precision,
  arrests_weapon double precision,
  arrests_ucr_offense_code_unknown double precision,
  arrests_bad_check double precision,
  arrests_loitering double precision,
  arrests_disorder double precision,
  arrests_dui double precision,
  arrests_family_nonv double precision,
  arrests_liquor_law double precision,
  arrests_peeping_tom double precision,
  arrests_runaway double precision,
  arrests_trespass double precision,
  arrests_other_offense double precision,
  w_arrests_county_no double precision,
  w_arrests_age double precision,
  w_arrests_race_known double precision,
  w_arrests_arson double precision,
  w_arrests_aggravated_assault double precision,
  w_arrests_simple_assault double precision,
  w_arrests_intimidation double precision,
  w_arrests_assault_general double precision,
  w_arrests_bribery double precision,
  w_arrests_burglary double precision,
  w_arrests_forgery double precision,
  w_arrests_vandalism double precision,
  w_arrests_drugs_narcotics double precision,
  w_arrests_drug_equipment double precision,
  w_arrests_embezzlement double precision,
  w_arrests_extortion double precision,
  w_arrests_false_pretenses double precision,
  w_arrests_credit_card double precision,
  w_arrests_impersonation double precision,
  w_arrests_welfare_fraud double precision,
  w_arrests_wire_fraud double precision,
  w_arrests_fraud_general double precision,
  w_arrests_betting double precision,
  w_arrests_operating_gambling double precision,
  w_arrests_gambling_equipment double precision,
  w_arrests_sports_tampering double precision,
  w_arrests_gambling_general double precision,
  w_arrests_murder double precision,
  w_arrests_negligent_manslaughter double precision,
  w_arrests_justifiable_homicide double precision,
  w_arrests_homicide_general double precision,
  w_arrests_sex_trafficking double precision,
  w_arrests_labor_trafficking double precision,
  w_arrests_trafficking_general double precision,
  w_arrests_kidnapping double precision,
  w_arrests_pocket_picking double precision,
  w_arrests_purse_snatching double precision,
  w_arrests_shoplifting double precision,
  w_arrests_building_theft double precision,
  w_arrests_theft_from_machine double precision,
  w_arrests_theft_from_auto double precision,
  w_arrests_auto_parts_theft double precision,
  w_arrests_other_theft double precision,
  w_arrests_theft_general double precision,
  w_arrests_auto_theft double precision,
  w_arrests_pornography double precision,
  w_arrests_prostitution double precision,
  w_arrests_prostitution_promotion double precision,
  w_arrests_prostitution_purchase double precision,
  w_arrests_prostitution_general double precision,
  w_arrests_robbery double precision,
  w_arrests_forcible_rape double precision,
  w_arrests_forcible_sodomy double precision,
  w_arrests_rape_object double precision,
  w_arrests_forcible_fondling double precision,
  w_arrests_sex_offense_forcible double precision,
  w_arrests_incest double precision,
  w_arrests_statutory_rape double precision,
  w_arrests_sex_offense_nonforcible double precision,
  w_arrests_stolen_property double precision,
  w_arrests_weapon double precision,
  w_arrests_ucr_offense_code_unknown double precision,
  w_arrests_bad_check double precision,
  w_arrests_loitering double precision,
  w_arrests_disorder double precision,
  w_arrests_dui double precision,
  w_arrests_family_nonv double precision,
  w_arrests_liquor_law double precision,
  w_arrests_peeping_tom double precision,
  w_arrests_runaway double precision,
  w_arrests_trespass double precision,
  w_arrests_other_offense double precision,
  b_arrests_county_no double precision,
  b_arrests_age double precision,
  b_arrests_race_known double precision,
  b_arrests_arson double precision,
  b_arrests_aggravated_assault double precision,
  b_arrests_simple_assault double precision,
  b_arrests_intimidation double precision,
  b_arrests_assault_general double precision,
  b_arrests_bribery double precision,
  b_arrests_burglary double precision,
  b_arrests_forgery double precision,
  b_arrests_vandalism double precision,
  b_arrests_drugs_narcotics double precision,
  b_arrests_drug_equipment double precision,
  b_arrests_embezzlement double precision,
  b_arrests_extortion double precision,
  b_arrests_false_pretenses double precision,
  b_arrests_credit_card double precision,
  b_arrests_impersonation double precision,
  b_arrests_welfare_fraud double precision,
  b_arrests_wire_fraud double precision,
  b_arrests_fraud_general double precision,
  b_arrests_betting double precision,
  b_arrests_operating_gambling double precision,
  b_arrests_gambling_equipment double precision,
  b_arrests_sports_tampering double precision,
  b_arrests_gambling_general double precision,
  b_arrests_murder double precision,
  b_arrests_negligent_manslaughter double precision,
  b_arrests_justifiable_homicide double precision,
  b_arrests_homicide_general double precision,
  b_arrests_sex_trafficking double precision,
  b_arrests_labor_trafficking double precision,
  b_arrests_trafficking_general double precision,
  b_arrests_kidnapping double precision,
  b_arrests_pocket_picking double precision,
  b_arrests_purse_snatching double precision,
  b_arrests_shoplifting double precision,
  b_arrests_building_theft double precision,
  b_arrests_theft_from_machine double precision,
  b_arrests_theft_from_auto double precision,
  b_arrests_auto_parts_theft double precision,
  b_arrests_other_theft double precision,
  b_arrests_theft_general double precision,
  b_arrests_auto_theft double precision,
  b_arrests_pornography double precision,
  b_arrests_prostitution double precision,
  b_arrests_prostitution_promotion double precision,
  b_arrests_prostitution_purchase double precision,
  b_arrests_prostitution_general double precision,
  b_arrests_robbery double precision,
  b_arrests_forcible_rape double precision,
  b_arrests_forcible_sodomy double precision,
  b_arrests_rape_object double precision,
  b_arrests_forcible_fondling double precision,
  b_arrests_sex_offense_forcible double precision,
  b_arrests_incest double precision,
  b_arrests_statutory_rape double precision,
  b_arrests_sex_offense_nonforcible double precision,
  b_arrests_stolen_property double precision,
  b_arrests_weapon double precision,
  b_arrests_ucr_offense_code_unknown double precision,
  b_arrests_bad_check double precision,
  b_arrests_loitering double precision,
  b_arrests_disorder double precision,
  b_arrests_dui double precision,
  b_arrests_family_nonv double precision,
  b_arrests_liquor_law double precision,
  b_arrests_peeping_tom double precision,
  b_arrests_runaway double precision,
  b_arrests_trespass double precision,
  b_arrests_other_offense double precision,
  CONSTRAINT nibrs_arrests_13mc_pkey PRIMARY KEY (arrests_county_no)
)

WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_arrests_13m_counties
  OWNER TO roesler;