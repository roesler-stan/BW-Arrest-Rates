SELECT * FROM crosswalk_12 LEFT OUTER JOIN lemas_13 ON crosswalk_12.ori9 = lemas_07.ori9
WHERE lemas_13.ori9 IS NOT NULL
LIMIT 30