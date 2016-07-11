--april2015_compare stats
SELECT 
ac.dataset dataset, sum(ac.white_only) whites, sum(ac.black_only) blacks
FROM april2015_compare as ac
WHERE ac.gender = 'male'
GROUP BY ac.dataset