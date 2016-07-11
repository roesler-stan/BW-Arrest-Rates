mean(dataset$recsofr)
mean(dataset$recsofs)
prop.table(table(dataset$recsofr))
# 68% of offenders committed the offense alone, 20% with one other offender
prop.table(table(dataset$recsofs))
# 85% of offenders committed a single offense in the incident
prop.table(table(dataset$recsarr))
# 51% of offenders weren't arrested, 37% were arrested alone, 8% arrested with one other offender
table(dataset$state)
# 37 states have data, 36 with over 1,000 offenders

sum(!is.na(dataset$incident_date))
sum(is.na(dataset$incident_date))
# Need report date indicator (V1006) to know if incident date is inc. date or report date

dataset$incident_date
dataset$arrest_date1


prop.table(table(dataset$recsofr, dataset$recsarr))

table(single_offenders$recsarr)
prop.table(table(single_offenders$recsarr))

# don't need [single_offenders$ethnicity != 'hispanic']
prop.table(table(single_offenders$black_not_white, single_offenders$arrestee_race1), 2)


sink("recsofs_msingle.txt")
table(offenders_data$recsofs)
prop.table(table(offenders_data$recsofs))
sink()

#length(unique(offenders_arrestees_data$ori))
# X agencies
