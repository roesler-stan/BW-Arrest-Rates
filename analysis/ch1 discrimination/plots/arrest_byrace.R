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
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/plots")

plots_list <- lapply(seq_along(subsets_list), function(i) {
  subset_name <- names(subsets_list)[[i]]
  subset_data <- subsets_list[[i]]
  b_data <- ddply(subset(subset_data, black_not_white==1), .(ori), summarise,
                  b_arrested = mean(arrested, na.rm=T) * 100)
  w_data <- ddply(subset(subset_data, black_not_white==0), .(ori), summarise,
                  w_arrested = mean(arrested, na.rm=T) * 100)
  b_data <- merge(ori_data, b_data, by=c("ori"), how="outer")
  w_data <- merge(ori_data, w_data, by=c("ori"), how="outer")
  plot_data <- merge(b_data, w_data)
  
  p <- ggplot(plot_data, aes(x=w_arrested, y=b_arrested)) +
    geom_point(size=0.3) + guides(size=F) + coord_fixed() +
    theme_classic() + xlab("% White Arrested") + ylab("% Black Arrested") +
    theme(plot.title = element_text(hjust = 0.5, size=12),
          text = element_text(family="serif"),
          axis.title = element_text(size=10)) +
    ggtitle(subset_name) +
    geom_abline(intercept=0, slope=1, linetype="dashed", color="red")
    #geom_smooth(method="loess", se=F)
  
  p
})

plots_grid <- grid.arrange(plots_list[[1]], plots_list[[2]],
                           plots_list[[3]], plots_list[[4]],
                           plots_list[[5]], plots_list[[6]],
                           plots_list[[7]], plots_list[[8]], plots_list[[9]],
                           ncol=3, nrow=3)

#g <- arrangeGrob(plots_grid, top=textGrob("Agencies' Percent Offenders Arrested by Race",
#                                            gp=gpar(fontsize=14, fontfamily="serif")))

g2 <- arrangeGrob(plots_grid, sub=textGrob("Note: Data are from 2013 NIBRS, and offenders arrested for other offenses are omitted, as are police agencies\nwith fewer than 10 offenders.  Red lines show where percentages are equivalent.",
                                    x = unit(0.05, "npc"), just="left",
                                    gp = gpar(fontsize=9, fontfamily="serif")),
                  nrow=2, heights = c(20, 2))

ggsave("arrested_byrace.jpg", plot=g2, dpi=150)
