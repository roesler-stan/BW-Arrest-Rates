library(ggplot2)
library(plyr)
library(grid)
library(gridExtra)
library(RColorBrewer)
library(gtools)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("subsets_list.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/plots")

plot_data <- data.frame()
barplots_data_list <- lapply(seq_along(subsets_list), function(i) {
  # Calculate the average of agency's arrest rates for black and white men
  subset_ori <- ddply(subsets_list[[i]], .(ori, black_not_white),
                      summarise, mean_arrested = mean(arrested) * 100)
  offenders_arrested <- ddply(subset_ori, .(black_not_white),
                      summarise, mean_arrested = mean(mean_arrested))
  plot_data <<- smartbind(plot_data, offenders_arrested)
})
plot_data <- unique(plot_data)
row.names(plot_data) <- NULL

lapply(seq_along(subsets_list), function(i) {
  plot_data[(i * 2) - 1, 'offense'] <<- names(subsets_list)[[i]]
  plot_data[i * 2, 'offense'] <<- names(subsets_list)[[i]]
})
plot_data$offense <- factor(plot_data$offense, levels = names(subsets_list))

p <- ggplot(plot_data, aes(x=offense, y=mean_arrested, fill=factor(black_not_white))) +
  geom_bar(stat = "identity", position = "dodge") +
  ylab("Percent Arrested") + xlab("Offense") + ylim(0, 100) +
  ggtitle("Agencies' Average Percent Offenders Arrested") + theme_classic() +
  scale_fill_brewer(name = "Offender Race", palette = "OrRd", labels=c("White", "Black")) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        plot.title = element_text(hjust = 0.5), text = element_text(family="serif"),
        legend.background = element_rect(colour = "gray")) +
  geom_text(data = plot_data[plot_data$black_not_white == 0,],
            aes(label = round(mean_arrested, 0), hjust = 1.9, vjust = -0.5, family="serif"), size = 2.5) +
  geom_text(data = plot_data[plot_data$black_not_white == 1,],
            aes(label = round(mean_arrested, 0), hjust = -0.7, vjust = -0.5, family="serif"), size = 2.5)

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS offenders data. Offenders arrested for offenses other than the offense examined are omitted, as are police agencies with fewer than 10 offenders for the given offense.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 6, fontfamily="serif")), nrow = 2, heights = c(20, 1))

ggsave("barplot_agency_arrest_rates.png", g, dpi = 400)
