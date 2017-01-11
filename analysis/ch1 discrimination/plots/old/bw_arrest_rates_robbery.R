library(ggplot2)
library(plyr)
library(reshape)
library(grid)
library(gridExtra)
library("RColorBrewer")

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots")

robbery_ratio_data <- ddply(robbery_data, .(ori, black_not_white), summarise,
                            arrested = mean(arrested, na.rm = T) * 100)

ggplot(robbery_ratio_data, aes(arrested, fill = factor(black_not_white))) +
  geom_density(alpha = 2/3, adjust = 1/5)  +
  ggtitle("Agencies' Arrest Rates by Race") + theme_bw() +
  scale_fill_hue("Offender Race", labels = c("White", "Black")) +
  xlab('Percent Offenders Arrested') + ylab('Agency Density')
ggsave('arrest_rates_kde.png', dpi = 300, width = 12, height = 10)

ggplot(robbery_ratio_data, aes(arrested, colour = factor(black_not_white))) +
  geom_freqpoly(bins = 40) +
  ggtitle("Agencies' Arrest Rates by Race") + theme_bw() +
  scale_colour_hue("Offender Race", labels = c("White", "Black")) +
  xlab('Percent Offenders Arrested') + ylab('# Agencies')
ggsave('arrest_rates_freqpoly.png', dpi = 300, width = 12, height = 10)

ggplot(robbery_ratio_data, aes(arrested, fill = factor(black_not_white))) +
  geom_histogram(bins = 40) +
  ggtitle("Agencies' Arrest Rates by Race") + theme_bw() +
  scale_fill_hue("Offender Race", labels = c("White", "Black")) +
  xlab('Percent Offenders Arrested') + ylab('# Agencies')
ggsave('arrest_rates_hist.png', dpi = 300, width = 12, height = 10)



robbery_ratio_wide <- reshape(robbery_ratio_data, timevar = "black_not_white", idvar = "ori", direction = "wide")
robbery_ratio_wide <- rename(robbery_ratio_wide, c("arrested.0" = "white_arrested", "arrested.1" = "black_arrested"))
robbery_ratio_wide$bw_ratio <- robbery_ratio_wide$black_arrested / robbery_ratio_wide$white_arrested


## Plot of arrest rate ratio (B / W)
ggplot(robbery_ratio_wide, aes(bw_ratio)) + geom_histogram(bins = 60) + theme_bw() +
  ggtitle('Black / White Arrest Rates') + xlab('Black / White Arrest Rates') + ylab('# Agencies')
ggsave('arrest_bwratio_hist.png', dpi = 300, width = 12, height = 10)

ggplot(robbery_ratio_wide, aes(bw_ratio)) + theme_bw() +
  geom_density(alpha = 2/3, adjust = 1/5) +
  ggtitle('Black / White Arrest Rates') + xlab('Black / White Arrest Rates') + ylab('# Agencies')
ggsave('arrest_bwratio_kde.png', dpi = 300, width = 12, height = 10)
