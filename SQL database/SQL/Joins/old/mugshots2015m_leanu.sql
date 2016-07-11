--mugshots2015m_leanu
SELECT * FROM
(mugshots2015m_lean
LEFT OUTER JOIN ucr_counties
ON mugshots2015m_lean.county_no = ucr_counties.ucr_county_no)