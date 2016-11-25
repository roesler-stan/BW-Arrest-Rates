#source("~/Dropbox/Projects/Mugshots Project/Code/analysis/set up.R")

library(ggplot2)
library(reshape2)
library(plyr)
library(gridExtra)
library(grid)
library(RColorBrewer)

setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/plots")
source("grid_arrange_legend.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/plots/drugs_weapons")

subsets_list <- list("Weapon" = weapon_data,
                     "Drugs / Narcotics" = drugs_narcotics_data,
                     "Drug Equipment" = drug_equipment_data)

# Right-skewed variables that need to be shown on log-scale
skewed_variables <- list("ftsworn" = "Full-Time Sworn Officers",
                             "ptsworn" = "Part-Time Sworn Officers",
                             "agency_offenders_count" = "Total Offenders Reported to Agency",
                             "agency_arrestees_count" = "Total Arrested by Agency",
                         "com_nsara" = "# Officers Engaged in SARA-Type Projects",
                         "com_nbt" = "# of Patrol Officers Assigned Same Beats")

nothing <- lapply(seq_along(skewed_variables), function(var_no) {
  variable <- names(skewed_variables)[[var_no]]
  variable_nice <- skewed_variables[[var_no]]
  
  plots_list <- lapply(seq_along(subsets_list), function(subset_no) {
    plot_data <- ddply(subsets_list[[subset_no]], .(ori, black_not_white), here(summarise),
                       mean_arrested = mean(arrested) * 100, indep_var = mean(get(variable)))
    
    # Add a tiny bit to the x-value so that the log of 0 is a small number
    p <- ggplot(plot_data, aes(x = indep_var + 0.0001, y = mean_arrested, color = factor(black_not_white))) +
      geom_point(alpha = 0.6, size = 0.75) + guides(size = F) +
      stat_smooth(method = "loess", se = F, size = 0.6) +
      xlab(variable_nice) + ylab("% Offenders Arrested") + ylim(0, 100) + theme_bw() +
      ggtitle(names(subsets_list)[[subset_no]]) +
      scale_color_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black")) +
      scale_x_log10()
    p
  })
  
  plots_grid <- grid_arrange_shared_legend(plots_list[[1]], plots_list[[2]], plots_list[[3]])
  
  title <- paste0("Agencies' Percent of Offenders Arrested by ", variable_nice)
  g <- arrangeGrob(plots_grid, top = textGrob(title, gp = gpar(fontsize = 16)))
  
  g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS, and offenders arrested only for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations.",
                                      x = unit(0.02, "npc"), just = "left",
                                      gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))
  
  filename <- paste0("bw_", variable, '.png')
  ggsave(filename, plot = g2, dpi = 300, width = 12, height = 10)
  
  NULL
})

continuous_variables <- list("com_bt_percent" = "Percent of Officers Assigned to Beat",
                             "com_nsara_percent" = "Percent of Officers Engaged in SARA-Type Projects")

nothing <- lapply(seq_along(continuous_variables), function(var_no) {
  variable <- names(continuous_variables)[[var_no]]
  variable_nice <- continuous_variables[[var_no]]
  
  plots_list <- lapply(seq_along(subsets_list), function(subset_no) {
    plot_data <- ddply(subsets_list[[subset_no]], .(ori, black_not_white), here(summarise),
                       mean_arrested = mean(arrested) * 100, indep_var = mean(get(variable)))
    
    p <- ggplot(plot_data, aes(x = indep_var, y = mean_arrested, color = factor(black_not_white))) +
      geom_point(alpha = 0.6, size = 0.75) + guides(size = F) +
      stat_smooth(method = "loess", se = F, size = 0.6) +
      xlab(variable_nice) + ylab("% Offenders Arrested") + ylim(0, 100) + theme_bw() +
      ggtitle(names(subsets_list)[[subset_no]]) +
      scale_color_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black"))
    p
  })
  
  plots_grid <- grid_arrange_shared_legend(plots_list[[1]], plots_list[[2]], plots_list[[3]])
  
  title <- paste0("Agencies' Percent of Offenders Arrested by ", variable_nice)
  g <- arrangeGrob(plots_grid, top = textGrob(title, gp = gpar(fontsize = 16)))
  
  g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS, and offenders arrested only for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations.",
                                      x = unit(0.02, "npc"), just = "left",
                                      gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))
  
  filename <- paste0("bw_", variable, '.png')
  ggsave(filename, plot = g2, dpi = 300, width = 12, height = 10)
  
  NULL
})


binary_variables <- list("tech_typ_gun" = "Gunshot Detection System",
                        "tech_typ_lic" = "License Plate Readers",
                        "tech_typ_vpub" = "Video Surveillance of Public Areas",
                        "tech_typ_vpat" = "Video Cameras on Patrol Officers",
                        "tech_typ_vveh" = "Video Cameras in Patrol Vehicles",
                        "tech_typ_vwpn" = "Video Cameras on Weapons",
                        "tech_typ_vothr" = "Other Types of Video Cameras",
                        "com_sara" = "SARA-Type Problem-Solving Projects",
                        "com_ptnr" = "Problem-Solving Partnership with Community",
                        "com_col" = "Evaluation Criteria Include Collaborative Problem-Solving",
                        "com_bt" = "Patrol Officers Regularly Assigned Same Beats",
                        "com_mis" = "Community Policing Component in Mission Statement",
                        "com_surv" = "Utilized Survey of Residents",
                        "hir_trn_no_p" = "No Additional Training for Pre-Service Hires",
                        "hir_trn_no_l" = "No Additional Training for Lateral Hires",
                        "min_hiring_educ_gths" = "More than High School Required of New Hires")

nothing <- lapply(seq_along(binary_variables), function(var_no) {
  variable <- names(binary_variables)[[var_no]]
  print(variable)
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
      geom_bar(stat = "identity", position = "dodge", width = 0.15) +
      guides(size = F, fill = guide_legend(override.aes = list(linetype = 0))) +
      stat_smooth(method = "loess", se = F, size = 0.6) +
      xlab(variable_nice) + ylab("% Offenders Arrested") + ylim(0, 100) + theme_bw() +
      ggtitle(names(subsets_list)[[subset_no]]) +
      scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black"))
    p
  })
  
  plots_grid <- grid_arrange_shared_legend(plots_list[[1]], plots_list[[2]], plots_list[[3]])
  
  title <- paste0("Agencies' Mean Percent of Offenders Arrested by ", variable_nice)
  g <- arrangeGrob(plots_grid, top = textGrob(title, gp = gpar(fontsize = 16)))
  
  g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS, and offenders arrested only for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations.",
                                      x = unit(0.02, "npc"), just = "left",
                                      gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))
  
  filename <- paste0("bw_", variable, '.png')
  ggsave(filename, plot = g2, dpi = 300, width = 12, height = 10)
  
  NULL
})


## County-level variables
continuous_county_vars <- list("county_offenders_count" = "Total Offenders in County",
                               "county_offenders_per_resident" = "# Offenders / # Residents in County",
                               "county_arrestees_count" = "Total Arrests in County",
                               "county_arrestees_per_resident" = "# Arrests / # Residents in County")

nothing <- lapply(seq_along(continuous_county_vars), function(var_no) {
  variable <- names(continuous_county_vars)[[var_no]]
  variable_nice <- continuous_county_vars[[var_no]]
  
  plots_list <- lapply(seq_along(subsets_list), function(subset_no) {
    plot_data <- ddply(subsets_list[[subset_no]], .(fips_county1_no, black_not_white), here(summarise),
                       mean_arrested = mean(arrested) * 100, indep_var = mean(get(variable)))
    
    p <- ggplot(plot_data, aes(x = indep_var, y = mean_arrested, color = factor(black_not_white))) +
      geom_point(alpha = 0.6, size = 0.75) + guides(size = F) +
      stat_smooth(method = "loess", se = F, size = 0.6) +
      xlab(variable_nice) + ylab("% Offenders Arrested") + ylim(0, 100) + theme_bw() +
      ggtitle(names(subsets_list)[[subset_no]]) +
      scale_color_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black"))
    p
  })
  
  plots_grid <- grid_arrange_shared_legend(plots_list[[1]], plots_list[[2]], plots_list[[3]])
  
  title <- paste0("Counties' Percent of Offenders Arrested by ", variable_nice)
  g <- arrangeGrob(plots_grid, top = textGrob(title, gp = gpar(fontsize = 16)))
  
  g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS, and offenders arrested only for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations.",
                                      x = unit(0.02, "npc"), just = "left",
                                      gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))
  
  filename <- paste0("bw_", variable, '.png')
  ggsave(filename, plot = g2, dpi = 300, width = 12, height = 10)
  
  NULL
})


categorical_variables = list("com_trn_insrv" = "Officers with at Least 8 Hours of Community Policing Training",
                             "com_trn_rec" = "New Recruits with at Least 8 Hours of Community Policing Training",
                             "min_hiring_educ" = "Minimum Education for New Hires")

nothing <- lapply(seq_along(categorical_variables), function(var_no) {
  variable <- names(categorical_variables)[[var_no]]
  print(variable)
  variable_nice <- categorical_variables[[var_no]]
    
  plots_list <- lapply(seq_along(subsets_list), function(subset_no) {
    subset_data <- subsets_list[[subset_no]]
  
    if (variable == "min_hiring_educ") {
      subset_data$min_hiring_educ <- revalue(subset_data$min_hiring_educ, c("hir_edu_no" = "No Requirement",
                                             "hir_edu_hs" = "High School",
                                             "hir_edu_scol" = "Some College",
                                             "hir_edu_ad" = "Associate's Degree",
                                             "hir_edu_bd" = "Bachelor's Degree"))
      subset_data$min_hiring_educ <- factor(subset_data$min_hiring_educ,
                                            levels = c("No Requirement", "High School", "Some College",
                                                       "Associate's Degree", "Bachelor's Degree"))
    }
    #else {
    #  subset_data[, variable] <- as.character(subset_data[, variable])      
    #}
    
    agency_data <- ddply(subset_data, .(ori, black_not_white), here(summarise),
                         mean_arrested = mean(arrested) * 100, indep_var = unique(get(variable)))
    agency_data <- subset(agency_data, !is.na(indep_var))
    agency_data <- subset(agency_data, indep_var != "")
    plot_data <- ddply(agency_data, .(black_not_white, indep_var), here(summarise),
                       mean_arrested = mean(mean_arrested))
    
    p <- ggplot(plot_data, aes(x = indep_var, y = mean_arrested, fill = factor(black_not_white))) +
      geom_bar(stat = "identity", position = "dodge", width = 0.4) +
      guides(size = F, fill = guide_legend(override.aes = list(linetype = 0))) +
      stat_smooth(method = "loess", se = F, size = 0.6) +
      xlab(variable_nice) + ylab("% Offenders Arrested") + ylim(0, 100) + theme_bw() +
      ggtitle(names(subsets_list)[[subset_no]]) +
      scale_fill_brewer(name = "Offender Race", palette = "Set1", labels = c("White", "Black"))
    p
  })
  
  plots_grid <- grid_arrange_shared_legend(plots_list[[1]], plots_list[[2]], plots_list[[3]])
  
  title <- paste0("Agencies' Mean Percent of Offenders Arrested by ", variable_nice)
  g <- arrangeGrob(plots_grid, top = textGrob(title, gp = gpar(fontsize = 16)))
  
  g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from 2013 NIBRS and LEMAS, and offenders arrested only for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations.",
                                      x = unit(0.02, "npc"), just = "left",
                                      gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))
  
  filename <- paste0("bw_", variable, '.png')
  ggsave(filename, plot = g2, dpi = 300, width = 12, height = 10)
  
  NULL
})