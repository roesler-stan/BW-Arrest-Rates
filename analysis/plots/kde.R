# KDE plots by officers white and arrest status
library(ggplot2)
library(plyr)
library(grid)
library(gridExtra)
library("RColorBrewer")
library(plyr)

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots")

p <- ggplot(dataset, aes(x = w_officers_percent)) +
  geom_density(aes(fill = factor(black_not_white)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Race", palette = "Set3", labels = c("White", "Black")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Offenders by Percent Officers White")

g <- arrangeGrob(p, sub = textGrob("Note: Data are from merged data set, particularly 2013 NIBRS offenders data and 2013 LEMAS police data. Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('kde_w_officers.png', g, dpi = 300, width = 12, height = 10)


p <- ggplot(dataset, aes(x = bdgt_ttl)) +
  geom_density(aes(fill = factor(black_not_white)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Race", palette = "Set3", labels = c("White", "Black")) +
  xlab("Total Budget (M)") + ylab("Density") + theme_bw() +
  ggtitle("Offenders by Agency Budget")

g <- arrangeGrob(p, sub = textGrob("Note: Data are from merged data set, particularly 2013 NIBRS offenders data and 2013 LEMAS police data. Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('kde_bdgt.png', g, dpi = 300, width = 12, height = 10)



p <- ggplot(dataset, aes(x = agency_bdgt_per_offender)) +
  geom_density(aes(fill = factor(black_not_white)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Race", palette = "Set3", labels = c("White", "Black")) +
  xlab("Budget ($) per Offender") + ylab("Density") + theme_bw() +
  ggtitle("Offenders by Agency Budget per Offender") + xlim(0, 15000)

g <- arrangeGrob(p, sub = textGrob("Note: Data are from merged data set, particularly 2013 NIBRS offenders data and 2013 LEMAS police data. Counts of offenders are smoothed using kernel density estimation.\nTo improve visualization, 61 agencies with a budget greater than $15,000 per offender have been omitted.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('kde_bdgt_per_offender.png', g, dpi = 600, width = 12, height = 10)

# Check how many agencies are not shown (budget_per_off > 15000): 61
agency_data <- ddply(dataset, .(ori),
                             summarise, agency_bdgt_per_offender = mean(agency_bdgt_per_offender))
sum(agency_data$agency_bdgt_per_offender > 15000, na.rm = T)


# by Gender, showing that factoring by color shows density within each group
# (there are many fewer females but they are represented as as frequent as males)
ggplot(subset(dataset, !is.na(dataset$sex)), aes(x = w_officers_percent)) +
  geom_density(aes(fill = factor(sex)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Gender", palette = "OrRd", labels = c("Female", "Male")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Offenders by Percent Officers White")





ori_data <- ddply(dataset, .(ori), summarise, arrest_rate = mean(arrested) * 100)
dataset <- merge(dataset, ori_data, by = "ori")

p <- ggplot(dataset, aes(x = arrest_rate)) +
  geom_density(aes(fill = factor(black_not_white)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Race", palette = "Set3", labels = c("White", "Black")) +
  xlab("Agency Arrest Rate") + ylab("Density") + theme_bw() +
  ggtitle("Offenders by Agency Arrest Rate")

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and 2013 LEMAS. Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('kde_arrest_rate.png', g, dpi = 300, width = 12, height = 10)


drugs_narcotics_data <- merge(drugs_narcotics_data, ori_data, by = "ori")
p <- ggplot(drugs_narcotics_data, aes(x = arrest_rate)) +
  geom_density(aes(fill = factor(black_not_white)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Race", palette = "Set3", labels = c("White", "Black")) +
  xlab("Agency Arrest Rate") + ylab("Density") + theme_bw() +
  ggtitle("Drugs/Narcotics Offenders by Agency Arrest Rate")

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and 2013 LEMAS. Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('kde_arrest_rate_drugs_narcotics.png', g, dpi = 300, width = 12, height = 10)



robbery_data <- merge(robbery_data, ori_data, by = "ori")
p <- ggplot(robbery_data, aes(x = arrest_rate)) +
  geom_density(aes(fill = factor(black_not_white)), alpha = 2/3, color = NA) +
  scale_fill_brewer(name = "Offender Race", palette = "Set3", labels = c("White", "Black")) +
  xlab("Agency Arrest Rate") + ylab("Density") + theme_bw() +
  ggtitle("Robbery Offenders by Agency Arrest Rate")

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS and 2013 LEMAS. Counts of offenders are smoothed using kernel density estimation.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave('kde_arrest_rate_robbery.png', g, dpi = 300, width = 12, height = 10)