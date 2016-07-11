library(ggplot2)

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots")

ggplot(dataset, aes(w_officers_percent, fill = factor(black_not_white))) +
  geom_histogram(bins = 100, position = "dodge") + theme_bw()

ggplot(dataset, aes(w_officers_percent, colour = factor(black_not_white))) +
  geom_freqpoly(binwidth = 1, size = 0.8) + theme_bw() +
  ggtitle('Offender Frequency by Agencies\' % Officers White') +
  scale_colour_hue("Offender Race", labels = c("White", "Black")) +
  xlab('% Officers White') + ylab('# Offenders')
ggsave('hist_wofficers.png', dpi = 300, width = 12, height = 10)

ggplot(dataset, aes(bdgt_ttl, colour = factor(black_not_white))) +
  geom_freqpoly(binwidth = 1, size = 0.8) + theme_bw() +
  ggtitle('Offender Frequency by Agency Budget') +
  scale_colour_hue("Offender Race", labels = c("White", "Black")) +
  xlab('Total Budget (M)') + ylab('# Offenders')
ggsave('hist_bdgt.png', dpi = 300, width = 12, height = 10)
