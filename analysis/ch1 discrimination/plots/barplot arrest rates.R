library(ggplot2)
library(plyr)
library(RColorBrewer)
library(grid)
library(gridExtra)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("subsets_list.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/plots")

# Calculate the average arrest rates for black vs. white men
plot_data <- data.frame()
barplots_data_list <- lapply(seq_along(subsets_list), function(i) {
  subset_ori <- ddply(subsets_list[[i]], .(black_not_white),
                      summarise,
                      mean_arrested = mean(arrested) * 100,
                      sd_arrested = sd(arrested * 100),
                      observations = sum(!is.na(arrested)))
  subset_ori$offense <- names(subsets_list)[[i]]
  if (nrow(plot_data) == 0) {
    plot_data <<- subset_ori
  } else {
    plot_data <<- rbind(plot_data, subset_ori)
  }
})

plot_data$offense <- factor(plot_data$offense, levels = names(subsets_list))

plot_data$se_arrested <- plot_data$sd_arrested / sqrt(plot_data$observations)
plot_data$min_arrested <- plot_data$mean_arrested - plot_data$se_arrested
plot_data$max_arrested <- plot_data$mean_arrested + plot_data$se_arrested

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

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS, and only black and white male offenders are included. Agencies with fewer than 10 offenders\nfor the given offense are excluded, as are offenders arrested for offenses other than the offense examined. Standard errors are shown in gray.",
                                   x = unit(0.05, "npc"), just = "left",
                                   gp = gpar(fontsize = 9, fontfamily="serif")),
                 nrow=2, heights = c(20, 2))

ggsave("barplot_arrest_rates.jpg", g, dpi=150)
