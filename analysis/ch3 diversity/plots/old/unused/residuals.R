setwd('../residuals')

# Residuals for prediction of y by controls compared to residuals predicting x by controls
#data = subset(single_offenders, single_offenders$black_not_white == 0 & !is.na(single_offenders$wofficers_divres_normalized))
y_values_w <- resid(lm(arrested ~ age_normalized +
                         + tech_typ_vpat + male_officers_percent_normalized + bdgt_ttl_normalized + com_bt +
                         hir_trn_no_p + min_hiring_educ_gths, data = subset(drugs_general_data, drugs_general_data$black_not_white == 0)))

x_values_w <- resid(lm(w_officers_percent_normalized ~ age_normalized +
                         + tech_typ_vpat + male_officers_percent_normalized + bdgt_ttl_normalized + com_bt +
                         hir_trn_no_p + min_hiring_educ_gths, data = subset(drugs_general_data, drugs_general_data$black_not_white == 0)))

y_values_b <- resid(lm(arrested ~ age_normalized +
                         + tech_typ_vpat + male_officers_percent_normalized + bdgt_ttl_normalized + com_bt +
                         hir_trn_no_p + min_hiring_educ_gths, data = subset(drugs_general_data, drugs_general_data$black_not_white == 1)))

x_values_b <- resid(lm(w_officers_percent_normalized ~ age_normalized +
                         + tech_typ_vpat + male_officers_percent_normalized + bdgt_ttl_normalized + com_bt +
                         hir_trn_no_p + min_hiring_educ_gths, data = subset(drugs_general_data, drugs_general_data$black_not_white == 1)))

plot(x_values_w, y_values_w, type = 'n',  xlab = '% Officers White Residual',
     ylab = 'Arrested Residual', main = 'Intimidation Offenders\' Arrested Residuals\nby % Officers White Residuals')
lines(lowess(x_values_b, y_values_b), col = "red", lwd = 2)
lines(lowess(x_values_w, y_values_w), col = "blue", lwd = 2)
abline(h = 0, lty = 2, col = "grey")
legend(0.25, -0.7, legend = c("Black", "White"), fill = c("red", "blue"))
# intimidation_wofficers_arrested_residuals.png


y_values_w <- resid(lm(arrested ~ age_normalized +
                         + tech_typ_vpat + male_officers_percent_normalized + bdgt_ttl_normalized + com_bt +
                         hir_trn_no_p + min_hiring_educ_gths +
                         mean_inc + b_unemp + w_unemp + binc_under20_percent + winc_under20_percent,
                       data = subset(intimidation_data, intimidation_data$black_not_white == 0)))

x_values_w <- resid(lm(w_officers_percent_normalized ~ age_normalized +
                         + tech_typ_vpat + male_officers_percent_normalized + bdgt_ttl_normalized + com_bt +
                         hir_trn_no_p + min_hiring_educ_gths +
                         mean_inc + b_unemp + w_unemp + binc_under20_percent + winc_under20_percent,
                       data = subset(intimidation_data, intimidation_data$black_not_white == 0)))

y_values_b <- resid(lm(arrested ~ age_normalized +
                         + tech_typ_vpat + male_officers_percent_normalized + bdgt_ttl_normalized + com_bt +
                         hir_trn_no_p + min_hiring_educ_gths +
                         mean_inc + b_unemp + w_unemp + binc_under20_percent + winc_under20_percent,
                       data = subset(intimidation_data, intimidation_data$black_not_white == 1)))

x_values_b <- resid(lm(w_officers_percent_normalized ~ age_normalized +
                         + tech_typ_vpat + male_officers_percent_normalized + bdgt_ttl_normalized + com_bt +
                         hir_trn_no_p + min_hiring_educ_gths +
                         mean_inc + b_unemp + w_unemp + binc_under20_percent + winc_under20_percent,
                       data = subset(intimidation_data, intimidation_data$black_not_white == 1)))

plot(x_values_w, y_values_w, type = 'n',  xlab = '% Officers White Residual',
     ylab = 'Arrested Residual', main = 'Intimidation Offenders\' Arrested Residuals\nby % Officers White Residuals')
lines(lowess(x_values_b, y_values_b), col = "red", lwd = 2)
lines(lowess(x_values_w, y_values_w), col = "blue", lwd = 2)
abline(h = 0, lty = 2, col = "grey")
legend(1, 0.85, legend = c("Black", "White"), fill = c("red", "blue"))
dev.copy(png, 'intimdation_wofficers_arrested_residuals_winc2.png')
dev.off()


# I don't think these confidence intervals are correct
#rl = lm(y_values ~ x_values)
#y = predict(rl, se = TRUE)
#segments(x_values, y$fit + 2 * y$se.fit, x_values, y$fit - 2 * y$se.fit, col="purple")

# For black offenders b/c not sure how to do interaction
# data = subset(white_offenders, !is.na(white_offenders$wofficers_divres_normalized))
y_values <- resid(lm(arrested ~ age_normalized +
                       + tech_typ_vpat + male_officers_percent_normalized + bdgt_ttl_normalized + com_bt +
                       hir_trn_no_p + min_hiring_educ_gths, data = subset(intimidation_data, intimidation_data$black_not_white == 0)))

x_values <- resid(lm(w_officers_percent_normalized ~ age_normalized +
                       + tech_typ_vpat + male_officers_percent_normalized + bdgt_ttl_normalized + com_bt +
                       hir_trn_no_p + min_hiring_educ_gths, data = subset(intimidation_data, intimidation_data$black_not_white == 0)))

plot(x_values, y_values, type = 'p', xlab = '% Officers White Residual',
     ylab = 'Arrested Residual', main = 'White Intimidation Offenders\' Arrested Residuals\nby % Officers White Residuals')
lines(lowess(x_values, y_values), col = "red", lwd = 2)
abline(h = 0, lty = 2, col = "grey")
#('black_wofficers_arrested_residuals.png')


model <- lrm(arrested ~ black_not_white * w_officers_percent_normalized + age_normalized +
                                         + tech_typ_vpat + male_officers_percent_normalized + bdgt_ttl_normalized + com_bt +
                                         hir_trn_no_p + min_hiring_educ_gths, x = T, y = T,
                                       data = intimidation_data)
model_results <- robcov(model, cluster = intimidation_data$ori)
model_results

model_residuals <- resid(model_results)
model_predicted <- predict(model_results)


# Residuals for given x-variable's values
plot(intimidation_data$w_officers_percent_normalized, model_residuals,
     col = c("blue", "red")[1 + intimidation_data$arrested], xlab = "% Officers White (Standardized)")
lines(lowess(intimidation_data$w_officers_percent_normalized, model_residuals), col = "black", lwd = 2)
lines(lowess(intimidation_data$w_officers_percent_normalized[intimidation_data$arrested == 0], model_residuals[intimidation_data$arrested == 0]), col="blue")
lines(lowess(intimidation_data$w_officers_percent_normalized[intimidation_data$arrested == 1], model_residuals[intimidation_data$arrested == 1]), col="red")
abline(h = 0, lty = 2, col = "grey")

rl = lm(model_residuals ~ bs(intimidation_data$w_officers_percent_normalized, 8))
y = predict(rl, se = TRUE)
segments(intimidation_data$w_officers_percent_normalized, y$fit + 2 * y$se.fit, intimidation_data$w_officers_percent_normalized,
         y$fit - 2 * y$se.fit, col="purple")


# Residuals vs. Predicted in General
plot(o1_logit_predicted, o1_logit_residuals, ylab = "Residuals",
     xlab = "Predicted Values", main = "Residuals vs. Predicted Values",
     col = c("blue", "red")[1 + intimidation_data$arrested])
abline(h = 0, lty = 2, col = "grey")

# add lowess line to see what the average residuals are
lines(lowess(o1_logit_predicted, o1_logit_residuals), col="black", lwd=2)

rl = lm(o1_logit_residuals ~ bs(o1_logit_predicted, 8))
y = predict(rl, se=TRUE)
segments(o1_logit_predicted, y$fit + 2 * y$se.fit, o1_logit_predicted, y$fit - 2 * y$se.fit,
         col="purple")
