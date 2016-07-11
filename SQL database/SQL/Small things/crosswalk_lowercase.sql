ALTER TABLE crosswalk ADD COLUMN state_lowercase character varying;

UPDATE crosswalk SET state_lowercase = lower(crosswalk.state);