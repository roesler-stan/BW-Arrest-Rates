-- Table: may_id_counts

-- DROP TABLE may_id_counts;

CREATE TABLE may_id_counts
(
  county_no15 character varying NOT NULL,
  id_count15 double precision,
  county_no14p character varying NOT NULL,
  id_count14p double precision,
  county_no13p character varying NOT NULL,
  id_count13p double precision,  
  CONSTRAINT may_id_counts_pkey PRIMARY KEY (county_no15)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE may_id_counts
  OWNER TO roesler;
