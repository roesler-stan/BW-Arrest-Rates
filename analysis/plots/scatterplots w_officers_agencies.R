library(ggplot2)
library(reshape2)
library(plyr)
library(gridExtra)
library(grid)
library(RColorBrewer)

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
  w_officers_arrested <- ddply(subsets_list[[i]], .(ori, black_not_white), summarise,
                               mean_arrested = mean(arrested) * 100,
                               w_officers_percent = mean(w_officers_percent),
                               sd_arrested = sd(arrested),
                               offenders_count = sum(!is.na(arrested)))
  
  p <- ggplot(w_officers_arrested, aes(x = w_officers_percent, y = mean_arrested,
                                       color = factor(black_not_white),
                                       size = offenders_count)) +
    geom_point(alpha = 7/10) + scale_size(range = c(1, 3), guide = 'none') +
    stat_smooth(method = "loess") +
    xlab("% Officers White") + ylab("% Offenders Arrested") +
    xlim(30, 100) + ylim(0, 100) + theme_bw() +
    ggtitle(names(subsets_list)[[i]]) +
    scale_color_brewer(name = "Offender Race", palette = "Set3", labels = c("White", "Black"))
  p
})

plots_grid <- grid_arrange_shared_legend(plots_list[[1]], plots_list[[2]],
                                         plots_list[[3]], plots_list[[4]],
                                         plots_list[[5]], plots_list[[6]],
                                         plots_list[[7]], plots_list[[8]], plots_list[[9]])

g <- arrangeGrob(plots_grid, top = textGrob('Agencies’ Percentages of Offenders Arrested by Offender Race and Agency Percent Officers White'))

g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from merged data set, particularly 2013 NIBRS offenders data and 2013 LEMAS police data. Offenders arrested for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations, with 95% confidence intervals shaded gray.",
                                    x = unit(0.02, "npc"), just = "left",
                                    gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("wofficers_percent_arrested_agencies.png", plot = g2, dpi = 300, width = 12, height = 10)
