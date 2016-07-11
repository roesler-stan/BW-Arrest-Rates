# NOT SURE THIS IS RIGHT

library(lme4)
library(plyr)
library(ggplot2)

# Choose non-missing data for which to find the predicted values
tmpdat <- simple_assault_data[, c("arrested", "black_not_white", "w_officers_percent_standardized", 
                                  "sex", "victim_analyzing_sex", "victim_analyzing_interracial",
                                  "victim_analyzing_known", "offense_in_residence1",
                                  "tech_typ_vpat", "male_officers_percent_standardized", "bdgt_ttl_standardized",
                                  "com_bt", "hir_trn_no_p", "min_hiring_educ_gths", "ori")]
jvalues <- with(simple_assault_data, seq(from = min(w_officers_percent_standardized), to = max(w_officers_percent_standardized), length.out = 100))

# HYPOTHETICAL - if every individual had j% white oficers
# Calculate predicted probabilities for each value of % officers white
pp <- lapply(jvalues, function(j) {
  tmpdat$w_officers_percent_standardized <- j
  predict(m2_simple_assault, newdata = tmpdat, type = "response")
})

# average marginal predicted probability across a few different w_officers_percent_standardized values
sapply(pp[c(1, 20, 40, 60, 80, 100)], mean)

# get the means with lower and upper quartiles
plotdat <- t(sapply(pp, function(x) {
  c(M = mean(x), quantile(x, c(0.25, 0.75)))
}))

# Add in w_officers_percent_standardized values and convert to data frame
plotdat <- as.data.frame(cbind(plotdat, jvalues))
colnames(plotdat) <- c("PredictedProbability", "Lower", "Upper", "w_officers_percent_standardized")

ggplot(plotdat, aes(x = w_officers_percent_standardized, y = PredictedProbability)) +
  geom_linerange(aes(ymin = Lower, ymax = Upper)) + geom_line(size = 2) +
  ylim(c(0, 1)) + theme_bw()



# ADAPT BELOW
# Predictions are averaged by race and % officers white
pred_prob_means <- ddply(predicted1_ori, .(w_officers_percent_standardized_cat, black_not_white),
                         summarise, pred_prob = mean(predicted1))
pred_prob_means <- na.omit(pred_prob_means)
p <- ggplot(pred_prob_means, aes(x = w_officers_percent_standardized_cat, y = pred_prob,
                                 color = factor(black_not_white)))
xaxis_levels <- levels(simple_assault_data$w_officers_percent_standardized_cat)[seq(0, 55, 6)]
p + geom_line(aes(group = black_not_white)) + theme_bw() +
  ggtitle('Simple Assault Offenders\' \n Average Predicted Probability of Arrest') +
  xlab('% Officers White (2 SD Units)') + ylab('Average Predicted Probability') +
  scale_colour_hue("Offender Race", labels = c("White", "Black")) +
  scale_x_discrete(breaks = xaxis_levels)
# The effect is non-linear and non-monotonic b/c it's an average probability for
# individuals, and individuals differ across agencies
ggsave('pred_prob_byrace_ave1.pdf', dpi = 600, width = 12, height = 10)


p <- ggplot(predicted1_ori, aes(x = w_officers_percent_standardized_cat,
                                y = predicted1, color = factor(black_not_white)))
xaxis_levels <- levels(predicted1_ori$w_officers_percent_standardized_cat)[seq(0, 40, 5)]
p + geom_point(aes(group = black_not_white, alpha = 0.02)) + theme_bw() +
  ggtitle('Simple Assault Offenders\' \n Predicted Probability of Arrest') +
  xlab('% Officers White (2 SD Units)') + ylab('Average Predicted Probability', size = 1) +
  scale_colour_hue("Offender Race", labels = c("White", "Black")) +
  scale_x_discrete(breaks = xaxis_levels) + guides(alpha = F, size = F)
ggsave('pred_prob_byrace_raw1.pdf', dpi = 600, width = 12, height = 10)