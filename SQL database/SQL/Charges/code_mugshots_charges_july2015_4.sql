-- marijuana possession, or at least not sale
UPDATE mugshots_charges_july2015 SET mar_poss = 1, charge_coded = 1, main_charge = 'mar_poss'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(mari?(j|h)|cannab|hash)'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(di?st|sale|manu?f|tra?f|sell|cult|complicit)';
--or mugshots_charges_july2015.charge ~* '(^|[^a-z])po?s'

UPDATE mugshots_charges_july2015 SET coc_poss = 1, charge_coded = 1, main_charge = 'coc_poss'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])coc'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(di?st|sale|manu?f|tra?f|sell|cult|complicit)';
--or mugshots_charges_july2015.charge ~* '(^|[^a-z])po?s'

UPDATE mugshots_charges_july2015 SET othdrug_poss = 1, charge_coded = 1, main_charge = 'othdrug_poss'
	WHERE mugshots_charges_july2015.mar_poss != 1 and mugshots_charges_july2015.coc_poss != 1
	and mugshots_charges_july2015.charge ~* '(^|[^a-z])(dru?g|co?nt.*su?b|su?bst|nar|heroi|opio|opiu|meth|pcp|codein)'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(di?st|sale|manu?f|tra?f|sell|cult|complicit)';
--or mugshots_charges_july2015.charge ~* '(^|[^a-z])po?s';

UPDATE mugshots_charges_july2015 SET mar_sale = 1, charge_coded = 1, main_charge = 'mar_sale'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(mari?(j|h)|cannab|hash)'
	and mugshots_charges_july2015.charge ~* '(^|[^a-z])(di?st|sale|manu?f|tra?f|sell)';

UPDATE mugshots_charges_july2015 SET coc_sale = 1, charge_coded = 1, main_charge = 'coc_sale'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])coc'
	and mugshots_charges_july2015.charge ~* '(^|[^a-z])(di?st|sale|manu?f|tra?f|sell)';

UPDATE mugshots_charges_july2015 SET othdrug_sale = 1, charge_coded = 1, main_charge = 'othdrug_sale'
	WHERE mugshots_charges_july2015.mar_sale != 1 and mugshots_charges_july2015.coc_sale != 1
	and mugshots_charges_july2015.charge ~* '(^|[^a-z])(dru?g|co?nt.*su?b|su?bst|nar|heroi|opio|opiu|meth|pcp|codein)'
	and mugshots_charges_july2015.charge ~* '(^|[^a-z])(di?st|sale|manu?f|tra?f|sell)';

-- sex offense, not prostitution (e.g. battery, child molestation, rape, sodomy)
UPDATE mugshots_charges_july2015 SET sex_offense = 1, charge_coded = 1, main_charge = 'sex_offense'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(se?x|rape|mo?le?st|le?wd|sodomy|inde?ce?nt)';

UPDATE mugshots_charges_july2015 SET child_sex_offense = 1, charge_coded = 1
	WHERE mugshots_charges_july2015.sex_offense = 1
	and mugshots_charges_july2015.charge ~* '(^|[^a-z])(chi?(l|d)|mi?no?r|u.*18|under)';

UPDATE mugshots_charges_july2015 SET ipv = 1, charge_coded = 1, main_charge = 'ipv'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(dom|part|spo?u?s|cohab|fianc|fam)'
	and mugshots_charges_july2015.charge ~* '(^|[^a-z])(viol|abus|ass|bat|inj)'
	and mugshots_charges_july2015.charge !~* '(^|[^a-z])(chi?(l|d)|se?x|mi?no?r|u.*18)';

UPDATE mugshots_charges_july2015 SET harass_stalk = 1, charge_coded = 1, main_charge = 'harass_stalk'
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])(ha?ra?s|sta?lk)';
