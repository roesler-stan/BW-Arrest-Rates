UPDATE am2014_charges_county SET w_state = b_state
	WHERE char_length(am2014_charges_county.w_state) = 0;

ALTER TABLE am2014_charges_county RENAME COLUMN w_state TO state;
ALTER TABLE am2014_charges_county DROP COLUMN b_state;