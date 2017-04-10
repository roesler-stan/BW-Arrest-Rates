# Logistic regression models predicting arrest - crimes with victims
# SE's are robust to deal with clustering by agency
# I standardize the continuous features after creating each complete subset

library(rms)
library(robustbase)
library(texreg)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch1 discrimination/models")
# Choose subsets and variables, get useful functions
source("prepare_novictim.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/models")


logit_novictim <- lapply(seq_along(subsets_novictims), function(i) {
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
  
  model1 <- lrm(arrested ~ black_not_white, x = T, y = T, data = subset_data)
  model1 <- robcov(model1, cluster=subset_data$ori)

  model2 <- lrm(arrested ~ ., x = T, y = T, data = subset_data[, c("arrested", ivs)])
  model2 <- robcov(model2, cluster=subset_data$ori)

  print(paste0("Done with ", offense))
  list(model1, model2)
})


models_list <- list(logit_novictim[[1]][[1]], logit_novictim[[1]][[2]],
                    logit_novictim[[2]][[1]], logit_novictim[[2]][[2]],
                    logit_novictim[[3]][[1]], logit_novictim[[3]][[2]],
                    logit_novictim[[4]][[1]], logit_novictim[[4]][[2]],
                    logit_novictim[[5]][[1]], logit_novictim[[5]][[2]])

htmlreg(models_list, center = F, file = 'logit_novictims.doc', digits=2,
        custom.model.names = subset_names_twice,
        caption = "Offenses without Victims", caption.above = T,
        custom.coef.names = iv_names, inline.css = FALSE, doctype = TRUE)

# Get AIC values
fit_values <- lapply(seq_along(logit_novictim), function(i) {
  print(names(subsets_novictims)[[i]])
  print("without controls")
  print("AIC:")
  print(AIC(logit_novictim[[i]][[1]]))
  print("BIC:")
  print(BIC(logit_novictim[[i]][[1]]))
  print("-2LL:")
  print(logLik(logit_novictim[[i]][[1]]))
  print("with controls")
  print("AIC:")
  print(AIC(logit_novictim[[i]][[2]]))
  print("BIC:")
  print(BIC(logit_novictim[[i]][[2]]))
  print("-2LL:")
  print(logLik(logit_novictim[[i]][[2]]))
})
