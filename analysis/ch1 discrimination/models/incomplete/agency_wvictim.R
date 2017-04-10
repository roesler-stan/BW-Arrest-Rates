## Predict arrest rates by police agency characteristics
## Q: Why are black offenders in low-arrest police agencies?

library(plyr)
library(texreg)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("standardize_feature.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/tables")

wvictim_subsets <- list("Robbery" = robbery_data_with_victim,
                        "Aggravated Assault" = aggravated_assault_data_with_victim,
                        "Simple Assault" = simple_assault_data_with_victim,
                        "Intimidation" = intimidation_data_with_victim)

# Features to get:
# income inequality, racial segregation

arrest_rate_models <- lapply(seq_along(wvictim_subsets), function(i) {
  subset_data <- wvictim_subsets[[i]]
  offense <- names(wvictim_subsets)[[i]]
  offense <- gsub("/", "", offense)
  subset_data$victim_analyzing_female[subset_data$victim_analyzing_sex == 'female'] <- 1
  subset_data$victim_analyzing_female[subset_data$victim_analyzing_sex == 'male'] <- 0
  
  #incidents = length(unique(incident)),
  ori_data <- ddply(subset_data, .(ori), summarise,
                    arrested_pct = mean(arrested, na.rm=T) * 100,
                    offenders = sum(!is.na(arrested)),
                    offenders_black = mean(black_not_white, na.rm=T),
                    offenders_white = mean(black_not_white==0, na.rm=T),
                    offenses_per_incident = mean(recsofs, na.rm=T),
                    propoffenses_per_incident = mean(recsprp, na.rm=T),
                    vicoffenses_per_incident = mean(recsvic, na.rm=T),
                    total_residents = mean(total_residents, na.rm=T),
                    ftsworn = mean(ftsworn, na.rm=T),
                    one_race_unemp = mean(one_race_unemp, na.rm=T),
                    b_unemp = mean(b_unemp, na.rm=T),
                    w_unemp = mean(w_unemp, na.rm=T),
                    mean_inc = mean(mean_inc, na.rm=T),
                    victim_analyzing_known = mean(victim_analyzing_known, na.rm=T),
                    victim_analyzing_black_not_white = mean(victim_analyzing_black_not_white, na.rm=T),
                    victim_analyzing_age = mean(victim_analyzing_age, na.rm=T),
                    victim_analyzing_female = mean(victim_analyzing_female, na.rm=T))
  
  ori_data$total_residents_log <- log(ori_data$total_residents)
  ori_data$ftsworn_log <- log(ori_data$ftsworn)
  ori_data$mean_inc_log <- log(ori_data$mean_inc)
  
  # standardize indep. vars
  features1 <- c("offenders_black")
  features2 <- c("offenders", "offenses_per_incident", "total_residents_log",
                 "ftsworn_log", "one_race_unemp", "mean_inc",
                 "victim_analyzing_known", "victim_analyzing_black_not_white",
                 "victim_analyzing_age", "victim_analyzing_female")
  features3 <- c(features1, features2)
  for (feature in features3) {
    ori_data[, feature] <- standardize(ori_data[, feature])
  }
  # Only include agencies with all variables present
  ori_data <- na.omit(ori_data[, c("arrested_pct", features3)])
  
  model1 <- lm(arrested_pct ~ ., data=ori_data[, c("arrested_pct", features1)])
  model2 <- lm(arrested_pct ~ ., data=ori_data[, c("arrested_pct", features2)])
  model3 <- lm(arrested_pct ~ ., data=ori_data[, c("arrested_pct", features3)])
  models <- list(model1, model2, model3)
  
  htmlreg(models, file = paste0(offense, '.doc'), digits = 2,
          custom.model.names = c("Model 1", "Model 2", "Model 3"),
          caption = offense, caption.above = T,
          inline.css = FALSE, doctype = TRUE)
  models
})

