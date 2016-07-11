-- Table: mugshots_july_male_10p

-- DROP TABLE mugshots_july_male_10p;

CREATE TABLE mugshots_july_male_10p
(
  scraping_arrest_id integer,
  county character varying,
  state character varying,
  county_no character varying,
  name character varying,
  download_date timestamp without time zone,
  all_charges character varying,
  age double precision,
  gender character varying,
  zipcode double precision,
  date timestamp without time zone,
  birthday timestamp without time zone,
  race character varying,
  multi double precision,
  am_ind double precision,
  hispanic double precision,
  east_asian double precision,
  asian double precision,
  black double precision,
  white double precision,
  address character varying,
  page_views character varying,
  views_per_day double precision,
  views double precision,
  views_days double precision,
  views_date timestamp without time zone,
  multi_race_whisp double precision,
  multi_race_nohisp double precision,
  white_only double precision,
  am_ind_only double precision,
  asian_only double precision,
  east_asian_only double precision,
  hispanic_only double precision,
  black_only double precision,
  white_only_ighisp double precision,
  am_ind_only_ighisp double precision,
  asian_only_ighisp double precision,
  east_asian_only_ighisp double precision,
  black_only_ighisp double precision,
  black_not_white double precision,
  black_not_other_known double precision,
  racial_minority double precision,
  arrest_id character varying NOT NULL,
  date_year integer,
  date_month integer,
  CONSTRAINT mugshots_july_male_10p_pkey PRIMARY KEY (arrest_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE mugshots_july_male_10p
  OWNER TO roesler;