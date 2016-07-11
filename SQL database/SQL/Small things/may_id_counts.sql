-- may_id_counts

SELECT mt.county_no county_no, mt.date_year date_year, count(mt.arrest_id) id_count
FROM mugshots_may2015 as mt
GROUP BY mt.county_no, mt.date_year