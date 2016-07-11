ALTER TABLE governors_2015 ADD COLUMN state_lowercase character varying;

UPDATE governors_2015 SET state_lowercase = lower(governors_2015.state);