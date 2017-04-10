## % offenders black

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
  df <- subsets_list[[i]]
  offense <- names(subsets_list)[[i]]
  # Get % black and SE vars
  pct_black = mean(df$black_not_white) * 100
  sd_black = sd(df$black_not_white * 100)
  N = sum(!is.na(df$black_not_white))
  row <- data.frame(list("offense"=offense, "pct_black"=pct_black, "sd_black"=sd_black, "N"=N))
  if (nrow(plot_data) == 0) {
    plot_data <<- row
  } else {
    plot_data <<- rbind(plot_data, row)
  }
})
plot_data$offense <- factor(plot_data$offense, levels = names(subsets_list))

plot_data$se_black <- plot_data$sd_black / sqrt(plot_data$N)
plot_data$min_black <- plot_data$pct_black - plot_data$se_black
plot_data$max_black <- plot_data$pct_black + plot_data$se_black

p <- ggplot(plot_data, aes(x=offense, y=pct_black)) +
  geom_bar(stat="identity", fill="white", color="gray") +
  ylab("Percent Black") + xlab("Offense") + ylim(0, 100) +
  ggtitle("Percent Male Offenders who are Black") + theme_classic() +
  theme(axis.text.x = element_text(angle=45, vjust=0.5),
        plot.title = element_text(hjust = 0.5, size=14),
        text=element_text(family="serif"),
        legend.background = element_rect(colour = "gray")) +
  geom_errorbar(aes(x=offense, ymin=min_black, ymax=max_black), colour="blue") +
  geom_hline(yintercept=14.1, linetype="dashed", color="red")

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS, and only black and white male offenders are included. Agencies with fewer than 10 offenders for the\ngiven offense are excluded, as are offenders arrested for offenses other than the offense examined. Standard errors are shown in blue.\nRed line shows the percentage of black and white men in the US who are black.",
                                   x = unit(0.05, "npc"), just = "left",
                                   gp = gpar(fontsize = 9, fontfamily="serif")),
                 nrow=2, heights = c(20, 2))

ggsave("barplot_offenders_black.png", g, dpi=400)
