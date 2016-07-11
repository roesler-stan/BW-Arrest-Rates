# Offenses with a victim who likely reported it prior to arrest:
# simple assault, simple assault, intimidation, robbery

library(lme4)
library("optimx")
library(texreg)
library(plyr)

setwd("~/Dropbox/Projects/Mugshots Project/Output/models")

subsets <- list(simple_assault_data_with_victim, aggravated_assault_data_with_victim, intimidation_data_with_victim, robbery_data_with_victim)

models_wvictims <- lapply(subsets, function(subset) {
  model1 <- glmer(arrested ~ sex + black_not_white + (1 + black_not_white | ori),
                  data = subset, family = binomial(link = "logit"))
  model2 <- glmer(arrested ~ sex + black_not_white + w_officers_percent_standardized +
                    victim_analyzing_sex + victim_analyzing_interracial +
                    victim_analyzing_known + offense_in_residence1 +
                    male_officers_percent_standardized + agency_bdgt_per_offender_standardized +
                    com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths +
                    (1 + black_not_white | ori),
                  data = subset, family = binomial(link = "logit"))
  model3 <- glmer(arrested ~ sex + black_not_white * w_officers_percent_standardized +
                    victim_analyzing_sex + victim_analyzing_interracial +
                    victim_analyzing_known + offense_in_residence1 +
                    male_officers_percent_standardized + agency_bdgt_per_offender_standardized +
                    com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths +
                    (1 + black_not_white | ori),
                  data = subset, family = binomial(link = "logit"))
  list(model1, model2, model3)
})


# Combine the individual-level models and make a table
models_list_wvictims <- c(models_wvictims[[1]], models_wvictims[[2]], models_wvictims[[3]], models_wvictims[[4]])
htmlreg(models_list_wvictims, center = F, file = 'with_victims_indiv.doc', digits = 3,
        custom.model.names = c('Simple Assault', 'Simple Assault', 'Simple Assault',
                               'Aggravated Assault', 'Aggravated Assault', 'Aggravated Assault',
                               'Intimidation', 'Intimidation', 'Intimidation',
                               'Robbery', 'Robbery', 'Robbery'),
        caption = "Crimes with Victims", caption.above = T,
        custom.coef.names = c("Constant", "Male", "Black (ref = White)",
                              "Victim Male", "Victim Other Race", "Victim Known",
                              "Offense in Residence", "Percent Officers White",
                              "Percent Officers Male", "Budget ($) per Offender",
                              "Officers Assigned Beats", "Body Cameras",
                              "No Additional Training", "More than HS Required",
                              "Black x Percent Officers White"),
        inline.css = FALSE, doctype = TRUE)


# Models 3 (simple assault), 6 (aggravated assault), 8, 9 (intimidation), and 11, 12 (robbery) do not converge (max relgrad > 0.001)
lapply(models_list_wvictims, function(model) {
  model@optinfo$conv$lme4$messages
})


ori_data_with_victim <- ddply(dataset, .(ori), summarise,
                              w_officers_percent_standardized = mean(w_officers_percent_standardized),
                              b_officers_percent_standardized = mean(b_officers_percent_standardized),
                              male_officers_percent_standardized = mean(male_officers_percent_standardized),
                              bdgt_ttl_standardized = mean(bdgt_ttl_standardized),
                              ftsworn_standardized = mean(ftsworn_standardized),
                              bdgt_per_ftoff_standardized = mean(bdgt_per_ftoff_standardized),
                              agency_bdgt_per_offender_standardized = mean(agency_bdgt_per_offender_standardized),
                              com_bt = mean(com_bt),
                              tech_typ_vpat = mean(tech_typ_vpat),
                              hir_trn_no_p = mean(hir_trn_no_p),
                              min_hiring_educ_gths = mean(min_hiring_educ_gths))

# Models predicting random coefficients from individual-level models
coef_models_wvictims <- lapply(models_wvictims, function(model) {
  # take the second model for the subset, with controls
  random_coefs <- data.frame(ranef(model[[1]])[[1]])
  random_coefs <- rename(random_coefs, c("X.Intercept." = "intercept", 
                                         "black_not_white" = "black_not_white_coef"))
  random_coefs$ori <- rownames(random_coefs)
  coefs_ori <- merge(random_coefs, ori_data_with_victim, by = "ori")
  model_coef1 <- lm(black_not_white_coef ~ w_officers_percent_standardized,
                    data = coefs_ori)
  model_coef2 <- lm(black_not_white_coef ~ w_officers_percent_standardized +
                      male_officers_percent_standardized + agency_bdgt_per_offender_standardized +
                      com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths,
                    data = coefs_ori)
  list(model_coef1, model_coef2)
})
coef_models_wvictims <- c(coef_models_wvictims[[1]], coef_models_wvictims[[2]],
                          coef_models_wvictims[[3]], coef_models_wvictims[[4]])


htmlreg(coef_models_wvictims, file = 'with_victims_coef.doc', digits = 3,
        custom.model.names = c('Simple Assault', 'Simple Assault',
                               'Aggravated Assault', 'Aggravated Assault',
                               'Intimidation', 'Intimidation', 'Robbery', 'Robbery'),
        caption = "Crimes with Victims", caption.above = T,
        custom.coef.names = c("Constant", "Percent Officers White",
                              "Percent Officers Male", "Budget ($) per Offender", "Officers Assigned Beats", "Body Cameras",
                              "No Additional Training", "More than HS Required"), inline.css = FALSE, doctype = TRUE)

lapply(coef_models_wvictims, function(model) {
  AIC(model)
})


# Models predicting varying intercepts from individual-level models
intercept_models_wvictims <- lapply(models_wvictims, function(model) {
  # take the second model for the subset, with controls
  random_intercepts <- data.frame(ranef(model[[1]])[[1]])
  random_intercepts <- rename(random_intercepts, c("X.Intercept." = "intercept", 
                                         "black_not_white" = "black_not_white_coef"))
  random_intercepts$ori <- rownames(random_intercepts)
  intercepts_ori <- merge(random_intercepts, ori_data_with_victim, by = "ori")
  model_intercept1 <- lm(intercept ~ w_officers_percent_standardized,
                    data = intercepts_ori)
  model_intercept2 <- lm(intercept ~ w_officers_percent_standardized +
                      male_officers_percent_standardized + agency_bdgt_per_offender_standardized +
                      com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths,
                    data = intercepts_ori)
  list(model_intercept1, model_intercept2)
})
intercept_models_wvictims <- c(intercept_models_wvictims[[1]], intercept_models_wvictims[[2]],
                               intercept_models_wvictims[[3]], intercept_models_wvictims[[4]])


htmlreg(intercept_models_wvictims, file = 'with_victims_intercept.doc', digits = 3,
        custom.model.names = c('Simple Assault', 'Simple Assault',
                               'Aggravated Assault', 'Aggravated Assault',
                               'Intimidation', 'Intimidation', 'Robbery', 'Robbery'),
        caption = "Crimes with Victims", caption.above = T,
        custom.coef.names = c("Constant", "Percent Officers White",
                              "Percent Officers Male", "Budget ($) per Offender", "Officers Assigned Beats", "Body Cameras",
                              "No Additional Training", "More than HS Required"), inline.css = FALSE, doctype = TRUE)

lapply(intercept_models_wvictims, function(model) {
  AIC(model)
})