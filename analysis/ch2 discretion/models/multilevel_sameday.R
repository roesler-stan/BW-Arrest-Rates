# Multilevel models predicting arrest with varying intercepts - crimes with victims
# I standardize the continuous features after creating each complete subset
# Run models predicting arrest by race for subset drugs_narcotics_data_sameday
# Run models predicting arrest with same_day_arrests as a feature

library(lme4)
library(optimx)
library(texreg)
library(plyr)
library(Hmisc)
library(ggplot2)
library(reshape2)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch2 discretion/models")
source("prepare_samedaydf.R")
setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch2 discretion/plots")
source("correlation.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch2 discretion/models")

multilevel <- lapply(seq_along(subsets), function(i) {
  subset_data <- subsets[[i]]
  offense <- names(subsets)[[i]]
  offense <- gsub('/', 'or', offense)
  
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
  formula3 <- paste0("arrested ~ ", ivs_string,
                     "+ black_not_white*agency_same_day_arrest + (1 | ori)")
  model3 <- glmer(formula3, data = subset_data, family = binomial)

  # Models to later calculate ICC
  model_arrested <- lmer(arrested ~ (1 | ori), data = subset_data)
  model_black <- lmer(black_not_white ~ (1 | ori), data = subset_data)

  print(paste0("Done with ", offense))
  list(model1, model2, model3, model_arrested, model_black)
})


models_list = lapply(multilevel, function(l) { list( l[[1]], l[[2]], l[[3]] ) })
htmlreg(unlist(models_list), center = F, file = 'multilevel_sameday.doc', digits=2,
        custom.model.names = subset_names_thrice,
        caption = "Multilevel Logistic Regression Models", caption.above = T,
        custom.coef.names=iv_names, inline.css=F, doctype=T)

# Check if any models do not converge (max relgrad > 0.001)
lapply(unlist(models_list), function(model) {
  model@optinfo$conv$lme4$messages
})


# Get model fit values - does not improve with more controls!
fit_values <- lapply(seq_along(multilevel), function(i) {
  print(names(subsets)[[i]])
  print("Log likelihood without controls")
  print(logLik(multilevel[[i]][[1]]))
  print("Log likelihood with controls")
  print(logLik(multilevel[[i]][[2]]))
  print("Log likelihood with interaction")
  print(logLik(multilevel[[i]][[3]]))
})

# Calculate ICC: variance across groups / total variance
# ORI variance / (ORI variance + residual variance)
# Be aware that ranef returns strange conditional variances: https://github.com/lme4/lme4/issues/148

# ICC when predicting offender arrest
  # Drugs/narcotics: 0.198
  summary(multilevel[[1]][[4]])
  0.0357 / (0.0357 + 0.145)
  # Drugs/narcotics agencies with many same-day arrests: 0.209
  summary(multilevel[[2]][[4]])
  0.03611 / (0.03611 + 0.13643)
  # Drug equipment: 0.327
  summary(multilevel[[3]][[4]])
  0.07732 / (0.07732 + 0.15908)
  # Drug equipment with many same-day arrests: 0.336
  summary(multilevel[[4]][[4]])
  0.0774 / (0.0774 + 0.1529)

# ICC when predicting offender race
  # Drugs/narcotics: 0.224
  summary(multilevel[[1]][[5]])
  0.05019 / (0.05019 + 0.17365)
  # Drugs/narcotics agencies with many same-day arrests: 0.238
  summary(multilevel[[2]][[5]])
  0.05185 / (0.05185 + 0.16637)
  # Drug equipment: 0.146
  summary(multilevel[[3]][[5]])
  0.02495 / (0.02495 + 0.14650)
  # Drug equipment with many same-day arrests: 0.146
  summary(multilevel[[4]][[5]])
  0.0266 / (0.0266 + 0.1562)
  