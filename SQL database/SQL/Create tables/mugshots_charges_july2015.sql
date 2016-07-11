-- Table: mugshots_charges_july2015

-- DROP TABLE mugshots_charges_july2015;

CREATE TABLE mugshots_charges_july2015
(
  arrest_id character varying NOT NULL,
  charge character varying,
  CONSTRAINT mugshots_charges_july2015_arrest_id_fkey FOREIGN KEY (arrest_id)
      REFERENCES mugshots_july2015 (arrest_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE mugshots_charges_july2015
  OWNER TO roesler;
