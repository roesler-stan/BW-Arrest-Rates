--acs_irs_zip
--left outer join b/c need unique zipcode key
SELECT * FROM (acs_zip_0913
LEFT OUTER JOIN irs_zipinc_12
ON acs_zip_0913.zipcode = irs_zipinc_12.zipcode);