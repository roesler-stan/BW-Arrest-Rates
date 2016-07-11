--lemas_13_county
SELECT * FROM
lemas_13
LEFT OUTER JOIN (SELECT crosswalk.zipcode_text,
crosswalk.county_no
FROM crosswalk) cw
ON cw.zipcode_text = lemas_13.zipcode