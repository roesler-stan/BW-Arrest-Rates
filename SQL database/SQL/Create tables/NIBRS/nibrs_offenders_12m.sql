-- Table: nibrs_offenders_12m;

-- DROP TABLE nibrs_offenders_12m;

CREATE TABLE nibrs_offenders_12m
(
  record_type character varying,
  state_no character varying,
  state character varying,
  ori character varying,
  incident character varying,
  incident_date character varying,
  seqno double precision,
  age double precision,
  gender character varying,
  race character varying,
  number_offenses double precision,
  internal_offender_id double precision NOT NULL,
  CONSTRAINT nibrs_offenders_12m_pkey PRIMARY KEY (internal_offender_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nibrs_offenders_12m
  OWNER TO roesler;