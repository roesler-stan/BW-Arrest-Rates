rm(list = ls())
options(scipen=999)

rfile <- "~/Dropbox/Projects/Mugshots Project/Data/ch2.RData"
# Read the cleaned data from saved session
load(rfile)

# Or, read the merged and cleaned data and clean it further
setwd("~/Dropbox/Projects/Mugshots Project/Data/")
dataset <- read.csv("offenders_2013_caplg_ucr_clean2.csv")

# Only include black and white offenders
dataset <- subset(dataset, !(is.na(black_not_white)))

# Only include male offenders
dataset <- subset(dataset, sex == 'male')

# Exclude anyone with an exceptional clearance (e.g. victim refused to cooperate): -6 means not exceptional
dataset <- subset(dataset, cleared_exceptionally == -6)

setwd("../Code/analysis/cleaning")
source("create_vars.R")
source("as_numeric.R")
source("remove_na.R")

setwd("../ch2 discretion")
source("create_sameday.R")
source("subsets.R")
source("remove_sparse.R")
source("choose_subsets.R")

save.image(rfile)
