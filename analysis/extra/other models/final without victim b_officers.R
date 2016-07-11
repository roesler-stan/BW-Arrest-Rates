# Offenses with a victim who likely reported it prior to arrest:
# simple assault, simple assault, intimidation, robbery

library(lme4)
library("optimx")
library(texreg)
library(plyr)

setwd("~/Dropbox/Projects/Mugshots Project/Output/models")

subsets <- list(shoplifting_data, vandalism_data, drugs_narcotics_data, drug_equipment_data)

models <- lapply(subsets, function(subset) {
  model1 <- glmer(arrested ~ sex + black_not_white + (1 + black_not_white | ori),
                  data = subset, family = binomial(link = "logit"))
  model2 <- glmer(arrested ~ sex + black_not_white + b_officers_percent_standardized +
                    male_officers_percent_standardized +
                    com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths +
                    (1 + black_not_white | ori),
                  data = subset, family = binomial(link = "logit"))
  model3 <- glmer(arrested ~ sex + black_not_white * b_officers_percent_standardized +
                    male_officers_percent_standardized +
                    com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths +
                    (1 + black_not_white | ori),
                  data = subset, family = binomial(link = "logit"))
  list(model1, model2, model3)
})

ori_data <- ddply(dataset, .(ori), summarise,
                  w_officers_percent_standardized = mean(w_officers_percent_standardized),
                  b_officers_percent_standardized = mean(b_officers_percent_standardized),
                  male_officers_percent_standardized = mean(male_officers_percent_standardized),
                  bdgt_ttl_standardized = mean(bdgt_ttl_standardized),
                  ftsworn_standardized = mean(ftsworn_standardized),
                  bdgt_per_ftoff_standardized = mean(bdgt_per_ftoff_standardized),
                  com_bt = mean(com_bt),
                  tech_typ_vpat = mean(tech_typ_vpat),
                  hir_trn_no_p = mean(hir_trn_no_p),
                  min_hiring_educ_gths = mean(min_hiring_educ_gths))

# Models predicting random coefficients from individual-level models
coef_models <- lapply(models, function(model) {
  # take the second model for the subset, with controls
  random_coefs <- data.frame(ranef(model[[1]])[[1]])
  random_coefs <- rename(random_coefs, c("X.Intercept." = "intercept", 
                                         "black_not_white" = "black_not_white_coef"))
  random_coefs$ori <- rownames(random_coefs)
  coefs_ori <- merge(random_coefs, ori_data, by = "ori")
  model_coef1 <- lm(black_not_white_coef ~ b_officers_percent_standardized,
                    data = coefs_ori)
  model_coef2 <- lm(black_not_white_coef ~ b_officers_percent_standardized +
                      male_officers_percent_standardized +
                      com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths,
                    data = coefs_ori)
  list(model_coef1, model_coef2)
})
coef_models <- c(coef_models[[1]], coef_models[[2]], coef_models[[3]], coef_models[[4]])


# Only 3 and 4 have a significant effect

htmlreg(coef_models, file = 'without_victims_coef_bofficers.doc', digits = 3,
        custom.model.names = c('Shoplifting', 'Shoplifting', 'Vandalism', 'Vandalism',
                               'Drugs/Narcotics', 'Drugs/Narcotics',
                               'Drug Equipment', 'Drug Equipment'),
        caption = "Crimes without Victims", caption.above = T,
        custom.coef.names = c("Constant", "Percent Officers White",
                              "Percent Officers Male",
                              "Officers Assigned Beats", "Body Cameras",
                              "No Additional Training", "More than HS Required"),
        inline.css = FALSE, doctype = TRUE)


# Now combine the individual-level models
models_list <- c(models[[1]], models[[2]], models[[3]], models[[4]])
htmlreg(models_list, center = F, file = 'without_victims_indiv_bofficers.doc', digits = 3,
        custom.model.names = c('Shoplifting', 'Shoplifting','Shoplifting',
                               'Vandalism', 'Vandalism', 'Vandalism',
                               'Drugs/Narcotics', 'Drugs/Narcotics', 'Drugs/Narcotics',
                               'Drug Equipment', 'Drug Equipment', 'Drug Equipment'),
        caption = "Crimes without Victims", caption.above = T,
        custom.coef.names = c("Constant", "Male", "Black (ref = White)",
                              "Percent Officers White", "Percent Officers Male",
                              "Officers Assigned Beats", "Body Cameras",
                              "No Additional Training", "More than HS Required",
                              "Black x Percent Officers White"),
        inline.css = FALSE, doctype = TRUE)

# Models 2, 5, 6, and 8 do not converge (max relgrad > 0.001)
lapply(models_list, function(model) {
  model@optinfo$conv$lme4$messages
})
