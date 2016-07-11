library(gmodels)
library(plyr)
library(Hmisc)

names(dataset)

sink('descriptive.txt')

print('# of Black and White offenders')
length(dataset$black_not_white)
# 775,413 offenders
print(' ')

print('# of agencies')
length(unique(dataset$ori))
# 472 agencies
print(' ')

print('# of zip codes')
length(unique(dataset$zipcode))
# 466 zip codes
print(' ')

# Description of offenders
dataset$offender_characteristics <- dataset[,c("age", "black_not_white", "arrested")]
print("Means")
sapply(dataset$offender_characteristics, mean, na.rm=T)
print(' ')

print("Standard Deviations")
sapply(dataset$offender_characteristics, sd, na.rm=T)
print(' ')

print("Counts")
sapply(dataset$offender_characteristics, length)
print(' ')

print('Arrested by Black vs. White')
CrossTable(dataset$arrested, dataset$race, prop.r = F,
           prop.c = T, prop.t = F, prop.chisq = F)


b_data <- as.matrix(black_offenders[,c("w_officers_percent", "arrested")])
rcorr(b_data, type = "pearson")

w_data <- as.matrix(white_offenders[,c("w_officers_percent", "arrested")])
rcorr(w_data, type = "pearson")

b_data <- as.matrix(black_offenders[,c("wofficers_divres", "arrested")])
rcorr(b_data, type = "pearson")

w_data <- as.matrix(white_offenders[,c("wofficers_divres", "arrested")])
rcorr(w_data, type = "pearson")

ori_race <- ddply(subset(dataset, !is.na(dataset$black_not_white)), .(ori, black_not_white),
                  summarize, mean_arrested = mean(arrested) * 100)

# At the agency level, the black arrest rate is higher than the white rate
tapply(ori_race$mean_arrested, ori_race$black_not_white, FUN = mean, na.rm=TRUE)


theft_ori_race <- ddply(subset(theft_general_data, !is.na(theft_general_data$black_not_white)), .(ori, black_not_white),
                  summarize, mean_arrested = mean(arrested) * 100)

# At the agency level, the black arrest rate for theft is higher than the white rate
tapply(theft_ori_race$mean_arrested, theft_ori_race$black_not_white, FUN = mean, na.rm=TRUE)





# Compare offenders and arrestees' race
print('Offenders black_not_white vs. arrestee race, all offenders')
prop.table(table(dataset$black_not_white, dataset$arrestee_race1), 1)
print('Offenders black_not_white vs. arrestee race, theft offenders')
prop.table(table(theft_general_data$black_not_white, theft_general_data$arrestee_race1), 1)
print(' ')

print('Offenders black_not_white vs. arrestee race, offenders arrested')
prop.table(table(dataset$black_not_white[dataset$arrested == 1 & dataset$ethnicity != "hispanic"],
                 dataset$arrestee_race1[dataset$arrested == 1 & dataset$ethnicity != "hispanic"]), 1)
print(' ')
print('Offenders black_not_white vs. arrestee race, theft offenders arrested')
prop.table(table(theft_general_data$black_not_white[theft_general_data$arrested == 1 & theft_general_data$ethnicity != "hispanic"],
                 theft_general_data$arrestee_race1[theft_general_data$arrested == 1 & theft_general_data$ethnicity != "hispanic"]), 1)
print(' ')

print("Agencies' Mean and SD in Arrest Rates")
mean(tapply(dataset$arrested, dataset$ori, FUN = mean, na.rm=TRUE), na.rm = TRUE)
sd(tapply(dataset$arrested, dataset$ori, FUN = mean, na.rm=TRUE), na.rm = TRUE)
boxplot(tapply(dataset$arrested, dataset$ori, FUN = mean, na.rm=TRUE))
# Same as below
ori_arrest_rates <- ddply(dataset, ~ori, summarise, mean = mean(arrested), sd = sd(arrested))
# variation in arrest rates across agencies
sd(ori_arrest_rates$mean)
# variation within agencies
mean(ori_arrest_rates$sd)


sink()


# tapply(dataset$arrested, dataset$black_not_white, FUN = mean, na.rm=TRUE)

# Ethnicity is rarely recorded
print('Race by ethnicity')
prop.table(table(dataset$race, dataset$ethnicity), 1)

print('Arrested by ethnicity')
prop.table(table(dataset$ethnicity, dataset$arrested), 1)
