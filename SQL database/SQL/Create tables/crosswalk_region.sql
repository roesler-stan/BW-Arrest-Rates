-- Table: crosswalk_region

-- DROP TABLE crosswalk_region;

CREATE TABLE crosswalk_region
(
  state character varying,
  county character varying,
  agency character varying,
  state_name character varying,
  county_number character varying,
  fmsa_no character varying,
  fmsa character varying,
  ori7 character varying,
  ori9 character varying,
  zipcode double precision,
  state_no double precision,
  county_no character varying,
  sr_state_number double precision,
  region double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE crosswalk_region
  OWNER TO roesler;