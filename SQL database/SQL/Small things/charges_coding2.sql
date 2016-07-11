SELECT mugshots_charges_july2015.charge FROM mugshots_charges_july2015
	WHERE mugshots_charges_july2015.charge ~* '(^|[^a-z])misd'
	LIMIT 100;