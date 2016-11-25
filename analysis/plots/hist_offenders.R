require(scales)
library(ggplot2)
library(plyr)
library(grid)
library(gridExtra)
library(RColorBrewer)

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots")


p <- ggplot(dataset, aes(x = total_residents, fill  = factor(black_not_white))) +
  geom_histogram(alpha = 0.6, position = "identity", bins = 100) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("County Population (K)") + ylab("Offenders") + theme_bw() +
  ggtitle("Offenders by County Population") + scale_y_continuous(labels = scales::comma)

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS, 2013 LEMAS, and 2009-2013 ACS.  Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('hist_population.png', g, dpi = 300, width = 12, height = 10)


p <- ggplot(dataset, aes(x = total_residents, fill  = factor(black_not_white))) +
  geom_histogram(alpha = 0.6, position = "identity", bins = 100) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("County Population (K)") + ylab("Offenders") + theme_bw() +
  ggtitle("Offenders by County Population") +
  scale_y_continuous(labels = scales::comma) + scale_x_log10()

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS, 2013 LEMAS, and 2009-2013 ACS.  Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('hist_population_log.png', g, dpi = 300, width = 12, height = 10)



p <- ggplot(dataset, aes(x = ftsworn, fill  = factor(black_not_white))) +
  geom_histogram(alpha = 0.6, position = "identity", bins = 100) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("Agency's Full-Time Sworn Officers") + ylab("Offenders") + theme_bw() +
  ggtitle("Offenders by Number of Officers") + scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = scales::comma)

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS.  Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('hist_ftsworn.png', g, dpi = 300, width = 12, height = 10)



p <- ggplot(dataset, aes(x = agency_ftsworn_per_offender, fill  = factor(black_not_white))) +
  geom_histogram(alpha = 0.6, position = "identity", bins = 200) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("Agency's Full-Time Sworn Officers per Offender") + ylab("Offenders") + theme_bw() +
  ggtitle("Number of Officers per Offender") +
  scale_y_continuous(labels = scales::comma) + scale_x_log10()

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS.  Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('hist_ftsworn_per_offender.png', g, dpi = 300, width = 12, height = 10)



p <- ggplot(dataset, aes(x = agency_offenders_count, fill  = factor(black_not_white))) +
  geom_histogram(alpha = 0.6, position = "identity", bins = 100) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("Agency's Total Offenders") + ylab("Offenders") + theme_bw() +
  ggtitle("Number of Offenders in Agency") +
  scale_y_continuous(labels = scales::comma) + scale_x_continuous(labels = scales::comma)

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS.  Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('hist_agency_offenders.png', g, dpi = 300, width = 12, height = 10)



p <- ggplot(dataset, aes(x = agency_bdgt_per_offender, fill  = factor(black_not_white))) +
  geom_histogram(alpha = 0.6, position = "identity", bins = 100) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("Budget ($) per Offender") + ylab("Offenders") + theme_bw() +
  ggtitle("Offenders by Agency Budget per Offender") +
  scale_y_continuous(labels = scales::comma) + scale_x_log10(labels = scales::comma)

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS.  Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('hist_bdgt_per_offender.png', g, dpi = 300, width = 12, height = 10)



p <- ggplot(dataset, aes(x = county_bdgt_per_resident, fill  = factor(black_not_white))) +
  geom_histogram(alpha = 0.6, position = "identity", bins = 100) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("County's Police Budget ($) per Resident") + ylab("Offenders") + theme_bw() +
  ggtitle("Offenders by Counties' Police Budget per Resident") +
  scale_y_continuous(labels = scales::comma) + scale_x_log10(labels = scales::comma)

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS, and 2009-2013 ACS.  Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('hist_bdgt_per_resident.png', g, dpi = 300, width = 12, height = 10)


p <- ggplot(dataset, aes(x = county_ftsworn_per_resident, fill  = factor(black_not_white))) +
  geom_histogram(alpha = 0.6, position = "identity", bins = 100) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("County's Full-Time Officers per Resident") + ylab("Offenders") + theme_bw() +
  ggtitle("Offenders by Counties' Full-Time Officers per Resident") +
  scale_y_continuous(labels = scales::comma) + scale_x_log10(labels = scales::comma)

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS, and 2009-2013 ACS.  Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('hist_ftsworn_per_resident.png', g, dpi = 300, width = 12, height = 10)
