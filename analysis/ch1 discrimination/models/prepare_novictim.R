setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("standardize_feature.R")
source("subsets_list.R")
setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch1 discrimination/plots")
source("correlation.R")

subsets_novictims <- subsets_list[5: length(subsets_list)]
subset_names <- names(subsets_list)[5: length(subsets_list)]
subset_names_twice <- unlist(lapply(subset_names, function(i) rep(i, 2)))

# "ftsworn_standardized", "bdgt_ttl_standardized", and "total_residents"
# are correlated with each other and # offenders
ivs <- c("black_not_white", "agency_offenders_count", "mean_inc")
continuous_ivs <- c("agency_offenders_count", "mean_inc")
ivs_string <- paste0(ivs, ' + ', collapse='')

iv_names <- c("Constant", "Offender Black (ref = White)",
              "Offenders Reported to Agency", "County Mean Income")
