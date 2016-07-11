# average marginal probability.
#That is, across all the groups in our sample (which is hopefully representative of your population of interest), graph the average change in probability of the outcome across the range of some predictor of interest.


model1b <- glmer(arrested ~ wofficers_minusres + (1 | ori),
                        data = black_offenders, family = binomial, nAGQ = 10)
summary(model1b)

model1b_div <- glmer(arrested ~ wofficers_divres + age + tech_typ_vpat + (1 | ori),
                 data = black_offenders, family = binomial, nAGQ = 10)
summary(model1b_div)


tmpdat <- black_offenders[, c("arrested", "age", "tech_typ_vpat", "wofficers_divres", "ori")]
jvalues <- with(black_offenders, seq(from = min(wofficers_divres), to = max(wofficers_divres), length.out = 100))

# calculate predicted probabilities and store in a list
pp <- lapply(jvalues, function(j) {
  tmpdat$wofficers_divres <- j
  predict(model1b_div, newdata = tmpdat, type = "response")
})

# average marginal predicted probability across a few different wofficers_divres values
sapply(pp[c(1, 20, 40, 60, 80, 100)], mean)


# get the means with lower and upper quartiles
plotdat <- t(sapply(pp, function(x) {
  c(M = mean(x), quantile(x, c(0.25, 0.75)))
}))

# add in wofficers_divres values and convert to data frame
plotdat <- as.data.frame(cbind(plotdat, jvalues))

# better names and show the first few rows
colnames(plotdat) <- c("PredictedProbability", "Lower", "Upper", "wofficers_divres")
head(plotdat)

ggplot(plotdat, aes(x = wofficers_divres, y = PredictedProbability)) + geom_line() +
  ylim(c(0, 1)) + theme_bw()

ggplot(plotdat, aes(x = wofficers_divres, y = PredictedProbability)) +
  geom_linerange(aes(ymin = Lower, ymax = Upper)) + geom_line(size = 2) +
  ylim(c(0, 1)) + theme_bw()


# Plot predicted probabilities of arrest by wofficers_divres for values of tech_typ_vpat
# calculate predicted probabilities and store in a list
black_offenders$tech_typ_vpat <- factor(black_offenders$tech_typ_vpat)
tmpdat$tech_typ_vpat <- factor(tmpdat$tech_typ_vpat)
biprobs <- lapply(levels(black_offenders$tech_typ_vpat), function(cameras) {
  tmpdat$tech_typ_vpat[] <- cameras
  lapply(jvalues, function(j) {
    tmpdat$wofficers_divres <- j
    predict(model1b_div, newdata = tmpdat, type = "response")
  })
})

# get means and quartiles for all jvalues for each level of tech_typ_vpat
plotdat2 <- lapply(biprobs, function(X) {
  temp <- t(sapply(X, function(x) {
    c(M=mean(x), quantile(x, c(.25, .75)))
  }))
  temp <- as.data.frame(cbind(temp, jvalues))
  colnames(temp) <- c("PredictedProbability", "Lower", "Upper", "wofficers_divres")
  return(temp)
})

# collapse to one data frame
plotdat2 <- do.call(rbind, plotdat2)

plotdat2$tech_typ_vpat <- factor(rep(levels(black_offenders$tech_typ_vpat),
                                     each = length(jvalues)))

ggplot(plotdat2, aes(x = wofficers_divres, y = PredictedProbability)) +
  geom_ribbon(aes(ymin = Lower, ymax = Upper, fill = tech_typ_vpat), alpha = .15) +
  geom_line(aes(colour = tech_typ_vpat), size = 2) +
  ylim(c(0, 1)) + facet_wrap(~  tech_typ_vpat)


eff <- effect("black_not_white * w_officers_percent", model5,
              xlevels = list(w_officers_percent = -5:5, black_not_white = c(0, 1)))

eff_df <- data.frame(eff)

ggplot(eff_df) + geom_line(aes(w_officers_percent, fit, linetype = factor(black_not_white))) +
  theme_bw() + xlab("% Officers White - Mean") + ylab("Predicted Probability of Arrest") +
  scale_linetype_discrete("Offender Race", labels = c("White", "Black")) +
  ggtitle("Male Offenders' Predicted Probability of Arrest\nby % Officers White")

ggsave('model5_interaction.png')