# Logistic regression models predicting arrest - crimes with victims
# SE's are robust to deal with clustering by agency
# I standardize the continuous features after creating each complete subset

library(rms)
library(robustbase)
library(texreg)
library(stats)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch1 discrimination/models")
# Choose subsets and variables, get useful functions
source("prepare_wvictim.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/models")


logit_wvictims <- lapply(seq_along(subsets_wvictims), function(i) {
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
  
  model1 <- lrm(arrested ~ black_not_white, x = T, y = T, data = subset_data)
  model1 <- robcov(model1, cluster=subset_data$ori)

  model2 <- lrm(arrested ~ ., x = T, y = T, data = subset_data[, c("arrested", ivs)])
  model2 <- robcov(model2, cluster=subset_data$ori)

  print(paste0("Done with ", offense))
  list(model1, model2)
})


models_list <- list(logit_wvictims[[1]][[1]], logit_wvictims[[1]][[2]],
                    logit_wvictims[[2]][[1]], logit_wvictims[[2]][[2]],
                    logit_wvictims[[3]][[1]], logit_wvictims[[3]][[2]],
                    logit_wvictims[[4]][[1]], logit_wvictims[[4]][[2]])

htmlreg(models_list, center = F, file = 'logit_wvictims.doc', digits=2,
        custom.model.names = subset_names_twice,
        caption = "Offenses with Victims", caption.above = T,
        custom.coef.names = iv_names, inline.css = FALSE, doctype = TRUE)

# Get model fit values
fit_values <- lapply(seq_along(logit_wvictims), function(i) {
  print(names(subsets_wvictims)[[i]])
  print("no controls")
  print ("AIC:")
  print(AIC(logit_wvictims[[i]][[1]]))
  print ("BIC:")
  print(BIC(logit_wvictims[[i]][[1]]))
  print ("-2LL:")
  print(logLik(logit_wvictims[[i]][[1]]))
  print("with controls")
  print ("AIC:")
  print(AIC(logit_wvictims[[i]][[2]]))
  print ("BIC:")
  print(BIC(logit_wvictims[[i]][[2]]))
  print ("-2LL:")
  print(logLik(logit_wvictims[[i]][[2]]))
})
