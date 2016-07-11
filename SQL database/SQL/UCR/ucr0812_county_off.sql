--ucr0812_county_off
--convering agency-offense monthly (annual) averages to county-offense
SELECT
ucr0812_ori_off.county_no,
ucr0812_ori_off.offense,
count(ucr0812_ori_off.ori) ori_count,
avg(ucr0812_ori_off.avg_year) avg_year,
max(ucr0812_ori_off.state) state,
avg(ucr0812_ori_off.population) ucr_pop,
avg(ucr0812_ori_off.b_arrests) b_arrests, avg(ucr0812_ori_off.w_arrests) w_arrests,
avg(ucr0812_ori_off.i_arrests) i_arrests, avg(ucr0812_ori_off.a_arrests) a_arrests,
avg(ucr0812_ori_off.h_arrests) h_arrests, avg(ucr0812_ori_off.nonh_arrests) nonh_arrests
FROM ucr0812_ori_off
GROUP BY ucr0812_ori_off.county_no, ucr0812_ori_off.offense