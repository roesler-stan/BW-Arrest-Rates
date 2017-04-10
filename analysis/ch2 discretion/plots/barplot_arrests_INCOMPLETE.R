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

agency_data <- data.frame()
plots_list <- lapply(seq_along(subsets_list), function(i) {
  subset_name <- names(subsets_list)[[i]]
  subset_data <- subsets_list[[i]]
  df <- ddply(subset_data, .(ori), summarise, arrested = mean(arrested, na.rm=T) * 100)
  df$offense <- subset_name
  plot_data <<- rbind(agency_data, df)
  NULL
})

plot_data <- ddply(agency_data, .(offense), summarise,
                      mean_arrested = mean(arrested),
                      median_arrested = median(arrested))

# Reorder offenses to match other plots
offenses <- names(subsets_list)
plot_data$offense <- factor(plot_data$offense, levels=offenses)


p <- ggplot(plot_data, aes(x=offense, y=mean_arrested,
                           fill=factor(black_not_white))) +
  geom_bar(stat="identity", position="dodge") + theme_classic() +
  ylab("Percent Arrested") + xlab("Offense") + ylim(0, 100) +
  #ggtitle("Percent Male Offenders Arrested") + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        plot.title = element_text(hjust = 0.6), text = element_text(family="serif"),
        legend.background = element_rect(colour = "gray")) +
  geom_text(data = plot_data[plot_data$black_not_white == 0,],
            aes(label = round(mean_arrested, 0), hjust = 1.7, vjust = -0.5, family="serif"), size=3) +
  geom_text(data = plot_data[plot_data$black_not_white == 1,],
            aes(label = round(mean_arrested, 0), hjust = -0.6, vjust = -0.5, family="serif"), size=3) +
  geom_errorbar(aes(x=offense, ymin=min_arrested, ymax=max_arrested),
                colour="gray", position="dodge") +
  scale_fill_brewer(name = "Offender Race", palette = "OrRd", labels=c("White", "Black")) +
  guides(color=F)


ggplot(summary_data, aes(x=offense, y=arrested, fill=)) +
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
