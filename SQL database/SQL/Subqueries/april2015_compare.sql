--april2015_may
--SELECT * FROM mugshots_may2015
--WHERE date_year = 2015 AND date_month = 4

--ALTER TABLE april2015_may ADD COLUMN dataset character varying;

--UPDATE april2015_may SET dataset = 'may';


--april2015_july
--SELECT * FROM mugshots_july2015
--WHERE date_year = 2015 AND date_month = 4

--ALTER TABLE april2015_july ADD COLUMN dataset character varying;

--UPDATE april2015_july SET dataset = 'july';


--april2015_compare
SELECT am.dataset, am.white_only, am.black_only, am.gender FROM april2015_may as am
UNION ALL SELECT aj.dataset, aj.white_only, aj.black_only, aj.gender FROM april2015_july as aj;