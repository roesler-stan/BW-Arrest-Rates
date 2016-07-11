CREATE VIEW cw_ori_county_view AS
(SELECT 
  ct.ori9 ori9,
  max(ct.state_name) state_name,
  max(ct.county_no) cw_county_no
FROM crosswalk_12 as ct
GROUP BY ct.ori9);