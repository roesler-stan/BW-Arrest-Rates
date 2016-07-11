CREATE VIEW cwzip_view AS
(SELECT 
  ct.ori9 ori9,
  avg(ct.zipcode) zipcode
FROM crosswalk_12 as ct
GROUP BY ct.ori9);