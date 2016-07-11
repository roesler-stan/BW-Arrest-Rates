-- Making charge dummies that are automatically 0 and then 1 if found
-- Don't use booleans, b/c of pandas groupby()[].mean() issue

ALTER TABLE mugshots_charges_july2015 ADD COLUMN murder integer DEFAULT 0, ADD COLUMN rape integer DEFAULT 0,
	ADD COLUMN robbery integer DEFAULT 0, ADD COLUMN assault integer DEFAULT 0,
	ADD COLUMN burglary integer DEFAULT 0, ADD COLUMN theft integer DEFAULT 0, ADD COLUMN auto_theft integer DEFAULT 0,
	ADD COLUMN fraud integer DEFAULT 0, ADD COLUMN embez integer DEFAULT 0,
	ADD COLUMN mar_poss integer DEFAULT 0, ADD COLUMN coc_poss integer DEFAULT 0, ADD COLUMN othdrug_poss integer DEFAULT 0,
	ADD COLUMN mar_sale integer DEFAULT 0, ADD COLUMN coc_sale integer DEFAULT 0,
	ADD COLUMN othdrug_sale integer DEFAULT 0, ADD COLUMN sex_offense integer DEFAULT 0, ADD COLUMN ipv integer DEFAULT 0,
	ADD COLUMN dui integer DEFAULT 0, ADD COLUMN drunk_public integer DEFAULT 0, ADD COLUMN disorder integer DEFAULT 0,
	ADD COLUMN loiter_prowl integer DEFAULT 0, ADD COLUMN driving integer DEFAULT 0, ADD COLUMN harass_stalk integer DEFAULT 0,
	ADD COLUMN child_sex_offense integer DEFAULT 0, ADD COLUMN weapon integer DEFAULT 0,
	ADD COLUMN speeding integer DEFAULT 0, ADD COLUMN reckless_driving integer DEFAULT 0, ADD COLUMN no_license integer DEFAULT 0,
	ADD COLUMN resist integer DEFAULT 0, ADD COLUMN probation integer DEFAULT 0, ADD COLUMN parole integer DEFAULT 0,
	ADD COLUMN arson integer DEFAULT 0, ADD COLUMN contempt_fail_appear integer DEFAULT 0, ADD COLUMN immigration integer DEFAULT 0,
	ADD COLUMN paraphernalia integer DEFAULT 0, ADD COLUMN alcohol integer DEFAULT 0, ADD COLUMN gambling integer DEFAULT 0,
	ADD COLUMN felony integer DEFAULT 0, ADD COLUMN misdemeanor integer DEFAULT 0, ADD COLUMN vandalism integer DEFAULT 0,
	ADD COLUMN prost_minor integer DEFAULT 0, ADD COLUMN prost_only integer DEFAULT 0, ADD COLUMN prost_traf integer DEFAULT 0,
	ADD COLUMN prost_patron integer DEFAULT 0, ADD COLUMN prost_minor_only integer DEFAULT 0, ADD COLUMN prost_pimp integer DEFAULT 0,
	ADD COLUMN charge_coded integer DEFAULT 0, ADD COLUMN attempted integer DEFAULT 0, ADD COLUMN main_charge character varying;