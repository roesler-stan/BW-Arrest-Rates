--ALTER TABLE nibrs_arrests_13m_counties ADD COLUMN arrests_county_no_text double precision;

--ALTER TABLE lemas_13 ALTER COLUMN zipcode TYPE double precision USING (zipcode::double precision);

CREATE OR REPLACE FUNCTION to_float(string_input character varying)
	RETURNS DOUBLE PRECISION AS
$BODY$
SELECT CASE WHEN trim($1) SIMILAR TO '[0-9]+' 
        THEN CAST(trim($1) AS double precision) 
    ELSE NULL END;
$BODY$
  LANGUAGE 'sql' IMMUTABLE STRICT;

ALTER TABLE nibrs_arrests_13m_counties ALTER COLUMN arrests_county_no_text TYPE double precision USING to_float(arrests_county_no);