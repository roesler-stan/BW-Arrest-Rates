-- charges, part 5 - for arrests file only

UPDATE nibrs_arrests_12m_county SET bad_check = 1 WHERE nibrs_arrests_12m_county.ucr_offense = '90A';
UPDATE nibrs_arrests_12m_county SET loitering = 1 WHERE nibrs_arrests_12m_county.ucr_offense = '90B';
UPDATE nibrs_arrests_12m_county SET disorder = 1 WHERE nibrs_arrests_12m_county.ucr_offense = '90C';
UPDATE nibrs_arrests_12m_county SET dui = 1 WHERE nibrs_arrests_12m_county.ucr_offense = '90D';
UPDATE nibrs_arrests_12m_county SET drunk = 1 WHERE nibrs_arrests_12m_county.ucr_offense = '90E';
UPDATE nibrs_arrests_12m_county SET family_nonv = 1 WHERE nibrs_arrests_12m_county.ucr_offense = '90F';
UPDATE nibrs_arrests_12m_county SET liquor_law = 1 WHERE nibrs_arrests_12m_county.ucr_offense = '90G';
UPDATE nibrs_arrests_12m_county SET peeping_tom = 1 WHERE nibrs_arrests_12m_county.ucr_offense = '90H';
UPDATE nibrs_arrests_12m_county SET runaway = 1 WHERE nibrs_arrests_12m_county.ucr_offense = '90I';
UPDATE nibrs_arrests_12m_county SET trespass = 1 WHERE nibrs_arrests_12m_county.ucr_offense = '90J';
UPDATE nibrs_arrests_12m_county SET other_offense = 1 WHERE nibrs_arrests_12m_county.ucr_offense = '90Z';
