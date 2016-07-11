#race checks

setwd("~/Dropbox/Projects/Mugshots Project/Output/")

sink("race_changes.txt")

table(dataset$black_not_white, dataset$arrestee_race)
prop.table(table(dataset$black_not_white, dataset$arrestee_race), 1)
# Given arrest
prop.table(table(dataset$black_not_white[dataset$arrested == 1], dataset$arrestee_race[dataset$arrested == 1]), 1)

prop.table(table(simple_assault_data$black_not_white[simple_assault_data$arrested == 1], simple_assault_data$arrestee_race[simple_assault_data$arrested == 1]), 1)

# Given arrest, if date arrested is not the same as date reported
race_change_subset <- subset(dataset, incident_to_arrest_days | report_to_arrest_days > 0)
race_change_subset <- subset(race_change_subset, arrestee_ethnicity != 'hispanic')
prop.table(table(race_change_subset$black_not_white, race_change_subset$arrestee_race), 1)


sink()


table(dataset$black_not_white, dataset$sex)
# 1st column is not arrested, 2nd is arrested
prop.table(table(dataset$black_not_white, dataset$arrested), 1)
