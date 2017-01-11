## Calculate offender counts and arrest rates

dataset$agency_percent_offenders_arrested <- (dataset$agency_arrestees_count / dataset$agency_offenders_count) * 100
white_offenders$agency_percent_offenders_arrested <- (white_offenders$agency_arrestees_count / white_offenders$agency_offenders_count) * 100
black_offenders$agency_percent_offenders_arrested <- (black_offenders$agency_arrestees_count / black_offenders$agency_offenders_count) * 100


b_data <- ddply(black_offenders, .(ori), summarise,
                agency_black_offenders = sum(!is.na(arrested)),
                agency_black_arrestees = sum(arrested))
w_data <- ddply(white_offenders, .(ori), summarise,
                agency_white_offenders = sum(!is.na(arrested)),
                agency_white_arrestees = sum(arrested))
dataset <- merge(dataset, b_data, by="ori", how="left")
dataset <- merge(dataset, w_data, by="ori", how="left")
black_offenders <- merge(black_offenders, b_data, by="ori", how="left")
black_offenders <- merge(black_offenders, w_data, by="ori", how="left")
white_offenders <- merge(white_offenders, b_data, by="ori", how="left")
white_offenders <- merge(white_offenders, w_data, by="ori", how="left")

dataset$agency_percent_w_offenders_arrested <- (dataset$agency_white_arrestees / dataset$agency_white_offenders) * 100
dataset$agency_percent_b_offenders_arrested <- (dataset$agency_black_arrestees / dataset$agency_black_offenders) * 100
black_offenders$agency_percent_w_offenders_arrested <- (black_offenders$agency_white_arrestees / black_offenders$agency_white_offenders) * 100
black_offenders$agency_percent_b_offenders_arrested <- (black_offenders$agency_black_arrestees / black_offenders$agency_black_offenders) * 100
white_offenders$agency_percent_w_offenders_arrested <- (white_offenders$agency_white_arrestees / white_offenders$agency_white_offenders) * 100
white_offenders$agency_percent_b_offenders_arrested <- (white_offenders$agency_black_arrestees / white_offenders$agency_black_offenders) * 100

b_data <- NULL
w_data <- NULL