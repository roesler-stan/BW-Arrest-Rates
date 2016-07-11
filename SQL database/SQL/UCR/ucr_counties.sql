--ucr_counties
SELECT
	-- summing within counties, across agencies
	count(ori_table.ori) ori_count, ori_table.county_no ucr_county_no,
	sum(ori_table.ucr_pop) ucr_pop,
	sum(ori_table.b_arrests) b_arrests, sum(ori_table.w_arrests) w_arrests,
	sum(ori_table.i_arrests) i_arrests, sum(ori_table.a_arrests) a_arrests,
	sum(ori_table.h_arrests) h_arrests, sum(ori_table.nonh_arrests) nonh_arrests
	-- summing over offenses, within agencies
	FROM (SELECT
	max(ori_off.ori) ori, max(ori_off.county_no) county_no,
	avg(ori_off.ucr_pop) ucr_pop,
	sum(ori_off.b_arrests) b_arrests, sum(ori_off.w_arrests) w_arrests,
	sum(ori_off.i_arrests) i_arrests, sum(ori_off.a_arrests) a_arrests,
	sum(ori_off.h_arrests) h_arrests, sum(ori_off.nonh_arrests) nonh_arrests
	-- averaging over months, within agency-offense data
	FROM (SELECT
	max(ucr_arrests_12.county_no) county_no, 
	ucr_arrests_12.ori, ucr_arrests_12.offense,
	avg(ucr_arrests_12.population) ucr_pop,
	avg(ucr_arrests_12.black) b_arrests, avg(ucr_arrests_12.white) w_arrests,
	avg(ucr_arrests_12.indian) i_arrests, avg(ucr_arrests_12.asian) a_arrests,
	avg(ucr_arrests_12.hispanic) h_arrests, avg(ucr_arrests_12.nonhispanic) nonh_arrests
	FROM ucr_arrests_12
	GROUP BY ucr_arrests_12.ori, ucr_arrests_12.offense) ori_off
	GROUP BY ori_off.ori) ori_table
	GROUP BY ori_table.county_no