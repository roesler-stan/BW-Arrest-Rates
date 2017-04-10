## Predict varying intercepts and coefficients


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

