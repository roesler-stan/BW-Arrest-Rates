-- Create charges for nibrs_offenders_13_lemas_acs_pres12

ALTER TABLE nibrs_offenders_13_lemas_acs_pres12 ADD COLUMN arson integer DEFAULT 0, ADD COLUMN aggravated_assault integer DEFAULT 0, ADD COLUMN simple_assault integer DEFAULT 0, ADD COLUMN
intimidation integer DEFAULT 0, ADD COLUMN bribery integer DEFAULT 0, ADD COLUMN burglary integer DEFAULT 0, ADD COLUMN forgery integer DEFAULT 0, ADD COLUMN vandalism integer DEFAULT 0, ADD COLUMN
drugs_narcotics integer DEFAULT 0, ADD COLUMN drug_equipment integer DEFAULT 0, ADD COLUMN embezzlement integer DEFAULT 0, ADD COLUMN extortion integer DEFAULT 0, ADD COLUMN
false_pretenses integer DEFAULT 0, ADD COLUMN credit_card integer DEFAULT 0, ADD COLUMN impersonation integer DEFAULT 0, ADD COLUMN welfare_fraud integer DEFAULT 0, ADD COLUMN
wire_fraud integer DEFAULT 0, ADD COLUMN betting integer DEFAULT 0, ADD COLUMN operating_gambling integer DEFAULT 0, ADD COLUMN gambling_equipment integer DEFAULT 0, ADD COLUMN
sports_tampering integer DEFAULT 0, ADD COLUMN murder integer DEFAULT 0, ADD COLUMN negligent_manslaughter integer DEFAULT 0, ADD COLUMN justifiable_homicide integer DEFAULT 0, ADD COLUMN
sex_trafficking integer DEFAULT 0, ADD COLUMN labor_trafficking integer DEFAULT 0, ADD COLUMN kidnapping integer DEFAULT 0, ADD COLUMN pocket_picking integer DEFAULT 0, ADD COLUMN
purse_snatching integer DEFAULT 0, ADD COLUMN shoplifting integer DEFAULT 0, ADD COLUMN building_theft integer DEFAULT 0, ADD COLUMN theft_from_machine integer DEFAULT 0, ADD COLUMN
theft_from_auto integer DEFAULT 0, ADD COLUMN auto_parts_theft integer DEFAULT 0, ADD COLUMN other_theft integer DEFAULT 0, ADD COLUMN auto_theft integer DEFAULT 0, ADD COLUMN
pornography integer DEFAULT 0, ADD COLUMN prostitution integer DEFAULT 0, ADD COLUMN prostitution_promotion integer DEFAULT 0, ADD COLUMN prostitution_purchase integer DEFAULT 0, ADD COLUMN
robbery integer DEFAULT 0, ADD COLUMN forcible_rape integer DEFAULT 0, ADD COLUMN forcible_sodomy integer DEFAULT 0, ADD COLUMN rape_object integer DEFAULT 0, ADD COLUMN
forcible_fondling integer DEFAULT 0, ADD COLUMN incest integer DEFAULT 0, ADD COLUMN statutory_rape integer DEFAULT 0, ADD COLUMN stolen_property integer DEFAULT 0, ADD COLUMN
weapon integer DEFAULT 0, ADD COLUMN
assault_general integer DEFAULT 0, ADD COLUMN drugs_general integer DEFAULT 0, ADD COLUMN fraud_general integer DEFAULT 0, ADD COLUMN gambling_general integer DEFAULT 0, ADD COLUMN
homicide_general integer DEFAULT 0, ADD COLUMN trafficking_general integer DEFAULT 0, ADD COLUMN theft_general integer DEFAULT 0, ADD COLUMN prostitution_general integer DEFAULT 0, ADD COLUMN
sex_offense_forcible integer DEFAULT 0, ADD COLUMN sex_offense_nonforcible integer DEFAULT 0,
-- arrests specific below
ADD COLUMN bad_check integer DEFAULT 0, ADD COLUMN loitering integer DEFAULT 0, ADD COLUMN disorder integer DEFAULT 0,
ADD COLUMN dui integer DEFAULT 0, ADD COLUMN drunk integer DEFAULT 0, ADD COLUMN family_nonv integer DEFAULT 0,
ADD COLUMN liquor_law integer DEFAULT 0, ADD COLUMN peeping_tom integer DEFAULT 0, ADD COLUMN runaway integer DEFAULT 0,
ADD COLUMN trespass integer DEFAULT 0, ADD COLUMN other_offense integer DEFAULT 0, ADD COLUMN ucr_offense_code_unknown integer DEFAULT 0;