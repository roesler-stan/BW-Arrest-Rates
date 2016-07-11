--ucr0812_county_off_lemas
SELECT * FROM (ucr0812_county_off
LEFT OUTER JOIN lemas_counties ON ucr0812_county_off.county_no = lemas_counties.lemas_county_no);