--mugshots2015_arrests_charges
SELECT * FROM 
(mugshots_may2015
LEFT OUTER JOIN mugshots_charges_may2015_grouped
ON mugshots_may2015.arrest_id = mugshots_charges_may2015_grouped.charges_arrest_id)