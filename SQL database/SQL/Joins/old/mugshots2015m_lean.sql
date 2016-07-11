--mugshots2015m_lean
SELECT * FROM
(mugshots2015m_lea
LEFT OUTER JOIN nibrs_counties
ON mugshots2015m_lea.county_no = nibrs_counties.nibrs_county_no)