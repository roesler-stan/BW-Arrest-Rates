-- put common / not main charges first, so they don't overwrite actual main charges
UPDATE mugshots_charges_july2015 SET contempt_fail_appear = 1, charge_coded = 1, main_charge = 'contempt_fail_appear'
	WHERE mugshots_charges_july2015.charge ~*  '(^|[^a-z])co?nte?mpt.*co?u?rt|fail.*appear|fta([^a-z]|$)';

UPDATE mugshots_charges_july2015 SET immigration = 1, charge_coded = 1, main_charge = 'immigration'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(de?po?rt|immi?g|visa([^a-z]|$)|alien)';

UPDATE mugshots_charges_july2015 SET resist = 1, charge_coded = 1, main_charge = 'resist'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])((re?si?st|eva?d|avo?i?d|esca?pe?|elud).*arre?st)';

UPDATE mugshots_charges_july2015 SET vandalism = 1, charge_coded = 1, main_charge = 'vandalism'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(vand|graf)';

UPDATE mugshots_charges_july2015 SET gambling = 1, charge_coded = 1, main_charge = 'gambling'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])gamb';

UPDATE mugshots_charges_july2015 SET probation = 1, charge_coded = 1, main_charge = 'probation'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])pro?ba?t(i?o?n|[^a-z])';

UPDATE mugshots_charges_july2015 SET parole = 1, charge_coded = 1, main_charge = 'parole'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])parole?([^a-z]|$)';

UPDATE mugshots_charges_july2015 SET arson = 1, charge_coded = 1, main_charge = 'arson'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])arson';