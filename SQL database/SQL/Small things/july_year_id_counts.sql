-- july_year_id_counts

SELECT counts.date_year, counts.id_count FROM
(SELECT mt.date_year date_year, count(mt.arrest_id) id_count
FROM mugshots_july2015 as mt
WHERE mt.county_no IS NOT NULL and mt.date_year IS NOT NULL
GROUP BY mt.date_year) counts