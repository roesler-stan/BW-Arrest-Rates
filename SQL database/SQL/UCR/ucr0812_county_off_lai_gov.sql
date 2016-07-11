--ucr0812_county_off_lai_gov
SELECT * FROM (ucr0812_county_off_lemas
LEFT OUTER JOIN acs_gov ON ucr0812_county_off_lemas.county_no = acs_gov.races_county_no);