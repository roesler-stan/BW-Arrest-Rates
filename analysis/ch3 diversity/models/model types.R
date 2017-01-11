library(lme4)
library(rms)

model1_logit <- lrm(arrested ~ black_not_white * w_officers_percent_standardized,
              x = T, y = T, data = simple_assault_data)
model1_logit_results <- robcov(model1_logit, cluster = simple_assault_data$ori)
#model1_logit
model1_logit_results
AIC(model1_logit_results)
logLik(model1_logit_results)


# Random slopes are allowed to be correlated with each other
model0 <- glmer(arrested ~ black_not_white * w_officers_percent_standardized +
                  (1 | ori), data = simple_assault_data, family = binomial(link = "logit"))
summary(model0)
extractAIC(model0)
deviance(model0)
logLik(model0)


model1 <- glmer(arrested ~ black_not_white * w_officers_percent_standardized +
                  (1 + black_not_white + w_officers_percent_standardized + black_not_white * w_officers_percent_standardized | ori),
                data = simple_assault_data, family = binomial(link = "logit"))
summary(model1)
extractAIC(model1)
# 14, 1,000,095
deviance(model1)
logLik(model1)

# SDs and correlations between random-effects terms
VarCorr(model1)


model2 <- glmer(arrested ~ black_not_white * w_officers_percent_standardized +
                  tech_typ_vpat + male_officers_percent_standardized + bdgt_ttl_standardized +
                  com_bt + hir_trn_no_p + min_hiring_educ_gths +
                  (1 + black_not_white + w_officers_percent_standardized + black_not_white * w_officers_percent_standardized | ori),
                data = simple_assault_data, family = binomial(link = "logit"))
summary(model2)


model3 <- glmer(arrested ~ black_not_white * tech_typ_vpat +
                  (1 + black_not_white + tech_typ_vpat + black_not_white * tech_typ_vpat | ori),
                data = simple_assault_data, family = binomial(link = "logit"))
summary(model3)

model4 <- glmer(arrested ~ black_not_white * min_hiring_educ_gths +
                  (1 + black_not_white + min_hiring_educ_gths + black_not_white * min_hiring_educ_gths | ori),
                data = simple_assault_data, family = binomial(link = "logit"))
summary(model4)


sink('models.txt')
print('')
# log-lik, AIC, deviance
sink()

citation()
citation("rms")
citation("lme4")