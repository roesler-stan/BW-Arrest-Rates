setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("standardize_feature.R")

subsets_wvictims <- list("Robbery" = robbery_data_with_victim,
                         "Aggravated Assault" = aggravated_assault_data_with_victim,
                         "Simple Assault" = simple_assault_data_with_victim,
                         "Intimidation" = intimidation_data_with_victim)

subset_names <- c("Robbery", "Aggravated Assault", "Simple Assault", "Intimidation")
subset_names_twice <- unlist(lapply(subset_names, function(i) rep(i, 2)))