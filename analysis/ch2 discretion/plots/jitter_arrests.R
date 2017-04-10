rm(list = ls())
options(scipen=999)

# Load the Ch1 data b/c need all offense subsets
rfile <- "~/Dropbox/Projects/Mugshots Project/Data/ch1.RData"
load(rfile)

library(ggplot2)
library(reshape2)
library(plyr)
library(gridExtra)
library(grid)
library(scales)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch1 discrimination/plots")
source("grid_arrange_legend.R")
setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("subsets_list.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch2 discretion/plots")

plot_data <- data.frame()
plots_list <- lapply(seq_along(subsets_list), function(i) {
  subset_name <- names(subsets_list)[[i]]
  subset_data <- subsets_list[[i]]
  agency_data <- ddply(subset_data, .(ori), summarise, arrested = mean(arrested, na.rm=T) * 100)
  agency_data$offense <- subset_name
  plot_data <<- rbind(plot_data, agency_data)
  NULL
})

summary_data <- ddply(plot_data, .(offense), summarise,
      mean_arrested = mean(arrested),
      median_arrested = median(arrested))

# Reorder offenses to match other plots
offenses <- names(subsets_list)
plot_data$offense <- factor(plot_data$offense, levels=offenses)
summary_data$offense <- factor(summary_data$offense, levels=offenses)

p <- ggplot(plot_data, aes(x=offense, y=arrested)) +
  geom_jitter(alpha=0.2) + theme_classic() +
  xlab("Offense") + ylab("Agency Arrest Rate") +
  theme(plot.title = element_text(hjust = 0.5, size=16),
        text = element_text(family="serif"),
        axis.text.x = element_text(angle=55, vjust=0.5)) +
  ggtitle("Agency Arrest Rates by Offense") +
  geom_point(data=summary_data, aes(x=offense, y=mean_arrested),
             alpha=0.9,color="red", shape=18, size=3) +
  geom_point(data=summary_data, aes(x=offense, y=median_arrested),
             alpha=0.9, color="blue", shape=18, size=3) +
  guides(alpha=F)

g <- arrangeGrob(p, sub=textGrob("Note: Data are from 2013 NIBRS, and offenders arrested for other offenses are omitted, as are police agencies with fewer than 10 offenders.\nRed diamonds show means, and blue diamonds show medians.",
                                  x = unit(0.05, "npc"), just="left",
                                  gp = gpar(fontsize=8, fontfamily="serif")),
                  nrow=2, heights = c(20, 2))

ggsave("arrested_byoffense.jpg", plot=g, dpi=400)
