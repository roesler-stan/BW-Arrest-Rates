-- 'distribute' and 'disturb' are too similar to cut out vowels to get only disturb
-- excludes 'peace officer' but keeps 'dis/br... peace'
UPDATE mugshots_charges_july2015 SET disorder = 1, charge_coded = 1, main_charge = 'disorder'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(diso?rde?r|(dis|br).*peace(?! of)|quiet|di?sru?pt|disturb)'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(mental.*diso?rde?r|metal.*disorder|emotion.*disturb)';

-- removing sex offenders near parks, but not loitering for prostitution or drugs
UPDATE mugshots_charges_july2015 SET loiter_prowl = 1, charge_coded = 1, main_charge = 'loiter_prowl'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(loiter|pro?wl)'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(se?x.*of)';

-- prostitution, not pimping or trafficking, no minors
UPDATE mugshots_charges_july2015 SET prost_only = 1, charge_coded = 1, main_charge = 'prost_only'
WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(prost|commerc.*vice)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(pimp|promot|procur|entic|compel|induc)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(minor|((^|\D)1[6-8](\D|$))|under|eighteen|juv|chi?ld)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(traf|tra?nspo?rt)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(patron|solicit|(sol([^a-z]|$)))';

--patronizing/soliciting prostituton
UPDATE mugshots_charges_july2015 SET prost_patron = 1, charge_coded = 1, main_charge = 'prost_patron'
WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(prost|commerc.*vice)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(pimp|promot|procur|entic|compel|induc)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(minor|((^|\D)1[6-8](\D|$))|under|eighteen|juv|chi?ld)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(traf|tra?nspo?rt)'
and mugshots_charges_july2015.charge ~* '(^|[^a-z])(patron|solicit|(sol([^a-z]|$)))';

-- prostitution pimping, not patronizing, trafficking, or minors
UPDATE mugshots_charges_july2015 SET prost_pimp = 1, charge_coded = 1, main_charge = 'prost_pimp'
WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(prost|commerc.*vice)'
and mugshots_charges_july2015.charge ~* '(^|[^a-z])(pimp|promot|procur|entic|compel|induc)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(minor|((^|\D)1[6-8](\D|$))|under|eighteen|juv|chi?ld)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(traf|tra?nspo?rt)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(patron|solicit|(sol([^a-z]|$)))';

-- prostitution trafficking, no minors
UPDATE mugshots_charges_july2015 SET prost_traf = 1, charge_coded = 1, main_charge = 'prost_traf'
WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(prost|commerc.*vice)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(pimp|promot|procur|entic|compel|induc)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(minor|((^|\D)1[6-8](\D|$))|under|eighteen|juv|chi?ld)'
and mugshots_charges_july2015.charge ~* '(^|[^a-z])(traf|tra?nspo?rt)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(patron|solicit|(sol([^a-z]|$)))';

-- prostitution with minors, regardless of trafficking, pimping, or patronizing
UPDATE mugshots_charges_july2015 SET prost_minor = 1, charge_coded = 1
WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(prost|commerc.*vice)'
and mugshots_charges_july2015.charge ~* '(^|[^a-z])(minor|((^|\D)1[6-8](\D|$))|under|eighteen|juv|chi?ld)';

-- prostitution with minors, no trafficking, pimping, or patronizing
UPDATE mugshots_charges_july2015 SET prost_minor_only = 1, charge_coded = 1, main_charge = 'prost_minor_only'
WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(prost|commerc.*vice)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(pimp|promot|procur|entic|compel|induc)'
and mugshots_charges_july2015.charge ~* '(^|[^a-z])(minor|((^|\D)1[6-8](\D|$))|under|eighteen|juv|chi?ld)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(traf|tra?nspo?rt)'
and mugshots_charges_july2015.charge !~* '(^|[^a-z])(patron|solicit|(sol([^a-z]|$)))';

UPDATE mugshots_charges_july2015 SET attempted = 1
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(soli?ci?t|att|conspi?r|to co?mmi?t|compli?ci?t|facilitat)';

UPDATE mugshots_charges_july2015 SET felony = 1
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(fe?lo?ny)|(fel([^a-z]|$))';

UPDATE mugshots_charges_july2015 SET misdemeanor = 1
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])misd';