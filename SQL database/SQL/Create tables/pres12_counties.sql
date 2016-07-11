-- Table: pres12_counties

-- DROP TABLE pres12_counties;

CREATE TABLE pres12_counties
(
  pres12_state character varying,
  pres12_county character varying,
  total_votes double precision,
  rep_votes double precision,
  dem_votes double precision,
  reps_percent_total double precision,
  dems_percent_total double precision,
  third_percent_total double precision,
  other_percent_total double precision,
  reps_percent_majority double precision,
  dems_percent_majority double precision,
  plurality_party character varying
)
WITH (
  OIDS=FALSE
);
ALTER TABLE pres12_counties
  OWNER TO roesler;
