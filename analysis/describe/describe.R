rm(list = ls())
options(scipen=999)

setwd("~/Dropbox/Projects/Mugshots Project/Data/")
dataset <- read.csv("offenders_2013_caplg_ucr_clean2.csv")

# Proportions in each race for each sex
race_table <- table(dataset$race)
prop.table(table(dataset$race, dataset$sex), 2)
write.csv(race_table, "race_prop.csv")

# Proportions in each race for arrested and not arrested
men <- subset(dataset, sex == "male")
men_table <- table(men$race, men$arrested)
write.csv(men_table, "men_race_prop.csv")
prop.table(men_table, 2)
men <- NULL
