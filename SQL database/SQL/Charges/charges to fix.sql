ALTER TABLE charges_m1 ADD COLUMN vagrancy integer, ADD COLUMN suspicion integer,
	ADD COLUMN weapon integer, ADD COLUMN contempt integer, ADD COLUMN sodomy integer, ADD COLUMN bail_bond integer,
	ADD COLUMN prost_only integer, ADD COLUMN prost_pimp integer, ADD COLUMN prost_traf integer, ADD COLUMN arson integer,
	ADD COLUMN gambling integer, ADD COLUMN vandalism integer,  ADD COLUMN parole integer, ADD COLUMN probation integer,
	 ADD COLUMN fail_appear integer, ADD COLUMN immigration integer,  ADD COLUMN paraphernalia integer,
	 ADD COLUMN resist integer, ADD COLUMN officer integer,;

UPDATE charges_m1 SET sodomy = 0, weapon = 0, vagrancy = 0, suspicion = 0, contempt = 0, bail_bond = 0,
	prost_only = 0, prost_pimp = 0, prost_traf = 0, arson = 0, gambling = 0, vandalism = 0,	 parole = 0,
	probation = 0, fail_appear = 0, immigration = 0, paraphernalia = 0, resist = 0, officer = 0, 

UPDATE charges_m1 SET officer = 1, charge_coded = 1
	WHERE charges_m1.charge ~* '(^|[^a-z])(officer|offcr|peace of)';

UPDATE charges_m1 SET vagrancy = 1, charge_coded = 1
	WHERE charges_m1.charge ~* '(^|[^a-z])vagr';

UPDATE charges_m1 SET suspicion = 1, charge_coded = 1
	WHERE charges_m1.charge ~* '(^|[^a-z])suspic';

UPDATE charges_m1 SET sodomy = 1, charge_coded = 1
	WHERE charges_m1.charge ~* '(^|[^a-z])sodomy';

-- catches too much (e.g. whether bond was set)
UPDATE mugshots_charges_july2015 SET bail_bond = 1, charge_coded = 1
WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(bail|bo?nd)([^a-z]|$)'
AND mugshots_charges_july2015.charge !~* '\$|\d'
