--TABLE.csv
SELECT * FROM
(TABLE
LEFT OUTER JOIN (SELECT governors_2015.state gov_state,
governors_2015.party gov_party
FROM governors_2015) gov_table
ON TABLE.state = gov_table.gov_state);