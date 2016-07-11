library(ggplot2)
library(reshape2)
library(plyr)

setwd("~/Dropbox/Mugshots Project/Public/Output/plots")

# be careful, b/c this averages by officers white, which combines unkonwn numbers of people
w_officers_arrested <- ddply(simple_assault_data, .(w_officers_percent, black_not_white),
                           summarise, mean_arrested = mean(arrested) * 100,
                           sd_arrested = sd(arrested),
                           offenders_count = sum(!is.na(arrested)))

limits <- aes(ymax = mean_arrested + sd_arrested, ymin = mean_arrested - sd_arrested)

ggplot(w_officers_arrested, aes(x = w_officers_percent, y = mean_arrested,
                                color = factor(black_not_white), size = offenders_count)) +
  geom_point(alpha = 8/10) + stat_smooth(method = "loess") +
  xlab("% Officers White") + ylab("% Offenders Arrested") +
  xlim(30, 100) + theme_bw() + ggtitle("Percent Simple Assault Offenders Arrested") +
  scale_colour_hue("Offender Race", labels = c("White", "Black")) + ylim(0, 100) +
  scale_size(guide = 'none')
# + geom_errorbar(limits, position = "dodge", width = 0.2)

ggsave("simple_assault_wofficers_percent_arrested.png", dpi = 600, width = 12, height = 10)


wofficers_divres_arrested <- ddply(simple_assault_data, .(wofficers_divres, black_not_white),
                           summarise, mean_arrested = mean(arrested) * 100,
                           sd_arrested = sd(arrested),
                           offenders_count = sum(!is.na(arrested)))

limits <- aes(ymax = mean_arrested + sd_arrested, ymin = mean_arrested - sd_arrested)

ggplot(wofficers_divres_arrested, aes(x = wofficers_divres, y = mean_arrested,
                                      color = factor(black_not_white))) +
  geom_point(alpha = 8/10) + stat_smooth(method = "loess") +
  xlab("% Officers / % Residents White") + ylab("% Offenders Arrested") +
  xlim(0, 5) + ylim(0, 100) + theme_bw() + ggtitle("Percent Simple Assault Offenders Arrested") +
  scale_colour_hue("Offender Race", labels = c("White", "Black")) +
  geom_vline(xintercept = 0, col = "gray") + scale_size(guide = 'none') + xlim(0.75, 1.75)
  #geom_errorbar(limits, position = "dodge", width = 0.2)

ggsave("simple_assault_wofficers_divres_percent_arrested.pdf", dpi = 600, width = 12, height = 10)
