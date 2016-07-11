-- Table: crosswalk_region_pres12

-- DROP TABLE crosswalk_region_pres12;

CREATE TABLE crosswalk_region_pres12
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
  region double precision,
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
ALTER TABLE crosswalk_region_pres12
  OWNER TO roesler;