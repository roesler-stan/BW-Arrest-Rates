--acs_counties_13_rpl_naoi
SELECT * FROM acs_counties_13_rpl_nao
LEFT OUTER JOIN
(SELECT ids.county_no15,
  ids.id_count15,
  ids.id_count14p,
  ids.id_count13p
  FROM may_id_counts as ids) ids_table
ON acs_counties_13_rpl_nao.acs_county_no = ids_table.county_no15