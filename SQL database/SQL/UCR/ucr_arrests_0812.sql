--ucr_arrests_0812
--All raw data, 2007-2013 appended/unioned together
(SELECT * FROM ucr_arrests_08) UNION (SELECT * FROM ucr_arrests_09) UNION (SELECT * FROM ucr_arrests_10) UNION (SELECT * FROM ucr_arrests_11) UNION (SELECT * FROM ucr_arrests_12)