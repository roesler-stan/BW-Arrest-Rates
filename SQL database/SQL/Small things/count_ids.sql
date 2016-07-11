-- july2013p_id_counts
-- mugshots_july2015 has 415 counties with exactly 1000 records
-- mugshots_may2015 has 402 counties with exactly 1000 records

SELECT counts.county_no, counts.id_count FROM
(SELECT mt.county_no county_no, count(mt.arrest_id) id_count
FROM mugshots_may2015 as mt
GROUP BY mt.county_no) counts
WHERE counts.id_count = 1000