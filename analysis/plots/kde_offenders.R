library(ggplot2)
library(plyr)
library(reshape)
library(grid)
library(gridExtra)
library(RColorBrewer)

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots")
source("~/Dropbox/Projects/Mugshots Project/Output/plots/grid_arrange_legend.R")

subsets_list <- list("Robbery" = robbery_data,
                     "Aggravated Assault" = aggravated_assault_data,
                     "Simple Assault" = simple_assault_data,
                     "Intimidation" = intimidation_data,
                     "Weapon" = weapon_data,
                     "Shoplifting" = shoplifting_data,
                     "Vandalism" = vandalism_data,
                     "Drugs / Narcotics" = drugs_narcotics_data,
                     "Drug Equipment" = drug_equipment_data)

plots_list <- lapply(seq_along(subsets_list), function(i) {
  plot_data <- ddply(subsets_list[[i]], .(ori), summarise, offenders = sum(!is.na(arrested)))

  p <- ggplot(plot_data, aes(offenders)) + geom_density(alpha = 2/3, adjust = 1/5) +
    theme_bw() + ggtitle(names(subsets_list)[[i]]) +
    xlab('Number of Offenders') + ylab('Agency Density') +
    scale_x_log10()
  p
})

plots_grid <- grid.arrange(plots_list[[1]], plots_list[[2]],
                           plots_list[[3]], plots_list[[4]],
                           plots_list[[5]], plots_list[[6]],
                           plots_list[[7]], plots_list[[8]], plots_list[[9]])

g <- arrangeGrob(plots_grid, top = textGrob('Number of Offenders'))

g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from 2013 NIBRS offenders data and 2013 LEMAS police data. Offenders arrested for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations, with 95% confidence intervals shaded gray.",
                                    x = unit(0.02, "npc"), just = "left",
                                    gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("kde_offenders.png", plot = g2, dpi = 300, width = 12, height = 10)
