rm(list = ls())

options(scipen=999)

# Read the merged and twice-cleaned data from saved session
# load("~/Dropbox/Projects/Mugshots Project/Code/analysis/basic.RData")
load("~/Dropbox/Projects/Mugshots Project/Code/analysis/no_exceptional.RData")
# load("~/Dropbox/Projects/Mugshots Project/Code/analysis/models.RData")
# load("~/Dropbox/Projects/Mugshots Project/Code/analysis/male.RData")
# load("~/Dropbox/Projects/Mugshots Project/Code/analysis/white_victim.RData")

# Or, read the merged and cleaned data and clean it further
setwd("~/Dropbox/Projects/Mugshots Project/Data/")
dataset <- read.csv("offenders_2013_caplg_ucr_clean2.csv")

# Only include local police
dataset <- subset(dataset, type == 1)

# To exclude anyone with an exceptional clearance
dataset <- subset(dataset, cleared_exceptionally == -6)

# To only include offenders with a white victim
# dataset <- subset(dataset, victim_analyzing_race == 'white')

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis")
source("as_numeric.R")
source("remove_na.R")
source("standardize_vars.R")
source("subsets.R")
source("subsets with victims.R")
source("remove_sparse.R")
source("cleared_exceptionally.R")

# save.image("~/Dropbox/Projects/Mugshots Project/Code/analysis/basic.RData")
save.image("~/Dropbox/Projects/Mugshots Project/Code/analysis/no_exceptional.RData")

citation()