# Previously used Set1 palette
library(ggplot2)
library(plyr)
library(gridExtra)
library(grid)
library(RColorBrewer)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch1 discrimination/plots")
source("grid_arrange_legend.R")
setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/cleaning")
source("subsets_list.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/plots/exploratory")

continuous_variables <- list('w_officers_percent' = "Percent of Officers White",
                             'wofficers_divres' = "% Officers / Residents White",
                             'b_officers_percent' = 'Percent of Officers Black',
                             'male_officers_percent' = 'Percent of Officers Male',
                             'bdgt_per_ftoff' = 'Agency Budget per FT Officer',
                             'w_residents_percent' = 'Percent of Residents White',
                             'total_residents' = 'Total County Population')

nothing <- lapply(seq_along(continuous_variables), function(var_no) {
  variable <- names(continuous_variables)[[var_no]]
  variable_nice <- continuous_variables[[var_no]]
  
  plots_list <- lapply(seq_along(subsets_list), function(subset_no) {
    plot_data <- ddply(subsets_list[[subset_no]], .(ori, black_not_white), here(summarise),
                       mean_arrested = mean(arrested) * 100, indep_var = mean(get(variable)))
    
    p <- ggplot(plot_data, aes(x=indep_var, y=mean_arrested, color=factor(black_not_white))) +
      #geom_point(alpha=0.6, size=0.75) +
      stat_smooth(method="loess", se=T, size=0.6) +
      xlab(variable_nice) + ylab("% Offenders Arrested") + ylim(0, 100) + theme_bw() +
      ggtitle(names(subsets_list)[[subset_no]]) + guides(size=F) +
      scale_color_brewer(name = "Offender Race", palette="Accent", labels=c("White", "Black"))
    p
  })
  
  plots_grid <- grid_arrange_shared_legend(plots_list[[1]], plots_list[[2]], plots_list[[3]], plots_list[[4]],
                                           plots_list[[5]], plots_list[[6]],
                                           plots_list[[7]], plots_list[[8]], plots_list[[9]])
  
  title <- paste0("Agencies' Percent of Offenders Arrested by ", variable_nice)
  g <- arrangeGrob(plots_grid, top = textGrob(title, gp=gpar(fontsize=16)))
  
  g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS, and offenders arrested only for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations.",
                                      x = unit(0.02, "npc"), just = "left",
                                      gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))
  
  filename <- paste0("bw_", variable, '.png')
  ggsave(filename, plot=g2, dpi=300)
  
  NULL
})

##Variables that should be logged to approximate normal distribution
## Budget per offender, total budget, officers/residents black, ft officers
log_variables <- list('bofficers_divres' = '% Officers / Residents Black',
                             'bdgt_ttl' = 'Total Agency Budget',
                             'agency_bdgt_per_offender' = 'Agency Budget per Offender',
                             'bdgt_per_ftoff' = 'Agency Budget per FT Officer',
                             'ftsworn' = 'Full-Time Sworn Officers', 'mean_inc' = 'County Mean Income',
                             'w_residents_percent' = 'Percent of Residents White',
                             'total_residents' = 'Total County Population')

nothing <- lapply(seq_along(log_variables), function(var_no) {
  variable <- names(log_variables)[[var_no]]
  variable_nice <- log_variables[[var_no]]
  
  plots_list <- lapply(seq_along(subsets_list), function(subset_no) {
    plot_data <- ddply(subsets_list[[subset_no]], .(ori, black_not_white), here(summarise),
                       mean_arrested = mean(arrested) * 100, indep_var = mean(get(variable)))
    
    p <- ggplot(plot_data, aes(x=indep_var, y=mean_arrested, color=factor(black_not_white))) +
      geom_point(alpha=0.6, size=0.75) + stat_smooth(method="loess", se=F, size=0.6) +
      xlab(variable_nice) + ylab("% Offenders Arrested") + ylim(0, 100) + theme_bw() +
      ggtitle(names(subsets_list)[[subset_no]]) + guides(size = F) +
      scale_color_brewer(name = "Offender Race", palette="Set1", labels=c("White", "Black")) +
      scale_x_log10()
    p
  })
  
  plots_grid <- grid_arrange_shared_legend(plots_list[[1]], plots_list[[2]], plots_list[[3]], plots_list[[4]],
                                           plots_list[[5]], plots_list[[6]],
                                           plots_list[[7]], plots_list[[8]], plots_list[[9]])
  
  title <- paste0("Agencies' Percent of Offenders Arrested by ", variable_nice)
  g <- arrangeGrob(plots_grid, top = textGrob(title, gp = gpar(fontsize = 16)))
  
  g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS, and offenders arrested only for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations.",
                                      x = unit(0.02, "npc"), just = "left",
                                      gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))
  
  filename <- paste0("bw_", variable, '.png')
  ggsave(filename, plot = g2, dpi = 300, width = 12, height = 10)
  
  NULL
})


binary_variables = list('tech_typ_vpat' = "Patrol Officers Wear Cameras",
                        'com_mis' = "Community Policing is in Mission Statement",
                        "com_bt" = "Officers are Assigned to Regular Beats",
                        'min_hiring_educ_gths' = "New Officers must have at least High School")

nothing <- lapply(seq_along(binary_variables), function(var_no) {
  variable <- names(binary_variables)[[var_no]]
  variable_nice <- binary_variables[[var_no]]
  
  plots_list <- lapply(seq_along(subsets_list), function(subset_no) {
    agency_data <- ddply(subsets_list[[subset_no]], .(ori, black_not_white), here(summarise),
                       mean_arrested = mean(arrested) * 100, indep_var = mean(get(variable)))
    agency_data <- subset(agency_data, !is.na(indep_var))
    plot_data <- ddply(agency_data, .(black_not_white, indep_var), here(summarise),
                       mean_arrested = mean(mean_arrested))
    plot_data$indep_var[plot_data$indep_var == 0] <- "No"
    plot_data$indep_var[plot_data$indep_var == 1] <- "Yes"
    
    p <- ggplot(plot_data, aes(x = indep_var, y = mean_arrested, fill = factor(black_not_white))) +
      geom_bar(stat = "identity", position = "dodge") +
      guides(size = F, fill = guide_legend(override.aes = list(linetype = 0))) +
      stat_smooth(method = "loess", se = F, size = 0.6) +
      xlab(variable_nice) + ylab("% Offenders Arrested") + ylim(0, 100) + theme_bw() +
      ggtitle(names(subsets_list)[[subset_no]]) +
      scale_fill_brewer(name = "Offender Race", palette="Set1", labels=c("White", "Black"))
    p
  })
  
  plots_grid <- grid_arrange_shared_legend(plots_list[[1]], plots_list[[2]], plots_list[[3]], plots_list[[4]],
                                           plots_list[[5]], plots_list[[6]],
                                           plots_list[[7]], plots_list[[8]], plots_list[[9]])
  
  title <- paste0("Agencies' Mean Percent of Offenders Arrested by ", variable_nice)
  g <- arrangeGrob(plots_grid, top = textGrob(title, gp = gpar(fontsize = 16)))
  
  g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS, and offenders arrested only for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations.",
                                      x = unit(0.02, "npc"), just = "left",
                                      gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))
  
  filename <- paste0("bw_", variable, '.png')
  ggsave(filename, plot = g2, dpi = 300, width = 12, height = 10)
  
  NULL
})
