﻿DELETE FROM lemas_13 WHERE lemas_13.ori9 IS NULL;

ALTER TABLE lemas_13 ADD PRIMARY KEY (ori9);