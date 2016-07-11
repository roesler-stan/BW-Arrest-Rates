library(ggplot2)
library(plyr)
library(gridExtra)
library(grid)
library("RColorBrewer")

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots")

w_officers_arrested <- ddply(robbery_data, .(w_officers_percent, black_not_white),
                               summarise, mean_arrested = mean(arrested) * 100,
                               sd_arrested = sd(arrested),
                               offenders_count = sum(!is.na(arrested)))

p <- ggplot(w_officers_arrested, aes(x = w_officers_percent, y = mean_arrested,
                                     color = factor(black_not_white),
                                     size = offenders_count)) +
  geom_point(alpha = 9/10) + scale_size(range = c(3, 7), guide = 'none') +
  stat_smooth(method = "loess", se = F, size = 3) +
  xlab("Percent Officers White") + ylab("Percent Robbery Offenders Arrested") +
  xlim(30, 100) + ylim(0, 100) + theme_bw() +
  theme(axis.text.x = element_text(size = 12),
        axis.title = element_text(size = 16),
        plot.title = element_text(size = 18)) +
  ggtitle("Percent Robbery Offenders Arrested by Agencies' Percent Officers White") +
  scale_color_brewer(name = "Offender Race", palette = "Accent", labels = c("White", "Black"))

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS offenders data and 2013 LEMAS police data. Offenders arrested for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations.",
                                    x = unit(0.02, "npc"), just = "left",
                                    gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("wofficers_percent_arrested_robbery.png", plot = g, dpi = 300, width = 12, height = 10)


# Individual-level arrest or non-arrest
p <- ggplot(robbery_data, aes(x = w_officers_percent, y = arrested, color = factor(black_not_white))) +
  geom_point(alpha = 4/10, position = position_jitter(height = 0.1)) + 
  stat_smooth(se = F) +
  xlab("Percent Officers White") + ylab("Arrested") +
  xlim(30, 100) + theme_bw() + ggtitle("Robbery Offenders Arrested by Agencies' Percent Officers White") +
  scale_color_brewer(name = "Offender Race", palette = "Accent", labels = c("White", "Black"))

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS offenders data and 2013 LEMAS police data. Offenders arrested for offenses other than the offense examined are omitted.\nLines are generalized additive models (GAM) fit to the observations.",
                                    x = unit(0.02, "npc"), just = "left",
                                    gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("wofficers_raw_robbery.png", plot = g, dpi = 300, width = 12, height = 10)
