library(ggplot2)
library(reshape2)
library(plyr)
library(gridExtra)
library(grid)
#library(Rmisc)
setwd("~/Dropbox/Mugshots Project/Code/R Analysis/NIBRS Offenders 2013/plots")
source("grid_arrange_legend.R")
setwd("~/Dropbox/Mugshots Project/Public/Output/plots")

subsets_list <- list("All Crimes" = dataset,
                     "Simple Assault" = simple_assault_data,
                     "Aggravated Assault" = aggravated_assault_data,
                     "Intimidation" = intimidation_data,
                     "Robbery" = robbery_data, "Shoplifting" = shoplifting_data,
                     "Vandalism" = vandalism_data,
                     "Drugs / Narcotics" = drugs_narcotics_data,
                     "Drug Equipment" = drug_equipment_data)

plots_list <- lapply(seq_along(subsets_list), function(i) {
  bdgt_arrested <- ddply(subsets_list[[i]], .(bdgt_ttl, black_not_white),
                                      summarise, mean_arrested = mean(arrested) * 100,
                                      sd_arrested = sd(arrested),
                                      offenders_count = sum(!is.na(arrested)))
  
  p <- ggplot(bdgt_arrested, aes(x = bdgt_ttl, y = mean_arrested,
                                              color = factor(black_not_white),
                                              size = offenders_count)) +
    geom_point(alpha = 7/10) + scale_size(range = c(1, 3), guide = 'none') +
    stat_smooth(method = "loess") +
    xlab("Total Budget (M)") + ylab("% Offenders Arrested") +
    theme_bw() + xlim(0, 80) +
    ggtitle(names(subsets_list)[[i]]) +
    scale_colour_hue("Offender Race", labels = c("White", "Black")) + ylim(0, 100) +
    theme(axis.title = element_text(size = 6)) +
    theme(plot.title = element_text(size = 8)) + theme(axis.text = element_text(size = 6)) +
    theme(legend.title = element_text(size = 6)) + theme(legend.text = element_text(size = 4))
  p
})


plots_grid <- grid_arrange_shared_legend(plots_list[[1]], plots_list[[2]],
                                         plots_list[[3]], plots_list[[4]],
                                         plots_list[[5]], plots_list[[6]],
                                         plots_list[[7]], plots_list[[8]], plots_list[[9]])
ggsave("bdgt_percent_arrested_subsets.png", plot = plots_grid,
       dpi = 600, width = 12, height = 10)



# Individual-level arrest or non-arrest
raw_plots_list <- lapply(seq_along(subsets_list), function(i) {  
  p <- ggplot(subsets_list[[i]], aes(x = bdgt_ttl, y = arrested, color = factor(black_not_white))) +
    geom_point(alpha = 4/10, position = position_jitter(height = 0.1)) + 
    stat_smooth() + xlim(0, 80) +
    xlab("Total Budget (M)") + ylab("Arrested") +
    theme_bw() + ggtitle(names(subsets_list)[[i]]) +
    scale_colour_hue("Offender Race", labels = c("White", "Black")) + ylim(-0.4, 1.4)
  p
})


# This takes a long time (it's a lot of data)
raw_plots_grid <- grid_arrange_shared_legend(raw_plots_list[[1]], raw_plots_list[[2]],
                                             raw_plots_list[[3]], raw_plots_list[[4]],
                                             raw_plots_list[[5]], raw_plots_list[[6]],
                                             raw_plots_list[[7]], raw_plots_list[[8]],
                                             raw_plots_list[[9]])
ggsave("bdgt_raw_arrested_subsets.png", plot = raw_plots_grid,
       dpi = 600, width = 12, height = 10)
