SELECT all_races
FROM arrests_m1
--case-insensitive regex matching
WHERE arrests_m1.all_races ~* 'hisp'