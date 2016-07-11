CREATE VIEW nibrs_arrests_13_nonoffenders_view AS
(SELECT * FROM nibrs_arrests_13
WHERE nibrs_arrests_13.recsofs < 1 OR nibrs_arrests_13.recsofs IS NULL);