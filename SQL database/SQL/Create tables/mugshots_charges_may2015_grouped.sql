-- Table: mugshots_charges_may2015_grouped

-- DROP TABLE mugshots_charges_may2015_grouped;

CREATE TABLE mugshots_charges_may2015_grouped
(
  charges_arrest_id character varying NOT NULL,
  charge_string_count double precision,
  charge_coded_count double precision,
  any_charge_coded double precision,
  murder double precision, rape double precision,
 robbery double precision,
 assault double precision, burglary double precision,
 theft double precision, auto_theft double precision,
 fraud double precision, embez double precision,
 mar_poss double precision, coc_poss double precision,
 othdrug_poss double precision, mar_sale double precision,
 coc_sale double precision, othdrug_sale double precision,
 sex_offense double precision, ipv double precision, dui double precision,
 drunk_public double precision, disorder double precision,
 loiter_prowl double precision, driving double precision,
 harass_stalk double precision, child_sex_offense double precision,
 speeding double precision, reckless_driving double precision,
 no_license double precision, any_attempted double precision,
 murder_sum double precision, rape_sum double precision, robbery_sum double precision,
 assault_sum double precision, burglary_sum double precision,
 theft_sum double precision, auto_theft_sum double precision,
 fraud_sum double precision, embez_sum double precision,
 mar_poss_sum double precision, coc_poss_sum double precision,
 othdrug_poss_sum double precision, mar_sale_sum double precision,
 coc_sale_sum double precision, othdrug_sale_sum double precision,
 sex_offense_sum double precision, ipv_sum double precision, dui_sum double precision,
 drunk_public_sum double precision, disorder_sum double precision,
 loiter_prowl_sum double precision, driving_sum double precision,
 harass_stalk_sum double precision, child_sex_offense_sum double precision,
 speeding_sum double precision, reckless_driving_sum double precision,
 no_license_sum double precision, attempted_sum double precision,
  CONSTRAINT mugshots_charges_may2015_grouped_arrest_id_fkey FOREIGN KEY (charges_arrest_id)
      REFERENCES mugshots_may2015 (arrest_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)

WITH (
  OIDS=FALSE
);
ALTER TABLE mugshots_charges_may2015_grouped
  OWNER TO roesler;

-- Index: cg_arrest_id_idx

-- DROP INDEX cg_arrest_id_idx;

CREATE INDEX cg_arrest_id_idx
  ON mugshots_charges_may2015_grouped
  USING btree
  (charges_arrest_id COLLATE pg_catalog."default");


