library(rms)
library(robustbase)

model0_logit <- glmrob(arrested ~ black_not_white * w_officers_percent_standardized,
                       data = drugs_narcotics_data, family = binomial(link = "logit"),
                       x = T, y = T)
summary(model0_logit)

# Correct SEs without clustering
model0_robust_logit <- lrm(arrested ~ black_not_white * w_officers_percent_standardized,
                              x = T, y = T, data = drugs_narcotics_data)
model0_robust_logit_result <- robcov(model0_robust_logit)
model0_robust_logit_result

# Correct SEs for clustering
model0_clustered_logit <- lrm(arrested ~ black_not_white * w_officers_percent_standardized,
             x = T, y = T, data = drugs_narcotics_data)
model0_clustered_logit_result <- robcov(model0_clustered_logit, cluster = drugs_narcotics_data$ori)
model0_clustered_logit_result


subsets <- list(simple_assault_data, aggravated_assault_data, intimidation_data, robbery_data,
                shoplifting_data, vandalism_data, drugs_narcotics_data, drug_equipment_data)

# Replication of multilevel models
clogit_models <- lapply(subsets, function(subset) {
  model <- lrm(arrested ~ sex + black_not_white * w_officers_percent_standardized +
                                male_officers_percent_standardized + agency_bdgt_per_offender_standardized +
                                com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths,
                            x = T, y = T, data = subset)
  results <- robcov(model, cluster = subset$ori)
  results
})
# There is a sig. interaction effect for intimidation, but no sig. main effects
# But in the raw data, nothing is going on.

# Multilevel models + control for number of FT officers
clogit_models_police_controls <- lapply(subsets, function(subset) {
  model <- lrm(arrested ~ sex + black_not_white * w_officers_percent_standardized +
                 male_officers_percent_standardized + agency_bdgt_per_offender_standardized +
                 com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths +
                ftsworn_standardized,
               x = T, y = T, data = subset)
  results <- robcov(model, cluster = subset$ori)
  results
})

# Multilevel models + control for number of FT officers and zip code-level demographics
clogit_models_all_controls <- lapply(subsets, function(subset) {
  model <- lrm(arrested ~ sex + black_not_white * w_officers_percent_standardized +
                 male_officers_percent_standardized + agency_bdgt_per_offender_standardized +
                 com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths +
                 ftsworn_standardized + w_residents_percent_standardized +
                 mean_inc_standardized + one_race_unemp_standardized,
               x = T, y = T, data = subset)
  results <- robcov(model, cluster = subset$ori)
  results
})