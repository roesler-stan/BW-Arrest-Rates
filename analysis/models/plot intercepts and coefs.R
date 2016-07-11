library(lme4)
library(ggplot2)
library(plyr)
library(Rmisc)
library(gridExtra)
library(grid)

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots")

models_to_plot <- list("Simple Assault" = models_wvictims[[1]][[1]],
                      "Aggravated Assault" = models_wvictims[[2]][[1]],
                      "Intimidation" = models_wvictims[[3]][[1]],
                      "Robbery" = models_wvictims[[4]][[1]],
                      "Shoplifting" = models[[1]][[1]],
                      "Vandalism" = models[[2]][[1]],
                      "Drugs / Narcotics" = models[[3]][[1]],
                      "Drug Equipment" = models[[4]][[1]])

ori_data <- ddply(dataset, .(ori), summarise,
                  w_officers_percent_standardized = mean(w_officers_percent_standardized),
                  b_officers_percent_standardized = mean(b_officers_percent_standardized),
                  male_officers_percent_standardized = mean(male_officers_percent_standardized),
                  bdgt_ttl_standardized = mean(bdgt_ttl_standardized),
                  ftsworn_standardized = mean(ftsworn_standardized),
                  bdgt_per_ftoff_standardized = mean(bdgt_per_ftoff_standardized),
                  agency_bdgt_per_offender_standardized = mean(agency_bdgt_per_offender_standardized),
                  com_bt = mean(com_bt),
                  tech_typ_vpat = mean(tech_typ_vpat),
                  hir_trn_no_p = mean(hir_trn_no_p),
                  min_hiring_educ_gths = mean(min_hiring_educ_gths),
                  w_officers_percent_mean = mean(w_officers_percent))

plots_list <- lapply(seq_along(models_to_plot), function(i) {
  random_coefs <- data.frame(ranef(models_to_plot[[i]])[[1]])
  random_coefs <- rename(random_coefs, c("X.Intercept." = "intercept", 
                                         "black_not_white" = "black_not_white_coef"))
  random_coefs$ori <- rownames(random_coefs)
  coefs_ori <- merge(random_coefs, ori_data, by = "ori")
  
  # Plot varying slope coefficient for black_not_white by agency percent officers white
  intercept_plot <- ggplot(coefs_ori, aes(x = w_officers_percent_standardized, y = intercept)) +
    geom_point(size = 1) + theme_bw() + ggtitle(names(models_to_plot)[[i]]) +
    xlab('% Officers White (Standardized)') + ylab('Varying Intercept') +
    theme(title = element_text(size = 10)) +
    theme(axis.title = element_text(size = 8)) +
    theme(axis.text = element_text(size = 6)) +
    stat_smooth(method = "loess")

  coef_plot <- ggplot(coefs_ori, aes(x = w_officers_percent_standardized, y = black_not_white_coef)) +
    geom_point(size = 1) + theme_bw() + ggtitle(names(models_to_plot)[[i]]) +
    xlab('% Officers White (Standardized)') + ylab('Varying Race Coefficient (Black)') +
    theme(title = element_text(size = 10)) +
    theme(axis.title = element_text(size = 8)) +
    theme(axis.text = element_text(size = 6)) +
    stat_smooth(method = "loess")
  
  list(intercept_plot, coef_plot)
})

intercept_plots <- grid.arrange(plots_list[[1]][[1]], plots_list[[2]][[1]],
                                plots_list[[3]][[1]], plots_list[[4]][[1]],
                                plots_list[[5]][[1]], plots_list[[6]][[1]],
                                plots_list[[7]][[1]], plots_list[[8]][[1]],
             ncol = 3, nrow = 3, top = "Varying Intercepts by Percent Officers White")

g <- arrangeGrob(intercept_plots, sub = textGrob("Note: Data are from merged data set, particularly 2013 NIBRS offenders data and 2013 LEMAS police data. Offenders arrested for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations, with 95% confidence intervals shaded gray.",
                                    x = unit(0.02, "npc"), just = "left",
                                    gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("intercepts.png", plot = g, dpi = 600, width = 12, height = 10)


coef_plots <- grid.arrange(plots_list[[1]][[2]], plots_list[[2]][[2]],
                                plots_list[[3]][[2]], plots_list[[4]][[2]],
                                plots_list[[5]][[2]], plots_list[[6]][[2]],
                                plots_list[[7]][[2]], plots_list[[8]][[2]],
                                ncol = 3, nrow = 3, top = "Varying Race Coefficients by Percent Officers White")

g <- arrangeGrob(coef_plots, sub = textGrob("Note: Data are from merged data set, particularly 2013 NIBRS offenders data and 2013 LEMAS police data. Offenders arrested for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations, with 95% confidence intervals shaded gray.",
                                                 x = unit(0.02, "npc"), just = "left",
                                                 gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("coefs.png", plot = g, dpi = 600, width = 12, height = 10)



# Intimidation Coefficient
random_coefs <- data.frame(ranef(models_to_plot[[3]])[[1]])
random_coefs <- rename(random_coefs, c("X.Intercept." = "intercept", 
                                       "black_not_white" = "black_not_white_coef"))
random_coefs$ori <- rownames(random_coefs)
coefs_ori <- merge(random_coefs, ori_data, by = "ori")

g <- ggplot(coefs_ori, aes(x = w_officers_percent_standardized, y = black_not_white_coef)) +
  geom_point(size = 1) + theme_bw() +
  ggtitle("Intimidation Varying Race Coefficient by Percent Officers White") +
  xlab('% Officers White (Standardized)') + ylab('Varying Race Coefficient (Black)') +
  theme(title = element_text(size = 10)) +
  theme(axis.title = element_text(size = 12)) +
  theme(axis.text = element_text(size = 10)) +
  stat_smooth(method = "loess") + scale_x_continuous(breaks = c(-2, -1, 0, 0.1, 0.2, 0.3, 0.4))

g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from 2013 NIBRS offenders and 2013 LEMAS police data for intimidation offenders. Offenders arrested for other offenses are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations, with 95% confidence intervals shaded gray.",
                                    x = unit(0.02, "npc"), just = "left",
                                    gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("intimidation_coef.png", g2, dpi = 600, width = 12, height = 10)


# Simple Assault Coefficient
random_coefs <- data.frame(ranef(models_to_plot[[1]])[[1]])
random_coefs <- rename(random_coefs, c("X.Intercept." = "intercept", 
                                       "black_not_white" = "black_not_white_coef"))
random_coefs$ori <- rownames(random_coefs)
coefs_ori <- merge(random_coefs, ori_data, by = "ori")

# Plot varying slope coefficient for black_not_white by agency percent officers white
g <- ggplot(coefs_ori, aes(x = w_officers_percent_standardized, y = black_not_white_coef)) +
  geom_point(size = 1) + theme_bw() +
  ggtitle("Simple Assault Varying Race Coefficient by Percent Officers White") +
  xlab('% Officers White (Standardized)') + ylab('Varying Race Coefficient (Black)') +
  theme(title = element_text(size = 10)) +
  theme(axis.title = element_text(size = 12)) +
  theme(axis.text = element_text(size = 10)) +
  stat_smooth(method = "loess") + scale_x_continuous(breaks = c(-2, -1, 0, 0.1, 0.2, 0.3, 0.4))

g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from 2013 NIBRS offenders and 2013 LEMAS police data for simple assault offenders. Offenders arrested for other offenses are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations, with 95% confidence intervals shaded gray.",
                                            x = unit(0.02, "npc"), just = "left",
                                            gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("simple_assault_coef.png", g2, dpi = 600, width = 12, height = 10)


# Drug Equipment Intercept
random_coefs <- data.frame(ranef(models_to_plot[[8]])[[1]])
random_coefs <- rename(random_coefs, c("X.Intercept." = "intercept", 
                                       "black_not_white" = "black_not_white_coef"))
random_coefs$ori <- rownames(random_coefs)
coefs_ori <- merge(random_coefs, ori_data, by = "ori")

g <- ggplot(coefs_ori, aes(x = w_officers_percent_standardized, y = black_not_white_coef)) +
  geom_point(size = 1) + theme_bw() +
  ggtitle("Drug Equipment Varying Race Coefficient by Percent Officers White") +
  xlab('% Officers White (Standardized)') + ylab('Varying Race Coefficient (Black)') +
  theme(title = element_text(size = 10)) +
  theme(axis.title = element_text(size = 12)) +
  theme(axis.text = element_text(size = 10)) +
  stat_smooth(method = "loess")

g2 <- arrangeGrob(g, sub = textGrob("Note: Data are from 2013 NIBRS offenders and 2013 LEMAS police data for drug equipment offenders. Offenders arrested for other offenses are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations, with 95% confidence intervals shaded gray.",
                                    x = unit(0.02, "npc"), just = "left",
                                    gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("drug_equipment_coef.png", g2, dpi = 600, width = 12, height = 10)


# Offender mean and SD
mean(dataset$w_officers_percent, na.rm = T)
sd(dataset$w_officers_percent, na.rm = T)

# Agency mean and SD
mean(ori_data$w_officers_percent_mean, na.rm = T)
sd(ori_data$w_officers_percent_mean, na.rm = T)