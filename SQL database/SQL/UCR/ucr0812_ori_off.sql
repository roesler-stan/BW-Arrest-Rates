--ucr0812_ori_off
--using annual averages in agency-offense-month format
--averaging over months
--not inclusing a month count b/c it would be the count of an average over several years
SELECT
ucr0812_ori_off_month.ori,
ucr0812_ori_off_month.offense,
avg(ucr0812_ori_off_month.avg_year) avg_year,
max(ucr0812_ori_off_month.county_no) county_no,
max(ucr0812_ori_off_month.state) state,
avg(ucr0812_ori_off_month.population) ucr_pop,
avg(ucr0812_ori_off.b_arrests) b_arrests, avg(ucr0812_ori_off.w_arrests) w_arrests,
avg(ucr0812_ori_off.i_arrests) i_arrests, avg(ucr0812_ori_off.a_arrests) a_arrests,
avg(ucr0812_ori_off.h_arrests) h_arrests, avg(ucr0812_ori_off.nonh_arrests) nonh_arrests
FROM ucr0812_ori_off_month
GROUP BY ucr0812_ori_off_month.ori, ucr0812_ori_off_month.offense