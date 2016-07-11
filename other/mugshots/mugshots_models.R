library(Hmisc)
library(rms)

# latex(m1_main_results, file = "mugshots_main_cluster")
# print(m1_main_results, latex = TRUE)

m1_main <- lrm(black_not_white ~ w_officers_percent + male_residents + percent_males_black, x = T, y = T, data = mugshots_data)

m2_main <- lrm(black_not_white ~ w_officers_percent + male_residents + percent_males_black + inc_mean +
                 binc_under20_percent + winc_under20_percent + b_unemp + w_unemp +
                 reps_percent_majority + male_officers_percent +
                 bdgt_ttl + com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths,
               x = T, y = T, data = mugshots_data)

m3_main <- lrm(black_not_white ~ w_officers_percent + male_residents + percent_males_black + inc_mean +
                 binc_under20_percent + winc_under20_percent + b_unemp + w_unemp +
                 reps_percent_majority + male_officers_percent +
                 bdgt_ttl + com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths
               + offenders_b_percent, x = T, y = T, data = mugshots_data)

m1_main_results <- robcov(m1_main, cluster = mugshots_data$county_no)
m2_main_results <- robcov(m2_main, cluster = mugshots_data$county_no)
m3_main_results <- robcov(m3_main, cluster = mugshots_data$county_no)


m1_disorder <- lrm(black_not_white ~ w_officers_percent + male_residents + percent_males_black, x = T, y = T, data = mugshots_disorder)

m2_disorder <- lrm(black_not_white ~ w_officers_percent + male_residents + percent_males_black + inc_mean +
                 binc_under20_percent + winc_under20_percent + b_unemp + w_unemp +
                 reps_percent_majority + male_officers_percent +
                 bdgt_ttl + com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths,
               x = T, y = T, data = mugshots_disorder)

m3_disorder <- lrm(black_not_white ~ w_officers_percent + male_residents + percent_males_black + inc_mean +
                 binc_under20_percent + winc_under20_percent + b_unemp + w_unemp +
                 reps_percent_majority + male_officers_percent +
                 bdgt_ttl + com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths
               + offenders_b_percent, x = T, y = T, data = mugshots_disorder)

m1_disorder_results <- robcov(m1_disorder, cluster = mugshots_disorder$county_no)
m2_disorder_results <- robcov(m2_disorder, cluster = mugshots_disorder$county_no)
m3_disorder_results <- robcov(m3_disorder, cluster = mugshots_disorder$county_no)


m1_drunk <- lrm(black_not_white ~ w_officers_percent + male_residents + percent_males_black, x = T, y = T, data = mugshots_drunk)

m2_drunk <- lrm(black_not_white ~ w_officers_percent + male_residents + percent_males_black + inc_mean +
                  binc_under20_percent + winc_under20_percent + b_unemp + w_unemp +
                  reps_percent_majority + male_officers_percent +
                  bdgt_ttl + com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths,
                x = T, y = T, data = mugshots_drunk)

m3_drunk <- lrm(black_not_white ~ w_officers_percent + male_residents + percent_males_black + inc_mean +
                 binc_under20_percent + winc_under20_percent + b_unemp + w_unemp +
                 reps_percent_majority + male_officers_percent +
                 bdgt_ttl + com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths
               + offenders_b_percent, x = T, y = T, data = mugshots_drunk)

m1_drunk_results <- robcov(m1_drunk, cluster = mugshots_drunk$county_no)
m2_drunk_results <- robcov(m2_drunk, cluster = mugshots_drunk$county_no)
m3_drunk_results <- robcov(m3_drunk, cluster = mugshots_drunk$county_no)


m1_burglary <- lrm(black_not_white ~ w_officers_percent + male_residents + percent_males_black, x = T, y = T, data = mugshots_burglary)

m2_burglary <- lrm(black_not_white ~ w_officers_percent + male_residents + percent_males_black + inc_mean +
                     binc_under20_percent + winc_under20_percent + b_unemp + w_unemp +
                     reps_percent_majority + male_officers_percent +
                     bdgt_ttl + com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths,
                   x = T, y = T, data = mugshots_burglary)

m3_burglary <- lrm(black_not_white ~ w_officers_percent + male_residents + percent_males_black + inc_mean +
                    binc_under20_percent + winc_under20_percent + b_unemp + w_unemp +
                    reps_percent_majority + male_officers_percent +
                    bdgt_ttl + com_bt + tech_typ_vpat + hir_trn_no_p + min_hiring_educ_gths
                  + offenders_b_percent, x = T, y = T, data = mugshots_burglary)

m1_burglary_results <- robcov(m1_burglary, cluster = mugshots_burglary$county_no)
m2_burglary_results <- robcov(m2_burglary, cluster = mugshots_burglary$county_no)
m3_burglary_results <- robcov(m3_burglary, cluster = mugshots_burglary$county_no)

# Print models
print("Mugshots.com Main Models")
print(m1_main_results)
print("M1 Main BIC:")
print(BIC(m1_main_results))
print("M1 Main AIC:")
print(AIC(m1_main_results))

print(m2_main_results)
print("M2 Main BIC:")
print(BIC(m2_main_results))
print("M2 Main AIC:")
print(AIC(m2_main_results))

print(m3_main_results)
print("M3 Main BIC:")
print(BIC(m3_main_results))
print("M3 Main AIC:")
print(AIC(m3_main_results))


print("Mugshots.com Disorder Models")
print(m1_disorder_results)
print("M1 Disorder BIC:")
print(BIC(m1_disorder_results))
print("M1 Disorder AIC:")
print(AIC(m1_disorder_results))

print(m2_disorder_results)
print("M2 Disorder BIC:")
print(BIC(m2_disorder_results))
print("M2 Disorder AIC:")
print(AIC(m2_disorder_results))

print(m3_disorder_results)
print("M3 Disorder BIC:")
print(BIC(m3_disorder_results))
print("M3 Disorder AIC:")
print(AIC(m3_disorder_results))


print("Mugshots.com Drunk Models")
print(m1_drunk_results)
print("M1 Drunk BIC:")
print(BIC(m1_drunk_results))
print("M1 Drunk AIC:")
print(AIC(m1_drunk_results))

print(m2_drunk_results)
print("M2 Drunk BIC:")
print(BIC(m2_drunk_results))
print("M2 Drunk AIC:")
print(AIC(m2_drunk_results))

print(m3_drunk_results)
print("M3 Drunk BIC:")
print(BIC(m3_drunk_results))
print("M3 Drunk AIC:")
print(AIC(m3_drunk_results))

print("Mugshots.com Burglary Models")
print(m1_burglary_results)
print("M1 Burglary BIC:")
print(BIC(m1_burglary_results))
print("M1 Burglary AIC:")
print(AIC(m1_burglary_results))

print(m2_burglary_results)
print("M2 Burglary BIC:")
print(BIC(m2_burglary_results))
print("M2 Burglary AIC:")
print(AIC(m2_burglary_results))

print(m3_burglary_results)
print("M3 Burglary BIC:")
print(BIC(m3_burglary_results))
print("M3 Burglary AIC:")
print(AIC(m3_burglary_results))