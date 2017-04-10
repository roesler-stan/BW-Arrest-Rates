# Ch 1 RQ: Are black criminals more likely to be arrested than white criminals?
# Multilevel models predicting arrest with varying intercepts - crimes with victims
# I standardize the continuous features after creating each complete subset

library(lme4)
library(optimx)
library(texreg)
library(plyr)
library(Hmisc)
library(ggplot2)
library(reshape2)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch1 discrimination/models")
# Choose subsets and variables
source("prepare_wvictim.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/models")

ivs_noknown <- unlist(lapply(ivs, function(x) {
  if (x == "victim_analyzing_known") {
    return(NULL)
  }
  return(x)
}))
ivs_string <- "black_not_white + victim_analyzing_black_not_white + agency_offenders_count + mean_inc + "

iv_names <- unlist(lapply(iv_names, function(x) {
  if (x == "Victim Knew Offender") {
    return(NULL)
  }
  return(x)
}))

multilevel_wvictims <- lapply(seq_along(subsets_wvictims), function(i) {
  subset_data <- subsets_wvictims[[i]]
  subset_data <- subset(subset_data, victim_analyzing_known==1)
  offense <- names(subsets_wvictims)[[i]]
  
  # Use same, complete dataset for all three models
  all_cols <- c("arrested", "ori", ivs_noknown)
  subset_data <- subset_data[, all_cols]
  subset_data <- na.omit(subset_data)
  for (col in continuous_ivs) {
    subset_data[, col] <- standardize(subset_data[, col])
  }

  model1 <- glmer(arrested ~ black_not_white + (1 | ori),
                  data = subset_data, family = binomial)
  model2 <- glmer(paste0("arrested ~ ", ivs_string, "+ (1 | ori)"),
                  data = subset_data, family = binomial)
  
  # Models to later calculate ICC
  model_arrested <- lmer(arrested ~ (1 | ori), data = subset_data)
  model_black <- lmer(black_not_white ~ (1 | ori), data = subset_data)
  
  print(paste0("Done with ", offense))
  list(model1, model2, model_arrested, model_black)
})


models_list = lapply(multilevel_wvictims, function(l) {list(l[[1]], l[[2]])})
htmlreg(unlist(models_list), center = F, file = 'multilevel_wvictims_known.doc', digits=2,
        custom.model.names = subset_names_twice,
        caption = "Offenses with Victims", caption.above = T,
        custom.coef.names = iv_names, inline.css = FALSE, doctype = TRUE)

# Check if any models do not converge (max relgrad > 0.001)
lapply(unlist(models_list), function(model) {
  model@optinfo$conv$lme4$messages
})

# Get model fit values
fit_values <- lapply(seq_along(multilevel_wvictims), function(i) {
  print(names(subsets_wvictims)[[i]])
  print("no controls")
  print("AIC:")
  print(AIC(multilevel_wvictims[[i]][[1]]))
  print("BIC:")
  print(BIC(multilevel_wvictims[[i]][[1]]))
  print("-2LL:")
  print(logLik(multilevel_wvictims[[i]][[1]]))
  print("with controls")
  print("AIC:")
  print(AIC(multilevel_wvictims[[i]][[2]]))
  print("BIC:")
  print(BIC(multilevel_wvictims[[i]][[2]]))
  print("-2LL:")
  print(logLik(multilevel_wvictims[[i]][[2]]))
})

