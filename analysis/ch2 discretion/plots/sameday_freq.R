library(ggplot2)
library(plyr)
library(RColorBrewer)

setwd("~/Dropbox/Projects/Mugshots Project/Output/ch2 discretion/tables")

## Same-day arrests
sum(!is.na(drugs_narcotics_data$incident_to_arrest_days))
# 131,091 values
sum(!is.na(drugs_narcotics_data$report_to_arrest_days))
#12,386 values
sum(!is.na(drugs_narcotics_data$incident_to_arrest_days) & !is.na(drugs_narcotics_data$report_to_arrest_days))
# 0 non-missing together
# So incident_to_arrest_days is more commonly known and also more meaningful as an
# indication of speed of response
# (e.g. otherwise could catch on same day as report but way after event)

ggplot(drugs_narcotics_data, aes(x=incident_to_arrest_days)) +
  geom_histogram(bins=100) + theme_classic()

ggplot(drugs_narcotics_data, aes(x=incident_to_arrest_days)) +
  geom_histogram(bins=100) + theme_classic() + scale_x_log10()

table(drugs_narcotics_data$incident_to_arrest_days == 0)
table(drugs_narcotics_data$incident_to_arrest_days == 1)
# 118,199 same-day arrests = 90.2%

# "0" row is white offenders, "1" row is black offenders
# "0" column is different-day arrests, "1" column in same-day arrests
table(drugs_narcotics_data$black_not_white, drugs_narcotics_data$same_day_arrest)
prop.table(table(drugs_narcotics_data$black_not_white, drugs_narcotics_data$same_day_arrest), 1)
# 91.1% of black and 89.4% of white offenders are arrested on the same day

prop.table(table(dataset$black_not_white, dataset$same_day_arrest), 1)
# For all offenses, 77.1% of black and 76.4% of white offenders are arrested on the same day


# Almost 1/3 of data is 100% same-day arrests
table(plot_data$same_day_arrest == 100)
table(plot_data$same_day_arrest > 98)

ggplot(plot_data, aes(x=same_day_arrest)) + geom_histogram(binwidth=1) +
  theme_classic()

# It's not that only tiny agencies have 100% same-day arrests
ggplot(plot_data, aes(x=offenders, y=same_day_arrest)) + geom_point()
