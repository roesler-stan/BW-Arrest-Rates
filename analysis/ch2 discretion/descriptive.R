library(plyr)

## TABLE 1 - OFFENDER CHARACTERISTICS
dim(drugs_narcotics_data)
dim(drug_equipment_data)

mean(drugs_narcotics_data$arrested, na.rm=T)
mean(drug_equipment_data$arrested, na.rm=T)

mean(drugs_narcotics_data$same_day_arrest_nona, na.rm=T)
mean(drug_equipment_data$same_day_arrest_nona, na.rm=T)

mean(drugs_narcotics_data$other_day_arrest_nona, na.rm=T)
mean(drug_equipment_data$other_day_arrest_nona, na.rm=T)

mean(drugs_narcotics_data$black_not_white, na.rm=T)
mean(drug_equipment_data$black_not_white, na.rm=T)

# offenders arrested 
mean(drugs_narcotics_data$arrested, na.rm=T)
mean(drug_equipment_data$arrested, na.rm=T)
# black offenders arrested
mean(drugs_narcotics_data$arrested[drugs_narcotics_data$black_not_white==1], na.rm=T)
mean(drug_equipment_data$arrested[drug_equipment_data$black_not_white==1], na.rm=T)
# white offenders arrested
mean(drugs_narcotics_data$arrested[drugs_narcotics_data$black_not_white==0], na.rm=T)
mean(drug_equipment_data$arrested[drug_equipment_data$black_not_white==0], na.rm=T)



## TABLE 2 - SAME-DAY RATES
cols <- c("arrested", "same_day_arrest_nona", "other_day_arrest_nona")
sapply(agency_drugs_narcotics[, cols], FUN=function(x) {mean(x, na.rm=T)})
sapply(agency_drug_equipment[, cols], FUN=function(x) {mean(x, na.rm=T)})


# Drugs/narcotics
# 91.1% of black and 89.4% of white arrestees are arrested on the same day
# If same_day_arrest isn't missing, the offender was arrested
prop.table(table(drugs_narcotics_data$black_not_white, drugs_narcotics_data$same_day_arrest), 1)

# Drug equipment
# 94.3% of black and 92.6% of white arrestees are arrested on the same day
prop.table(table(drug_equipment_data$black_not_white, drug_equipment_data$same_day_arrest), 1)

t.test(drugs_narcotics_data$black_not_white, drugs_narcotics_data$same_day_arrest,
       alternative="two.sided")

t.test(drug_equipment_data$black_not_white, drug_equipment_data$same_day_arrest,
       alternative="two.sided")


## TABLE 3 - AGENCY CHARACTERISTICS
length(unique(drugs_narcotics_data$ori))
length(unique(drug_equipment_data$ori))

grep('inc', names(drugs_narcotics_data), value=T)

agency_drugs_narcotics <- ddply(drugs_narcotics_data, .(ori), summarise,
                                offenders = sum(!is.na(arrested)),
                                mean_inc = mean(mean_inc, na.rm=T),
                                arrested = mean(arrested, na.rm=T),
                                same_day_arrest_nona = mean(same_day_arrest_nona, na.rm=T),
                                other_day_arrest_nona = mean(other_day_arrest_nona, na.rm=T))

mean(agency_drugs_narcotics$other_day_arrest_nona, na.rm=T)
sd(agency_drugs_narcotics$other_day_arrest_nona, na.rm=T)

agency_drug_equipment <- ddply(drug_equipment_data, .(ori), summarise,
                               offenders = sum(!is.na(arrested)),
                               mean_inc = mean(mean_inc, na.rm=T),
                               arrested = mean(arrested, na.rm=T),
                               same_day_arrest_nona = mean(same_day_arrest_nona, na.rm=T),
                               other_day_arrest_nona = mean(other_day_arrest_nona, na.rm=T))

