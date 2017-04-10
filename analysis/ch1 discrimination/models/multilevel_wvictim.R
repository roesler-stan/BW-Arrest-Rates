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


multilevel_wvictims <- lapply(seq_along(subsets_wvictims), function(i) {
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

  # Models to later calculate ICC
  model_arrested <- lmer(arrested ~ (1 | ori), data = subset_data)
  model_black <- lmer(black_not_white ~ (1 | ori), data = subset_data)

  print(paste0("Done with ", offense))
  list(model1, model2, model_arrested, model_black)
})


models_list = lapply(multilevel_wvictims, function(l) {list(l[[1]], l[[2]])})
htmlreg(unlist(models_list), center = F, file = 'multilevel_wvictims.doc', digits=2,
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



# Calculate ICC: variance across groups / total variance
# ORI variance / (ORI variance + residual variance)
# Be aware that ranef returns strange conditional variances: https://github.com/lme4/lme4/issues/148

# ICC when predicting offender arrest
  # Robbery: 0.224
  summary(multilevel_wvictims[[1]][[3]])
  0.04054 / (0.04054 + 0.14022)
  # Aggravated assault: 0.155
  summary(multilevel_wvictims[[2]][[3]])
  0.03813 / (0.03813 + 0.20825)
  # Simple assault: 0.180
  summary(multilevel_wvictims[[3]][[3]])
  0.04576 / (0.04576 + 0.20809)
  # Intimidation: 0.338
  summary(multilevel_wvictims[[4]][[3]])
  0.05748 / (0.05748 + 0.11241)

# ICC when predicting offender race
  # Robbery: 0.406
  summary(multilevel_wvictims[[1]][[4]])
  0.08894 / (0.08894 + 0.13013)
  # Aggravated assault: 0.245
  summary(multilevel_wvictims[[2]][[4]])
  0.05361 / (0.05361 + 0.16541)
  # Simple assault: 0.220
  summary(multilevel_wvictims[[3]][[4]])
  0.04791 / (0.04791 + 0.17008)
  # Intimidation: 0.200
  summary(multilevel_wvictims[[4]][[4]])
  0.0420 / (0.0420 + 0.1676)
  