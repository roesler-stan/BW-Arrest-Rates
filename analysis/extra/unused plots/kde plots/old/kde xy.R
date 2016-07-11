# KDE plot at the offender level
officers_kde <- ggplot(offenders_data, aes(x = w_officers_percent))
officers_kde + geom_density()  +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Offenders")

# Histogram at the offender level
hist(offenders_data$w_officers_percent,
     main = "Distribution of % Officers White",
     breaks = 200, xlab = "% Officers White")

# Cumulative distribution At the offender level
w_officers_percent = offenders_data$w_officers_percent
w_officers_percent.ordered = sort(w_officers_percent)
n = sum(!is.na(w_officers_percent))
plot(w_officers_percent.ordered, (1:n)/n, type = 's', ylim = c(0, 1),
     xlab = '% Officers White', ylab = '',
     main = 'Empirical Cumluative Distribution of % Officers White')


# Histogram at the agency level - each agency's percentage of officers white
# Distribution is skewed but almost normal, except for high number of 100's
# almost looks like a count.
w_officers_percent_agencies <- tapply(offenders_data$w_officers_percent, offenders_data$ori, FUN = mean, na.rm=TRUE)
hist(w_officers_percent_agencies,
     main = "Distribution of % Officers White",
     breaks = 100, xlab = "% Officers White")

# Cumulative distribution at the agency level
w_officers_percent_agencies.ordered = sort(w_officers_percent_agencies)
n = sum(!is.na(w_officers_percent_agencies))
plot(w_officers_percent_agencies.ordered, (1:n)/n, type = 's', ylim = c(0, 1),
     xlab = '% Officers White', ylab = '',
     main = 'Empirical Cumluative Distribution of % Officers White')

# Looks like a beta distribution, allowing Binomial conjugate, logit model