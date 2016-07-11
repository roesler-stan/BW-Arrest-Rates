-- Table: april2015_compare

-- DROP TABLE april2015_compare;

CREATE TABLE april2015_compare
(
  dataset character varying,
  white_only double precision,
  black_only double precision,
  gender character varying
)
WITH (
  OIDS=FALSE
);
ALTER TABLE april2015_compare
  OWNER TO roesler;