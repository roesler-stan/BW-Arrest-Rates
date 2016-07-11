-- may_id_counts

SELECT * FROM
((SELECT * FROM
(SELECT may2015_id_counts.county_no county_no15,
may2015_id_counts.id_count id_count15
FROM may2015_id_counts) may15

LEFT OUTER JOIN
(SELECT may2014p_id_counts.county_no county_no14p,
may2014p_id_counts.id_count id_count14p
FROM may2014p_id_counts) may14
ON may15.county_no15 = may14.county_no14p) may15_14

LEFT  OUTER JOIN
(SELECT may2013p_id_counts.county_no county_no13p,
may2013p_id_counts.id_count id_count13p
FROM may2013p_id_counts) may13
ON may15_14.county_no15 = may13.county_no13p)