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
source("prepare_novictim.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/models")


multilevel_novictims <- lapply(seq_along(subsets_novictims), function(i) {
  subset_data <- subsets_novictims[[i]]
  offense <- names(subsets_novictims)[[i]]
  offense <- gsub('/', ' or ', offense)
  
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


models_list = lapply(multilevel_novictims, function(l) {list(l[[1]], l[[2]])})
htmlreg(unlist(models_list), center = F, file = 'multilevel_novictims.doc', digits=2,
        custom.model.names = subset_names_twice,
        caption = "Offenses without Victims", caption.above = T,
        custom.coef.names = iv_names, inline.css = FALSE, doctype = TRUE)

# Check if any models do not converge (max relgrad > 0.001)
lapply(unlist(models_list), function(model) {
  model@optinfo$conv$lme4$messages
})


# Get model fit values
fit_values <- lapply(seq_along(multilevel_novictims), function(i) {
  print(names(subsets_novictims)[[i]])
  print("no controls")
  print("AIC:")
  print(AIC(multilevel_novictims[[i]][[1]]))
  print("BIC:")
  print(BIC(multilevel_novictims[[i]][[1]]))
  print("-2LL:")
  print(logLik(multilevel_novictims[[i]][[1]]))
  print("with controls")
  print("AIC:")
  print(AIC(multilevel_novictims[[i]][[2]]))
  print("BIC:")
  print(BIC(multilevel_novictims[[i]][[2]]))
  print("-2LL:")
  print(logLik(multilevel_novictims[[i]][[2]]))
})

# Calculate ICC: variance across groups / total variance
# ORI variance / (ORI variance + residual variance)
# Be aware that ranef returns strange conditional variances: https://github.com/lme4/lme4/issues/148

# ICC when predicting offender arrest
  # Weapon: 0.14
  summary(multilevel_novictims[[1]][[3]])
  0.03191 / (0.03191 + 0.19497)
  # Shoplifting: 0.196
  summary(multilevel_novictims[[2]][[3]])
  0.04938 / (0.04938 + 0.20313)
  # Vandalism: 0.197
  summary(multilevel_novictims[[3]][[3]])
  0.03693 / (0.03693 + 0.15054)
  # Drugs / Narcotics: 0.226
  summary(multilevel_novictims[[4]][[3]])
  0.0422 / (0.0422 + 0.1445)
  # Drug Equipment: 0.352
  summary(multilevel_novictims[[5]][[3]])
  0.08578 / (0.08578 + 0.15768)
  
# ICC when predicting offender race
  # Weapon: 0.347
  summary(multilevel_novictims[[1]][[4]])
  0.08079 / (0.08079 + 0.15216)
  # Shoplifting: 0.220
  summary(multilevel_novictims[[2]][[4]])
  0.05043 / (0.05043 + 0.17918)
  # Vandalism: 0.237
  summary(multilevel_novictims[[3]][[4]])
  0.05025 / (0.05025 + 0.16194)
  # Drugs / Narcotics: 0.223
  summary(multilevel_novictims[[4]][[4]])
  0.0501 / (0.0501 + 0.1741)
  # Drug Equipment: 0.150
  summary(multilevel_novictims[[5]][[4]])
  0.02575 / (0.02575 + 0.14580)
  