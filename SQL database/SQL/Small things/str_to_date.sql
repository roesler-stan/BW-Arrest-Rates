ALTER TABLE mugshots2015_arrests_charges
ALTER COLUMN date SET DATA TYPE date
USING date(to_date(date::text, 'YYYY-MM-DD'));