--Stays at agency level, adds zipcode-level info on top
--lemas_acs_zip

SELECT *
FROM (lemas_07
LEFT OUTER JOIN acs_zip_0913
ON lemas_07.zipcode = acs_zip_0913.zipcode)