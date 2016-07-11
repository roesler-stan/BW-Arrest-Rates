UPDATE mugshots_charges_july2015 SET paraphernalia = 1, charge_coded = 1
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(paraphern|((?=.*drug)(?=.*para)))';

UPDATE mugshots_charges_july2015 SET dui = 1, charge_coded = 1, main_charge = 'dui'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(dui|dwi|oui|owi|omvi)'
	or mugshots_charges_july2015.charge ~* '(?=.*((^|[^a-z])(driv|veh|mo?to?r.*v|auto))(?=.*(^|[^a-z])(alc|.08|drunk|drink|infl|alc|intox|impair)))';

UPDATE mugshots_charges_july2015 SET alcohol = 1, charge_coded = 1
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(alcohol|intox|influence|impair)'
	or mugshots_charges_july2015.dui = 1;

--weapon, not trafficking in weapons
UPDATE mugshots_charges_july2015 SET weapon = 1, charge_coded = 1, main_charge = 'weapon'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(we?a?po?n|gun|knife|kniv|firearm|dagger|pistol|rifle|switchblade)'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(dist|sale|ma?nu?f|traf|sell|sale)';

-- drunk in public, not dui
UPDATE mugshots_charges_july2015 SET drunk_public = 1, charge_coded = 1, main_charge = 'drunk_public'
	WHERE mugshots_charges_july2015.dui != 1
	and mugshots_charges_july2015.charge ~* '(?=.*((^|[^a-z])(drink|drunk|into?x|alc|liq)))(?=.*((^|[^a-z])(pub|pu?bli?c)))'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(minor|underage|u.*18|(excl.*alc))';

-- speeding, not to escape arrest
UPDATE mugshots_charges_july2015 SET speeding = 1, charge_coded = 1, main_charge = 'speeding'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(speed|((?=.*spd)(?=.*([\d]{2}|li?mi?t))))'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(flee|esca?pe?|elud|arre?st|pol)';

-- reckless driving, not to escape arrest
UPDATE mugshots_charges_july2015 SET reckless_driving = 1, charge_coded = 1, main_charge = 'reckless_driving'
	WHERE mugshots_charges_july2015.charge ~* '(?=.*(^|[^a-z])re?ckle?ss)(?=.*(^|[^a-z])driv)'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(flee|esca?pe?|elud|arre?st|pol)';

UPDATE mugshots_charges_july2015 SET no_license = 1, charge_coded = 1, main_charge = 'no_license'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(dwr|dws|dwl|lic|susp|revo?k)';

-- driving offense, non-dui (excludes driving while dui-related suspended license)
UPDATE mugshots_charges_july2015 SET driving = 1, charge_coded = 1
	WHERE mugshots_charges_july2015.dui != 1
	and (mugshots_charges_july2015.speeding = 1 or mugshots_charges_july2015.no_license = 1
	or mugshots_charges_july2015.charge ~* '(^|[^a-z])(driv|(tail (lamp|light))|seat belt|stop sign)');

UPDATE mugshots_charges_july2015 SET murder = 1, charge_coded = 1, main_charge = 'murder'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])murd'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(mansl|soli?ci?t|att|acc|conspi?r|to commit|int|compli?ci?t|facilitat)';

-- rape, excluding possession of date rape drugs
UPDATE mugshots_charges_july2015 SET rape = 1, charge_coded = 1, main_charge = 'rape'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])rape'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(dru?g|po?s.*co?ntr)';

UPDATE mugshots_charges_july2015 SET robbery = 1, charge_coded = 1, main_charge = 'robbery'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])rob'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(att|acc|conspi?r|to commit|int|compli?ci?t|facilitat)';

-- assault, not sexual
UPDATE mugshots_charges_july2015 SET assault = 1, charge_coded = 1, main_charge = 'assault'
	WHERE mugshots_charges_july2015.charge ~* '((^|[^a-z])(assa?u?lt|bat|a&b))'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(se?x|inde?c)';

UPDATE mugshots_charges_july2015 SET burglary = 1, charge_coded = 1, main_charge = 'burglary'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(burg|brg)'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(att|acc|conspi?r|to commit|int|compli?ci?t|facilitat)';

-- theft, not identity or labor theft
UPDATE mugshots_charges_july2015 SET theft = 1, charge_coded = 1, main_charge = 'theft'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(larc|the?ft|stolen|steal|lmfr|sho?pli?ft)'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(labor|identity|rec)';

UPDATE mugshots_charges_july2015 SET auto_theft = 1, charge_coded = 1, main_charge = 'auto_theft'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])((?=.*(auto|veh|motor))(?=.*the?ft))|(carja?ck|joyri?d)';

UPDATE mugshots_charges_july2015 SET fraud = 1, charge_coded = 1, main_charge = 'fraud'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(forg|co?u?nte?rf|che?c?k|fra?u?d)';

UPDATE mugshots_charges_july2015 SET embez = 1, charge_coded = 1, main_charge = 'embez'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])embe?z';
