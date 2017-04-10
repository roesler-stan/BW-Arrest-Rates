setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("standardize_feature.R")
setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch1 discrimination/plots")
source("correlation.R")

subsets_wvictims <- list("Robbery" = robbery_data_with_victim,
                         "Aggravated Assault" = aggravated_assault_data_with_victim,
                         "Simple Assault" = simple_assault_data_with_victim,
                         "Intimidation" = intimidation_data_with_victim)

subset_names <- c("Robbery", "Aggravated Assault", "Simple Assault", "Intimidation")
subset_names_twice <- unlist(lapply(subset_names, function(i) rep(i, 2)))

# "ftsworn_standardized", "bdgt_ttl_standardized", and "total_residents"
# are correlated with each other and # offenders
ivs <- c("black_not_white", "victim_analyzing_black_not_white", "victim_analyzing_known",
         "agency_offenders_count", "mean_inc")
continuous_ivs <- c("agency_offenders_count", "mean_inc")
ivs_string <- paste0(ivs, ' + ', collapse='')

iv_names <- c("Constant", "Offender Black (ref = White)",
              "Victim Black (ref = White)", "Victim Knew Offender",
              "Offenders Reported to Agency", "County Mean Income")
