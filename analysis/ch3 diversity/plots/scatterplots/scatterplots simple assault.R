library(ggplot2)
library(reshape2)
library(plyr)
library(gridExtra)
library(grid)
#library(Rmisc)
source("grid_arrange_legend.R")

# setwd("~/Dropbox/Mugshots Project/Code/R Analysis/NIBRS Offenders 2013/plots")
# source("multiplot.R")
setwd("~/Dropbox/Mugshots Project/Public/Output/plots")

w_officers_arrested <- ddply(simple_assault_data, .(w_officers_percent, black_not_white),
                             summarise, mean_arrested = mean(arrested) * 100,
                             sd_arrested = sd(arrested),
                             offenders_count = sum(!is.na(arrested)))

ggplot(w_officers_arrested, aes(x = w_officers_percent, y = mean_arrested,
                                     color = factor(black_not_white),
                                     size = offenders_count)) +
  geom_point(alpha = 7/10) + scale_size(range = c(1, 5), guide = 'none') +
  stat_smooth(method = "loess") +
  xlab("% Officers White") + ylab("% Offenders Arrested") +
  xlim(30, 100) + theme_bw() +
  ggtitle("Percent Simple Assault Offenders Arrested by Race and Agency % Officers White") +
  scale_colour_hue("Offender Race", labels = c("White", "Black")) + ylim(0, 100) +
  theme(axis.title = element_text(size = 6)) +
  theme(plot.title = element_text(size = 8)) + theme(axis.text = element_text(size = 6)) +
  theme(legend.title = element_text(size = 6)) + theme(legend.text = element_text(size = 4))
ggsave("wofficers_percent_arrested_simple_assault.png", dpi = 600, width = 12, height = 10)


# Individual-level arrest or non-arrest
ggplot(simple_assault_data, aes(x = w_officers_percent, y = arrested, color = factor(black_not_white))) +
    geom_point(alpha = 4/10, position = position_jitter(height = 0.1)) + 
    stat_smooth() +
    xlab("% Officers White") + ylab("Arrested") +
    xlim(30, 100) + theme_bw() + ggtitle("Simple Assault Offenders Arrested by Race and Agency % Officers White") +
    scale_colour_hue("Offender Race", labels = c("White", "Black")) + ylim(-0.4, 1.4)
ggsave("wofficers_raw_simple_assault.png", dpi = 600, width = 12, height = 10)

