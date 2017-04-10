# Do agencies with more same-day arrests also arrest more black offenders?

library(ggplot2)
library(plyr)
library(RColorBrewer)

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

    p <- ggplot(plot_data, aes(x=agency_same_day, y=arrested, alpha=0.6,
                               shape=factor(black_not_white), linetype=factor(black_not_white))) +
      # fit LOESS to 50% of points at each point
      geom_point() + geom_smooth(method="loess", se=F, span=0.5) +
      scale_linetype_discrete(name="Local Reg.", breaks=c(0, 1), labels=c("White", "Black")) +
      scale_shape_discrete(solid=F, name="Offender Race", labels=c("White", "Black")) +
      theme_classic() + guides(alpha=F, shape=guide_legend(order=1)) +
      xlim(50, 100) + ylim(0, 100) +
      xlab("% Arrests on Day of Offense") + ylab("% Offenders Arrested") +
      theme(text=element_text(family="serif"))
      #scale_linetype_manual("Offender Race", values=c(1, 2), labels=c("White", "Black")) +
      #scale_shape_manual("Offender Race", values=c(1, 2), labels=c("White", "Black"))
    
    g <- arrangeGrob(p, sub=textGrob("Note: Data are from 2013 NIBRS. Offenders arrested for other offenses and police agencies with fewer than 10 offenders are omitted.\n29 agencies with fewer than 50% same-day arrests are omitted.\nCircles and triangles represent agencies' white and black arrest rates, respectively, with local regression curves shown in solid and dashed lines, respectively.",
                                     x = unit(0.025, "npc"), just="left",
                                     gp = gpar(fontsize=8, fontfamily="serif")),
                     nrow=2, heights = c(20, 2))

    outfile <- paste0("sameday_", offense_clean, ".jpg")
    ggsave(outfile, plot=g, dpi=150)
    p
  }
})
