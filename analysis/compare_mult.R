### Compare varying intercept model to regular with var for % arrested

rm(list = ls())
options(scipen=999)

rfile <- "~/Dropbox/Projects/Mugshots Project/Data/ch2.RData"
load(rfile)

library(lme4)
library(optimx)
library(texreg)
library(ggplot2)
library(rms)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch2 discretion/models")
source("prepare_arrestdf.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch2 discretion/models")

multilevel <- lapply(seq_along(subsets), function(i) {
  subset_data <- subsets[[i]]
  offense <- names(subsets)[[i]]
  offense <- gsub('/', 'or', offense)
  # skip many-same-day subsets
  if (grepl("Same-Day", offense)) {
    NULL
  }
  else {
    # Use same, complete dataset for all three models
    all_cols <- c("arrested", "ori", ivs)
    subset_data <- subset_data[, all_cols]
    subset_data <- na.omit(subset_data)
    for (col in continuous_ivs) {
      subset_data[, col] <- standardize(subset_data[, col])
    }
    
    model1 <- lrm(arrested ~ black_not_white + agency_arrest, data=subset_data)
    
    model2 <- lrm(arrested ~ black_not_white + ori, data=subset_data)

    model3 <- glmer(arrested ~ black_not_white + (1 | ori), data=subset_data, family=binomial)

    print(paste0("Done with ", offense))
    list(model1, model2, model3)
  }
})

# Model 2 takes a long time to fit and gives similar results as model 3
# Model 1 has a larger coefficient than that in Models 2 and 3
# Conclusion: including a dummy or a %Y variable for agencies in a "regular" (fixed) model
# does NOT do the same thing as a multilevel model with a varying intercept

