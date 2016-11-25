rm(list = ls())
options(scipen=999)

# Read the cleaned data from saved session
load("~/Dropbox/Projects/Mugshots Project/Data/basic.RData")
# load("~/Dropbox/Projects/Mugshots Project/Data/models.RData")
# load("~/Dropbox/Projects/Mugshots Project/Data/white_victim.RData")

# Or, read the merged and cleaned data and clean it further
setwd("~/Dropbox/Projects/Mugshots Project/Data/")
dataset <- read.csv("offenders_2013_caplg_ucr_clean2.csv")

# Proportions in each race for each sex
table(dataset$race)
prop.table(table(dataset$race, dataset$sex), 2)

# Proportions in each race for arrested and not arrested
men <- subset(dataset, sex == "male")
prop.table(table(men$race, men$arrested), 2)
men <- NULL

# Only include black and white offenders
dataset <- subset(dataset, !(is.na(black_not_white)))

# Only include male offenders
dataset <- subset(dataset, sex == 'male')

# Exclude anyone with an exceptional clearance (e.g. victim refused to cooperate): -6 means not exceptional
dataset <- subset(dataset, cleared_exceptionally == -6)

# Only include offenders with a white victim
# dataset <- subset(dataset, victim_analyzing_race == 'white')


setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("create_vars.R")
source("as_numeric.R")
source("remove_na.R")
source("standardize_vars.R")
source("subsets.R")
source("subsets with victims.R")
source("remove_sparse.R")

save.image("~/Dropbox/Projects/Mugshots Project/Data/basic.RData")