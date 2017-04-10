library(ggplot2)
library(plyr)
library(gridExtra)
library(grid)
library(scales)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch1 discrimination/plots")
source("grid_arrange_legend.R")
setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("subsets_list.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/plots")

plots_list <- lapply(seq_along(subsets_list), function(i) {
  subset_name <- names(subsets_list)[[i]]
  subset_data <- subsets_list[[i]]
  ori_data <- ddply(subset_data, .(ori), summarise,
                    offender_count = sum(!is.na(arrested)))
#                     black_offenders = sum(black_not_white),
#                     white_offenders = sum(black_not_white==0))
  b_data <- ddply(subset(subset_data, black_not_white==1), .(ori), summarise,
                  arrested = mean(arrested, na.rm=T) * 100)
  w_data <- ddply(subset(subset_data, black_not_white==0), .(ori), summarise,
                  arrested = mean(arrested, na.rm=T) * 100)
  b_data$black_not_white = 1
  w_data$black_not_white = 0
  b_data <- merge(ori_data, b_data, by=c("ori"), how="outer")
  w_data <- merge(ori_data, w_data, by=c("ori"), how="outer")
  plot_data <- rbind(b_data, w_data)
  
  p <- ggplot(plot_data, aes(x=offender_count, y=arrested, color=factor(black_not_white))) +
    geom_point(size=0.2) + geom_smooth(method="loess", se=F) +
    scale_x_log10(labels = comma) + theme_classic() +
    scale_color_brewer(name = "Offender Race", palette="Accent", labels=c("White", "Black")) +
    ylab("% Arrested") + xlab("Offenders") +
    theme(plot.title = element_text(hjust = 0.5),
          text = element_text(family="serif"),
          legend.background = element_rect(colour = "gray")) +
    ggtitle(subset_name)
  
  p
})

plots_grid <- grid_arrange_shared_legend(plots_list[[1]], plots_list[[2]],
                                         plots_list[[3]], plots_list[[4]],
                                         plots_list[[5]], plots_list[[6]],
                                         plots_list[[7]], plots_list[[8]], plots_list[[9]])

g <- arrangeGrob(plots_grid, top = textGrob("Percent Arrested by Agency Offender Count",
                                            gp=gpar(fontsize=16, fontfamily="serif")))
g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS, and each point represents a police agency. Offenders arrested for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations.",
                                    x = unit(0.02, "npc"), just = "left",
                                    gp = gpar(fontsize=7, fontfamily="serif")), nrow = 2, heights = c(20, 1))

ggsave("offender_counts.png", plot=g2, dpi = 400)
