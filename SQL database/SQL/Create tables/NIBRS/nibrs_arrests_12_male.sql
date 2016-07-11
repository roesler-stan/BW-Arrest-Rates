-- Table: nibrs_arrests_12_male

-- DROP TABLE nibrs_arrests_12_male;

CREATE TABLE nibrs_arrests_12_male
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
  CONSTRAINT nibrs_arrests_12m_pkey PRIMARY KEY (internal_offender_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_arrests_12_male
  OWNER TO roesler;

-- Index: am_incident_ori

-- DROP INDEX am_incident_ori;

CREATE INDEX am_incident_ori
  ON nibrs_arrests_12_male
  USING btree
  (incident COLLATE pg_catalog."default", ori COLLATE pg_catalog."default");