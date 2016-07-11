--SELECT count(mugshots_may2015.arrest_id) id_count, min(mugshots_may2015.date_year) min_year, max(mugshots_may2015.date_year) max_year FROM mugshots_may2015

SELECT count(mt.arrest_id) id_count
FROM mugshots_may2015_ac_male_1415 as mt
WHERE mt.white_only_ighisp = 1 OR mt.black_only_ighisp = 1

--SELECT min(mt.download_date), max(mt.download_date)
--FROM mugshots_may2015 as mt