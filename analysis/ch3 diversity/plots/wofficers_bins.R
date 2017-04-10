# Do agencies with more same-day arrests also arrest more black offenders?

library(ggplot2)
library(plyr)
library(RColorBrewer)
library(gridExtra)
library(grid)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("subsets_list.R")
setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch3 diversity/plots")
source("grid_arrange_legend.R")
source("gen_plotdf.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch3 diversity/plots")

plots <- lapply(seq_along(subsets_list), function(i) {
  subset_data <- subsets_list[[i]]
  offense <- names(subsets_list)[[i]]
  offense_clean <- gsub('/', 'or', offense)
  # Generate aggregate plot data for this subset
  plot_data <- gen_plot(subset_data)
  plot_data$w_officers_percent_cut <- cut(plot_data$w_officers_percent, 50)
  # Calculate each interval's mean
  plot_data$w_officers_percent_cut <- (as.numeric(plot_data$w_officers_percent_cut) * 2) - 1
  summary_data <- ddply(plot_data, .(black_not_white, w_officers_percent_cut), summarise,
                        arrested=mean(arrested, na.rm=T)) 
  # Remove one interval on far left
  summary_data <- subset(summary_data, w_officers_percent_cut > 1)
  
  p <- ggplot(summary_data, aes(x=w_officers_percent_cut, y=arrested,
                             shape=factor(black_not_white), linetype=factor(black_not_white))) +
    geom_point() + coord_fixed() + xlim(25, 100) + ylim(0, 100) +
    geom_smooth(method="loess", se=F, span=0.5) +
    scale_linetype_discrete(name="Local Reg.", breaks=c(0, 1), labels=c("White", "Black")) +
    scale_shape_discrete(solid=F, name="Offender Race", labels=c("White", "Black")) +
    theme_classic() + guides(alpha=F, shape=guide_legend(order=1)) +
    xlab("Off. White") + ylab("% Arrested") + ggtitle(offense) +
    theme(text=element_text(family="serif"), plot.title=element_text(size=13, hjust=0.5),
          legend.title=element_text(size=11))
  p
})

plots_grid <- grid_arrange_shared_legend(plots[[1]], plots[[2]], plots[[3]], plots[[4]],
                                         plots[[5]], plots[[6]], plots[[7]], plots[[8]], plots[[9]])

footnote <- "Note: Data are from 2013 NIBRS and LEMAS. Offenders arrested for other offenses are omitted, as are police agencies with fewer than 10 offenders.\nCircles and triangles represent agencies' white and black arrest rates, respectively; local regressions are shown in solid and dashed lines, respectively.\nTwo observations with less than 25% white officers are excluded."
g <- arrangeGrob(plots_grid, sub=textGrob(footnote, x=unit(0.02, "npc"), just="left",
                                          gp = gpar(fontsize=7, fontfamily="serif")), nrow=2, heights=c(20, 1.5))

ggsave("wofficers_bins.jpg", plot=g, dpi=150)
