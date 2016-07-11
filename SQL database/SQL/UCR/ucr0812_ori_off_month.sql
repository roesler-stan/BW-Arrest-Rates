--ucr0812_ori_off_month
-- averaging over years, within agency-offense data

--might want to add # of years or dummies for each year
SELECT ucr_arrests_0812.month ucr_month,
ucr_arrests_0812.ori,
ucr_arrests_0812.offense,
avg(ucr_arrests_0812.year) ucr_year,
max(ucr_arrests_0812.county_no) county_no,
max(ucr_arrests_0812.state) ucr_state,
avg(ucr_arrests_0812.population) ucr_pop,
avg(ucr_arrests_0812.black) b_arrests, avg(ucr_arrests_0812.white) w_arrests,
avg(ucr_arrests_0812.indian) i_arrests, avg(ucr_arrests_0812.asian) a_arrests,
avg(ucr_arrests_0812.hispanic) h_arrests, avg(ucr_arrests_0812.nonhispanic) nonh_arrests
FROM ucr_arrests_0812
GROUP BY ucr_arrests_0812.ori, ucr_arrests_0812.offense, ucr_arrests_0812.month