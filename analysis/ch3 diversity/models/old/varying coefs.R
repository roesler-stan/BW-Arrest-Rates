# Offenses with a victim who likely reported it prior to arrest:
# robbery, aggravated assault, simple assault, intimidation
# I standardize the continuous features after creating each complete subset

# arrested ~ black_not_white + ori

library(lme4)
library(optimx)
library(texreg)
library(plyr)
library(Hmisc)
library(ggplot2)
library(reshape2)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("standardize_feature.R")
setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch1 discrimination/plots")
source("correlation.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/models")

subsets_wvictims <- list("Robbery" = robbery_data_with_victim,
                         "Aggravated Assault" = aggravated_assault_data_with_victim,
                         "Simple Assault" = simple_assault_data_with_victim,
                         "Intimidation" = intimidation_data_with_victim)

subset_names <- c("Robbery", "Aggravated Assault", "Simple Assault", "Intimidation")

subset_names_twice <- c(rep("Robbery", 2), rep("Aggravated Assault", 2),
                        rep("Simple Assault", 2),  rep("Intimidation", 2))

# "ftsworn_standardized", "bdgt_ttl_standardized", and "total_residents"
# are correlated with each other and # offenders
ivs <- c("black_not_white", "victim_analyzing_black_not_white", "victim_analyzing_known",
         "agency_offenders_count", "mean_inc")
continuous_ivs <- c("agency_offenders_count", "mean_inc")
ivs_string <- paste(ivs, "+ ", collapse='')

iv_names <- c("Constant", "Black (ref = White)",
              "Victim Black (ref = White)", "Victim Known",
              "Offenders Reported to Agency", "County Mean Income")

models_wvictims <- lapply(seq_along(subsets_wvictims), function(i) {
  subset_data <- subsets_wvictims[[i]]
  offense <- names(subsets_wvictims)[[i]]
  
  # Use same, complete dataset for all three models
  all_cols <- c("arrested", "ori", ivs)
  subset_data <- subset_data[, all_cols]
  subset_data <- na.omit(subset_data)
  for (col in continuous_ivs) {
    subset_data[, col] <- standardize(subset_data[, col])
  }
  
  print_correlation(subset_data, offense)
  ggsave(paste0("correlations/", offense, ".png"))
  
  model1 <- glmer(arrested ~ black_not_white + (1 | ori),
                  data = subset_data, family = binomial)
  model2 <- glmer(paste0("arrested ~ ", ivs_string, "+ (1 | ori)"),
                  data = subset_data, family = binomial)
  model3 <- glmer(arrested ~ black_not_white + (1 + black_not_white | ori),
                  data = subset_data, family = binomial)
  print(paste0("Done with ", offense))
  list(model1, model2, model3)
})


# Combine the individual-level models and make a table - only varying intercept models
models_list_wvictims = unlist(lapply(models_wvictims, function(l) {c(l[[1]], l[[2]])}))
htmlreg(unlist(models_list_wvictims), center = F, file = 'with_victims_indiv.doc', digits = 3,
        custom.model.names = subset_names_twice,
        caption = "Crimes with Victims", caption.above = T,
        custom.coef.names = iv_names, inline.css = FALSE, doctype = TRUE)

# Check if any models do not converge (max relgrad > 0.001)
lapply(models_list_wvictims, function(model) {
  model@optinfo$conv$lme4$messages
})


## Choose IVs for models predicting varying coefficients and intercepts
ivs <- c("w_officers_percent", "male_officers_percent",
         "com_bt", "tech_typ_vpat", "min_hiring_educ_gths", "hir_trn_no_p",
         "agency_offenders_count", "total_residents", "mean_inc")
continuous_ivs <- c("w_officers_percent", "male_officers_percent",
                    "agency_offenders_count", "total_residents", "mean_inc")

iv_names <- c("Constant", "Percent Officers White", "Percent Officers Male",
              "Officers Assigned to Beats", "Body Cameras",
              "More than HS Required", "No Additional Training",
              "Offenders Reported to Agency", "County Residents", "County Mean Income")

ori_data_with_victim <- ddply(dataset[, c("ori", ivs)], .(ori), numcolwise(mean))


## Models predicting random coefficients from individual-level models
varying_models_wvictims <- lapply(models_wvictims, function(models) {
  # take the third model for the subset, varying coef without controls
  random_coefs <- data.frame(ranef(models[[3]])[[1]])
  random_coefs <- rename(random_coefs, c("X.Intercept." = "intercept", 
                                         "black_not_white" = "black_not_white_coef"))
  random_coefs$ori <- rownames(random_coefs)
  coefs_ori <- merge(random_coefs, ori_data_with_victim, by = "ori")
  
  for (col in continuous_ivs) {
    coefs_ori[, col] <- standardize(coefs_ori[, col])
  }
  
  model_coef <- lm(black_not_white_coef ~ .,
                   data = coefs_ori[, c("black_not_white_coef", ivs)])
  model_intercept <- lm(intercept ~ .,
                        data = coefs_ori[, c("intercept", ivs)])
  
  list(model_coef, model_intercept)
})

coef_models_wvictims = lapply(varying_models_wvictims, function(l) l[[1]])
intercept_models_wvictims = lapply(varying_models_wvictims, function(l) l[[2]])

htmlreg(coef_models_wvictims, file = 'with_victims_coef.doc', digits = 3,
        custom.model.names = subset_names,
        caption = "Crimes with Victims", caption.above = T,
        custom.coef.names = iv_names, inline.css = FALSE, doctype = TRUE)

htmlreg(intercept_models_wvictims, file = 'with_victims_intercept.doc', digits = 3,
        custom.model.names = subset_names,
        caption = "Crimes with Victims", caption.above = T,
        custom.coef.names = iv_names, inline.css = FALSE, doctype = TRUE)


## To get confidence intervals and odds ratios
model <- models_wvictims[[1]][[2]]
summary(model)
se <- sqrt(diag(vcov(model)))
# Table of estimates with 95% CI
(tab <- cbind(Est = fixef(model), LL = fixef(model) - 1.96 * se, UL = fixef(model) + 1.96 * se))
# Odds ratios
exp(tab)
