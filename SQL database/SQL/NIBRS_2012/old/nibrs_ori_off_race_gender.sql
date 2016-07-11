--nibrs_ori_off_race_gender

SELECT nibrs.ori ori,
nibrs.offense offense,
nibrs.race race,
nibrs.gender gender,
count(offender_id) offenders,
sum(number_offenses) total_offenses
FROM nibrs_offenders_offenses_12 as nibrs
GROUP BY nibrs.ori, nibrs.offense, nibrs.race, nibrs.gender