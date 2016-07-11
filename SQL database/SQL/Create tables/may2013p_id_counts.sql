-- Table: may2013p_id_counts

-- DROP TABLE may2013p_id_counts;

CREATE TABLE may2013p_id_counts
(
  county_no character varying,
  id_count double precision,
  CONSTRAINT may2013p_id_counts_pkey PRIMARY KEY (county_no)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE may2013p_id_counts
  OWNER TO roesler;
