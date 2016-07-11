-- Table: nibrs_arrests_12m_county_nd

-- DROP TABLE nibrs_arrests_12m_county_nd;

CREATE TABLE nibrs_arrests_12m_county_nd
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
  CONSTRAINT nibrs_arrests_12mcnd_pkey PRIMARY KEY (internal_offender_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_arrests_12m_county_nd
  OWNER TO roesler;

-- Index: na_county_idx

-- DROP INDEX nand_county_idx;

CREATE INDEX nand_county_idx
  ON nibrs_arrests_12m_county_nd
  USING btree
  (county_no COLLATE pg_catalog."default");