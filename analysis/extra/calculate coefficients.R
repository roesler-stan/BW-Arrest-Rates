# Change model # depending on model examining

# coef: sum of random and fixed effects coefficients for each variable and level
coef_sums <- data.frame(coef(Eitle0_simple_assault)[[1]])
coef_sums <- rename(coef_sums, c("X.Intercept."="intercept", 
                                 "black_not_white"="black_not_white_coef"))
coef_sums$ori <- rownames(coef_sums)

ori_data <- ddply(dataset, .(ori),
                  summarise, w_officers_percent_standardized = mean(w_officers_percent_standardized),
                  w_officers_percent = mean(w_officers_percent),
                  male_officers_percent_standardized = mean(male_officers_percent_standardized),
                  bdgt_ttl_standardized = mean(bdgt_ttl_standardized),
                  ftsworn_standardized = mean(ftsworn_standardized),
                  bdgt_per_ftoff_standardized = mean(bdgt_per_ftoff_standardized),
                  bdgt_per_ftoff = mean(bdgt_per_ftoff),
                  b_residents_percent = mean(b_residents_percent),
                  w_residents_percent = mean(w_residents_percent))
# merge coefs with ori data
coefs_ori <- merge(coef_sums, ori_data, by = "ori")