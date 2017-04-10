# Do agencies with more same-day arrests also arrest more black offenders?

library(ggplot2)
library(plyr)
library(RColorBrewer)
library(gridExtra)
library(grid)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch2 discretion/plots")
source("gen_plotdf.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch2 discretion/plots")

plots <- lapply(seq_along(subsets), function(i) {
  subset_data <- subsets[[i]]
  offense <- names(subsets)[[i]]
  offense_clean <- gsub('/', 'or', offense)
  # skip many-same-day subsets
  if (grepl("Same-Day", offense)) {
    NULL
  }
  else {
    # Generate aggregate plot data for this subset
    plot_data <- gen_plot(subset_data)
    # Only look at 50% arrested same-day
    plot_data <- subset(plot_data, agency_same_day >= 50)
    plot_data$agency_same_day_cut <- cut(plot_data$agency_same_day, 20)
    # Calculate each interval's mean
    plot_data$agency_same_day_cut <- (as.numeric(plot_data$agency_same_day_cut) * 2.5) + 48.75
    summary_data <- ddply(plot_data, .(black_not_white, agency_same_day_cut), summarise,
                          arrested=mean(arrested, na.rm=T))

    p <- ggplot(summary_data, aes(x=agency_same_day_cut, y=arrested,
                               shape=factor(black_not_white))) +
      # fit LOESS to 50% of points at each point
      geom_point() + ylim(0, 100) + xlim(50, 100) +
      scale_shape_discrete(solid=F, name="Offender Race", labels=c("White", "Black")) +
      theme_classic() + guides(alpha=F, shape=guide_legend(order=1)) +
      xlab("% Arrests on Day of Offense") + ylab("% Offenders Arrested") +
      theme(text=element_text(family="serif"))

    outfile <- paste0("sameday_", offense_clean, "_bins.jpg")
    
    g <- arrangeGrob(p, sub=textGrob("Note: Data are from 2013 NIBRS, and offenders arrested for other offenses are omitted, as are police agencies with fewer than 10 offenders.\nCircles and triangles represent white and black offenders' arrest rates for each bin, respectively.",
                                     x = unit(0.025, "npc"), just="left",
                                     gp = gpar(fontsize=8, fontfamily="serif")),
                     nrow=2, heights = c(20, 2))
    
    ggsave(outfile, plot=g, dpi=150)
    p
  }
})