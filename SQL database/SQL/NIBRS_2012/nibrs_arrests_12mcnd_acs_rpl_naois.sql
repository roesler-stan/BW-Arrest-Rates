--nibrs_arrests_12mcnd_acs_rpl_naois

SELECT * FROM
(nibrs_arrests_12m_county_nd
LEFT OUTER JOIN acs_counties_13_rpl_naois
ON nibrs_arrests_12m_county_nd.county_no = acs_counties_13_rpl_naois.acs_county_no)