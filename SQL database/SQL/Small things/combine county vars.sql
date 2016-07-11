UPDATE am2014_charges_county SET w_county_no = b_county_no
	WHERE char_length(am2014_charges_county.w_county_no) = 0;

ALTER TABLE am2014_charges_county RENAME COLUMN w_county_no TO county_no;
ALTER TABLE am2014_charges_county DROP COLUMN b_county_no;