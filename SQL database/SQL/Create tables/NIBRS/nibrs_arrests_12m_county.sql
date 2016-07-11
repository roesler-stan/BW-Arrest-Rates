-- Table: nibrs_arrests_12m_county

-- DROP TABLE nibrs_arrests_12m_county;

CREATE TABLE nibrs_arrests_12m_county
(
  arrest_type character varying,
  ucr_offense character varying,
  gender character varying,
  state_no character varying,
  seqno character varying,
  age double precision,
  multiple_arrests character varying,
  state character varying,
  record_type character varying,
  incident character varying,
  transaction_number character varying,
  disposition_u18 character varying,
  race character varying,
  ori character varying,
  resident_status character varying,
  number_records double precision,
  ethnicity character varying,
  incident_date character varying,
  arrest_date character varying,
  internal_offender_id double precision NOT NULL,
  ori9 character varying,
  county_no character varying,
  CONSTRAINT nibrs_arrests_12mc_pkey PRIMARY KEY (internal_offender_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_arrests_12m_county
  OWNER TO roesler;

-- Index: na_county_idx

-- DROP INDEX na_county_idx;

CREATE INDEX na_county_idx
  ON nibrs_arrests_12m_county
  USING btree
  (county_no COLLATE pg_catalog."default");