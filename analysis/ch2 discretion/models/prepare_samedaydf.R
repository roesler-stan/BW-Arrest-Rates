setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("standardize_feature.R")

subset_names <- names(subsets)
subset_names_twice <- unlist(lapply(subset_names, function(i) rep(i, 2)))
subset_names_thrice <- unlist(lapply(subset_names, function(i) rep(i, 3)))

# "ftsworn_standardized", "bdgt_ttl_standardized", and "total_residents"
# are correlated with each other and # offenders
ivs <- c("black_not_white", "agency_offenders_count", "mean_inc", "agency_same_day_arrest")
continuous_ivs <- c("agency_offenders_count", "mean_inc", "agency_same_day_arrest")
ivs_string <- paste0(ivs, ' + ', collapse='')

iv_names <- c("Constant", "Offender Black (ref = White)",
              "Offenders Reported to Agency", "County Mean Income",
              "Percent Arrests Same-Day", "Offender Black x Same-Day Arrests")
