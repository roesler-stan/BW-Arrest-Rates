--lemas_acs_irs_zip

SELECT *
FROM (lemas_acs_zip_0913
LEFT OUTER JOIN irs_zipinc_12
ON lemas_acs_zip_0913.zipcode = irs_zipinc_12.zipcode)