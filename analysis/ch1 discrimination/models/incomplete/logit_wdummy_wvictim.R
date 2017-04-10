# Logistic regression models predicting arrest - crimes with victims
# A dummy for each agency to control for unobserved differences
# Should these models be without a constant in order to compare all agencies? (Gelman)

library(rms)
library(robustbase)
library(texreg)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch1 discrimination/models")
# Choose subsets and variables, get useful functions
source("prepare_wvictim.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/models")


logit_wdummy_wvictims <- lapply(seq_along(subsets_wvictims), function(i) {
  subset_data <- subsets_wvictims[[i]]
  offense <- names(subsets_wvictims)[[i]]
  
  # Use same, complete dataset for all three models
  all_cols <- c("arrested", "ori", ivs_indiv)
  subset_data <- subset_data[, all_cols]
  subset_data <- na.omit(subset_data)
  
  print_correlation(subset_data, offense)
  ggsave(paste0("correlations/", offense, ".png"))
  
  model1 <- lrm(arrested ~ black_not_white + ori, x = T, y = T, data = subset_data)
  model2 <- lrm(arrested ~ ., x = T, y = T, data = subset_data[, c("arrested", "ori", ivs_indiv)])

  print(paste0("Done with ", offense))
  list(model1, model2)
})


models_list <- list(logit_wdummy_wvictims[[1]][[1]], logit_wdummy_wvictims[[1]][[2]],
                    logit_wdummy_wvictims[[2]][[1]], logit_wdummy_wvictims[[2]][[2]],
                    logit_wdummy_wvictims[[3]][[1]], logit_wdummy_wvictims[[3]][[2]],
                    logit_wdummy_wvictims[[4]][[1]], logit_wdummy_wvictims[[4]][[2]])

htmlreg(models_list, center = F, file = 'logit_wdummy_wvictims.doc', digits = 3,
        custom.model.names = subset_names_twice,
        caption = "Crimes with Victims", caption.above = T,
        custom.coef.names = iv_names_indiv, inline.css = FALSE, doctype = TRUE)
