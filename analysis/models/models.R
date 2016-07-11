setwd("~/Dropbox/Projects/Mugshots Project/Output/models")

source('final with victims.R')
source('final without victim')

save.image("~/Dropbox/Projects/Mugshots Project/Code/analysis/models.RData")

source('plot intercepts and coefs.R')
source('clustered logit.R')