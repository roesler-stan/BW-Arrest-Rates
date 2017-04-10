library(ggplot2)
library(reshape2)
library(plyr)
library(gridExtra)
library(grid)
library("RColorBrewer")

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/plots")
source("grid_arrange_legend.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/plots")

subsets_list <- list("All Crimes" = dataset,
                     "Simple Assault" = simple_assault_data,
                     "Aggravated Assault" = aggravated_assault_data,
                     "Intimidation" = intimidation_data,
                     "Robbery" = robbery_data,
                     "Shoplifting" = shoplifting_data,
                     "Vandalism" = vandalism_data,
                     "Drugs / Narcotics" = drugs_narcotics_data,
                     "Drug Equipment" = drug_equipment_data)

plots_list <- lapply(seq_along(subsets_list), function(i) {
  bdgt_per_offender_arrested <- ddply(subsets_list[[i]], .(agency_bdgt_per_offender, black_not_white),
                               summarise, mean_arrested = mean(arrested) * 100,
                               sd_arrested = sd(arrested),
                               offenders_count = sum(!is.na(arrested)))
  
  p <- ggplot(bdgt_per_offender_arrested, aes(x = agency_bdgt_per_offender, y = mean_arrested,
                                       color = factor(black_not_white),
                                       size = offenders_count)) +
    geom_point(alpha = 7/10) + scale_size(range = c(1, 3), guide = 'none') +
    stat_smooth(method = "loess") +
    xlab("Budget ($) Per Offender") + ylab("% Offenders Arrested") +
    theme_bw() + xlim(0, 20000) + ylim(0, 100) +
    ggtitle(names(subsets_list)[[i]]) +
    scale_color_brewer(name = "Offender Race", palette = "Set3", labels = c("White", "Black")) +
    theme(axis.title = element_text(size = 6)) +
    theme(plot.title = element_text(size = 8)) + theme(axis.text = element_text(size = 6)) +
    theme(legend.title = element_text(size = 6)) + theme(legend.text = element_text(size = 4))
  p
})


plots_grid <- grid_arrange_shared_legend(plots_list[[1]], plots_list[[2]],
                                         plots_list[[3]], plots_list[[4]],
                                         plots_list[[5]], plots_list[[6]],
                                         plots_list[[7]], plots_list[[8]], plots_list[[9]])

g <- arrangeGrob(plots_grid, top = textGrob('Agencies’ Percentages of Offenders Arrested by Offender Race and Agency Budget per Offender'))

g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from merged data set, particularly 2013 NIBRS offenders data and 2013 LEMAS police data. Offenders arrested for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations, with 95% confidence intervals shaded gray.",
                                    x = unit(0.02, "npc"), just = "left",
                                    gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("bdgt_per_offender_percent_arrested.png", plot = g2,
       dpi = 600, width = 12, height = 10)


# Individual-level arrest or non-arrest
raw_plots_list <- lapply(seq_along(subsets_list), function(i) {  
  p <- ggplot(subsets_list[[i]], aes(x = agency_bdgt_per_offender, y = arrested, color = factor(black_not_white))) +
    geom_point(alpha = 4/10, position = position_jitter(height = 0.1)) + 
    stat_smooth() + ylim(-0.4, 1.4) +
    xlab("Budget ($) per Offender") + ylab("Arrested") +
    xlim(0, 20000) + theme_bw() + ggtitle(names(subsets_list)[[i]]) +
    scale_color_brewer(name = "Offender Race", palette = "Set3", labels = c("White", "Black"))
  p
})


# This takes a long time (it's a lot of data)
raw_plots_grid <- grid_arrange_shared_legend(raw_plots_list[[1]], raw_plots_list[[2]],
                                             raw_plots_list[[3]], raw_plots_list[[4]],
                                             raw_plots_list[[5]], raw_plots_list[[6]],
                                             raw_plots_list[[7]], raw_plots_list[[8]],
                                             raw_plots_list[[9]])

g <- arrangeGrob(raw_plots_grid, top = textGrob('Offenders Arrested by Offender Race and Agency Budget per Offender'))

g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from merged data set, particularly 2013 NIBRS offenders data and 2013 LEMAS police data. Offenders arrested for offenses other than the offense examined are omitted.\nLines are generalized additive models (GAM) fit to the observations, with 95% confidence intervals shaded gray.",
                                    x = unit(0.02, "npc"), just = "left",
                                    gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("bdgt_per_offender_raw_arrested.png", plot = g2,
       dpi = 600, width = 12, height = 10)
