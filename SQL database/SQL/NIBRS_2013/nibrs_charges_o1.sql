-- Create charges for nibrs_offenders_arrestees_13_lemas_acs_pres12

ALTER TABLE nibrs_offenders_arrestees_13_lemas_acs_pres12 ADD COLUMN arrest_arson integer DEFAULT 0, ADD COLUMN arrest_aggravated_assault integer DEFAULT 0, ADD COLUMN arrest_simple_assault integer DEFAULT 0, ADD COLUMN
arrest_intimidation integer DEFAULT 0, ADD COLUMN arrest_bribery integer DEFAULT 0, ADD COLUMN arrest_burglary integer DEFAULT 0, ADD COLUMN arrest_forgery integer DEFAULT 0, ADD COLUMN arrest_vandalism integer DEFAULT 0, ADD COLUMN
arrest_drugs_narcotics integer DEFAULT 0, ADD COLUMN arrest_drug_equipment integer DEFAULT 0, ADD COLUMN arrest_embezzlement integer DEFAULT 0, ADD COLUMN arrest_extortion integer DEFAULT 0, ADD COLUMN
arrest_false_pretenses integer DEFAULT 0, ADD COLUMN arrest_credit_card integer DEFAULT 0, ADD COLUMN arrest_impersonation integer DEFAULT 0, ADD COLUMN arrest_welfare_fraud integer DEFAULT 0, ADD COLUMN
arrest_wire_fraud integer DEFAULT 0, ADD COLUMN arrest_betting integer DEFAULT 0, ADD COLUMN arrest_operating_gambling integer DEFAULT 0, ADD COLUMN arrest_gambling_equipment integer DEFAULT 0, ADD COLUMN
arrest_sports_tampering integer DEFAULT 0, ADD COLUMN arrest_murder integer DEFAULT 0, ADD COLUMN arrest_negligent_manslaughter integer DEFAULT 0, ADD COLUMN arrest_justifiable_homicide integer DEFAULT 0, ADD COLUMN
arrest_sex_trafficking integer DEFAULT 0, ADD COLUMN arrest_labor_trafficking integer DEFAULT 0, ADD COLUMN arrest_kidnapping integer DEFAULT 0, ADD COLUMN arrest_pocket_picking integer DEFAULT 0, ADD COLUMN
arrest_purse_snatching integer DEFAULT 0, ADD COLUMN arrest_shoplifting integer DEFAULT 0, ADD COLUMN arrest_building_theft integer DEFAULT 0, ADD COLUMN arrest_theft_from_machine integer DEFAULT 0, ADD COLUMN
arrest_theft_from_auto integer DEFAULT 0, ADD COLUMN arrest_auto_parts_theft integer DEFAULT 0, ADD COLUMN arrest_other_theft integer DEFAULT 0, ADD COLUMN arrest_auto_theft integer DEFAULT 0, ADD COLUMN
arrest_pornography integer DEFAULT 0, ADD COLUMN arrest_prostitution integer DEFAULT 0, ADD COLUMN arrest_prostitution_promotion integer DEFAULT 0, ADD COLUMN arrest_prostitution_purchase integer DEFAULT 0, ADD COLUMN
arrest_robbery integer DEFAULT 0, ADD COLUMN arrest_forcible_rape integer DEFAULT 0, ADD COLUMN arrest_forcible_sodomy integer DEFAULT 0, ADD COLUMN arrest_rape_object integer DEFAULT 0, ADD COLUMN
arrest_forcible_fondling integer DEFAULT 0, ADD COLUMN arrest_incest integer DEFAULT 0, ADD COLUMN arrest_statutory_rape integer DEFAULT 0, ADD COLUMN arrest_stolen_property integer DEFAULT 0, ADD COLUMN
arrest_weapon integer DEFAULT 0, ADD COLUMN
arrest_assault_general integer DEFAULT 0, ADD COLUMN arrest_drugs_general integer DEFAULT 0, ADD COLUMN arrest_fraud_general integer DEFAULT 0, ADD COLUMN arrest_gambling_general integer DEFAULT 0, ADD COLUMN
arrest_homicide_general integer DEFAULT 0, ADD COLUMN arrest_trafficking_general integer DEFAULT 0, ADD COLUMN arrest_theft_general integer DEFAULT 0, ADD COLUMN arrest_prostitution_general integer DEFAULT 0, ADD COLUMN
arrest_sex_offense_forcible integer DEFAULT 0, ADD COLUMN arrest_sex_offense_nonforcible integer DEFAULT 0,
-- arrests specific below
ADD COLUMN arrest_bad_check integer DEFAULT 0, ADD COLUMN arrest_loitering integer DEFAULT 0, ADD COLUMN arrest_disorder integer DEFAULT 0,
ADD COLUMN arrest_dui integer DEFAULT 0, ADD COLUMN arrest_drunk integer DEFAULT 0, ADD COLUMN arrest_family_nonv integer DEFAULT 0,
ADD COLUMN arrest_liquor_law integer DEFAULT 0, ADD COLUMN arrest_peeping_tom integer DEFAULT 0, ADD COLUMN arrest_runaway integer DEFAULT 0,
ADD COLUMN arrest_trespass integer DEFAULT 0, ADD COLUMN arrest_other_offense integer DEFAULT 0, ADD COLUMN arrest_ucr_offense_code_unknown integer DEFAULT 0;


-- Create charges for nibrs_offenders_arrestees_13_lemas_acs_pres12

ALTER TABLE nibrs_offenders_arrestees_13_lemas_acs_pres12 ADD COLUMN offense_arson integer DEFAULT 0, ADD COLUMN offense_aggravated_assault integer DEFAULT 0, ADD COLUMN offense_simple_assault integer DEFAULT 0, ADD COLUMN
offense_intimidation integer DEFAULT 0, ADD COLUMN offense_bribery integer DEFAULT 0, ADD COLUMN offense_burglary integer DEFAULT 0, ADD COLUMN offense_forgery integer DEFAULT 0, ADD COLUMN offense_vandalism integer DEFAULT 0, ADD COLUMN
offense_drugs_narcotics integer DEFAULT 0, ADD COLUMN offense_drug_equipment integer DEFAULT 0, ADD COLUMN offense_embezzlement integer DEFAULT 0, ADD COLUMN offense_extortion integer DEFAULT 0, ADD COLUMN
offense_false_pretenses integer DEFAULT 0, ADD COLUMN offense_credit_card integer DEFAULT 0, ADD COLUMN offense_impersonation integer DEFAULT 0, ADD COLUMN offense_welfare_fraud integer DEFAULT 0, ADD COLUMN
offense_wire_fraud integer DEFAULT 0, ADD COLUMN offense_betting integer DEFAULT 0, ADD COLUMN offense_operating_gambling integer DEFAULT 0, ADD COLUMN offense_gambling_equipment integer DEFAULT 0, ADD COLUMN
offense_sports_tampering integer DEFAULT 0, ADD COLUMN offense_murder integer DEFAULT 0, ADD COLUMN offense_negligent_manslaughter integer DEFAULT 0, ADD COLUMN offense_justifiable_homicide integer DEFAULT 0, ADD COLUMN
offense_sex_trafficking integer DEFAULT 0, ADD COLUMN offense_labor_trafficking integer DEFAULT 0, ADD COLUMN offense_kidnapping integer DEFAULT 0, ADD COLUMN offense_pocket_picking integer DEFAULT 0, ADD COLUMN
offense_purse_snatching integer DEFAULT 0, ADD COLUMN offense_shoplifting integer DEFAULT 0, ADD COLUMN offense_building_theft integer DEFAULT 0, ADD COLUMN offense_theft_from_machine integer DEFAULT 0, ADD COLUMN
offense_theft_from_auto integer DEFAULT 0, ADD COLUMN offense_auto_parts_theft integer DEFAULT 0, ADD COLUMN offense_other_theft integer DEFAULT 0, ADD COLUMN offense_auto_theft integer DEFAULT 0, ADD COLUMN
offense_pornography integer DEFAULT 0, ADD COLUMN offense_prostitution integer DEFAULT 0, ADD COLUMN offense_prostitution_promotion integer DEFAULT 0, ADD COLUMN offense_prostitution_purchase integer DEFAULT 0, ADD COLUMN
offense_robbery integer DEFAULT 0, ADD COLUMN offense_forcible_rape integer DEFAULT 0, ADD COLUMN offense_forcible_sodomy integer DEFAULT 0, ADD COLUMN offense_rape_object integer DEFAULT 0, ADD COLUMN
offense_forcible_fondling integer DEFAULT 0, ADD COLUMN offense_incest integer DEFAULT 0, ADD COLUMN offense_statutory_rape integer DEFAULT 0, ADD COLUMN offense_stolen_property integer DEFAULT 0, ADD COLUMN
offense_weapon integer DEFAULT 0, ADD COLUMN
offense_assault_general integer DEFAULT 0, ADD COLUMN offense_drugs_general integer DEFAULT 0, ADD COLUMN offense_fraud_general integer DEFAULT 0, ADD COLUMN offense_gambling_general integer DEFAULT 0, ADD COLUMN
offense_homicide_general integer DEFAULT 0, ADD COLUMN offense_trafficking_general integer DEFAULT 0, ADD COLUMN offense_theft_general integer DEFAULT 0, ADD COLUMN offense_prostitution_general integer DEFAULT 0, ADD COLUMN
offense_sex_offense_forcible integer DEFAULT 0, ADD COLUMN offense_sex_offense_nonforcible integer DEFAULT 0, ADD COLUMN offense_ucr_offense_code_unknown integer DEFAULT 0;