# KDE plots by officers white and arrest status
library(ggplot2)
library(plyr)
library(grid)
library(gridExtra)
library(RColorBrewer)
library(scales)

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots/kde")

p <- ggplot(dataset, aes(x = w_officers_percent)) +
  geom_density(aes(fill = factor(black_not_white)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Offenders by Percent Officers White")

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS.  Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('kde_w_officers.png', g, dpi = 300, width = 12, height = 10)


p <- ggplot(dataset, aes(x = bdgt_ttl)) +
  geom_density(aes(fill = factor(black_not_white)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("Total Budget (M)") + ylab("Density") + theme_bw() +
  ggtitle("Offenders by Agency Budget")

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS.  Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('kde_bdgt.png', g, dpi = 300, width = 12, height = 10)


p <- ggplot(dataset, aes(x = total_residents)) +
  geom_density(aes(fill = factor(black_not_white)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("County Population (K)") + ylab("Density") + theme_bw() +
  ggtitle("Offenders by County Population")

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS, 2013 LEMAS, and 2009-2013 ACS.  Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('kde_population.png', g, dpi = 300, width = 12, height = 10)



p <- ggplot(dataset, aes(x = agency_bdgt_per_offender)) +
  geom_density(aes(fill = factor(black_not_white)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("Budget ($) per Offender") + ylab("Density") + theme_bw() +
  ggtitle("Offenders by Agency Budget per Offender") +
  scale_x_log10(labels = scales::comma)

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS.  Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('kde_bdgt_per_offender.png', g, dpi = 600, width = 12, height = 10)

ggplot(dataset, aes(x = agency_bdgt_per_offender)) +
  geom_histogram(bins = 150, stat = "bin") + xlim(0, 170000)


p <- ggplot(dataset, aes(x = agency_arrest_rate)) +
  geom_density(aes(fill = factor(black_not_white)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("Agency Arrest Rate") + ylab("Density") + theme_bw() +
  ggtitle("Offenders by Agency Arrest Rate")

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and 2013 LEMAS. Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('kde_arrest_rate.png', g, dpi = 300, width = 12, height = 10)


p <- ggplot(drugs_narcotics_data, aes(x = agency_arrest_rate)) +
  geom_density(aes(fill = factor(black_not_white)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("Agency Arrest Rate") + ylab("Density") + theme_bw() +
  ggtitle("Drugs/Narcotics Offenders by Agency Arrest Rate")

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and 2013 LEMAS. Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('kde_arrest_rate_drugs_narcotics.png', g, dpi = 300, width = 12, height = 10)



p <- ggplot(robbery_data, aes(x = agency_arrest_rate)) +
  geom_density(aes(fill = factor(black_not_white)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
  xlab("Agency Arrest Rate") + ylab("Density") + theme_bw() +
  ggtitle("Robbery Offenders by Agency Arrest Rate")

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and 2013 LEMAS. Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('kde_arrest_rate_robbery.png', g, dpi = 300, width = 12, height = 10)
