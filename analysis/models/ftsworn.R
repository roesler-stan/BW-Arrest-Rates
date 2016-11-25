county_data$b_residents_percent <- (county_data$b_residents / county_data$total_residents) * 100
county_data$w_residents_percent <- (county_data$w_residents / county_data$total_residents) * 100

summary(lm(ftsworn ~ total_residents + b_residents_percent + w_residents_percent + offenders,
           data = county_data))