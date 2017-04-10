setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("standardize_feature.R")
source("subsets_list.R")
setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch1 discrimination/plots")
source("correlation.R")

subsets_novictims <- subsets_list[5: length(subsets_list)]
subset_names <- names(subsets_list)[5: length(subsets_list)]
subset_names_twice <- unlist(lapply(subset_names, function(i) rep(i, 2)))
