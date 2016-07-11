ALTER TABLE crosswalk ADD COLUMN zipcode_text double precision;

UPDATE crosswalk SET zipcode_text = crosswalk.zipcode;

ALTER TABLE crosswalk ALTER COLUMN zipcode_text TYPE character varying USING (zipcode_text::double precision);