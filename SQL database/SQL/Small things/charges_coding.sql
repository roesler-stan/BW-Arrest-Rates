SELECT charges_m1.charge
FROM charges_m1
	WHERE charges_m1.charge ~* '(?=.*(^|[^a-z])re?ckle?ss)(?=.*(^|[^a-z])driv)'
	and charges_m1.charge !~* '(^|[^a-z])(flee|esca?pe?|elud|arre?st|pol)';
