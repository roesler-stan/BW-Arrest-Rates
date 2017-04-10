## Plot each offense's scatterplot separately

library(ggplot2)
library(reshape2)
library(plyr)
library(gridExtra)
library(grid)
library("RColorBrewer")

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots/scatterplots")

subsets_list <- list("All Crimes" = dataset,
                     "Simple Assault" = simple_assault_data,
                     "Aggravated Assault" = aggravated_assault_data,
                     "Intimidation" = intimidation_data,
                     "Robbery" = robbery_data,
                     "Shoplifting" = shoplifting_data,
                     "Vandalism" = vandalism_data,
                     "Narcotics" = drugs_narcotics_data,
                     "Drug Equipment" = drug_equipment_data)

lapply(seq_along(subsets_list), function(i) {
  subset_data <- subsets_list[[i]]
  offense <- names(subsets_list)[[i]]
  
  # % arrested
  w_officers_arrested <- ddply(subset_data, .(w_officers_percent, black_not_white),
                               summarise, mean_arrested = mean(arrested) * 100,
                               sd_arrested = sd(arrested),
                               offenders_count = sum(!is.na(arrested)))

  subset_file <- paste('../data/', offense, 'wofficers.csv', sep = '')
  write.csv(w_officers_arrested, subset_file, row.names = F)
  
  title <- paste("Percent", offense, "Offenders Arrested by Agencies' Percent Officers White")
  if (offense == "All Crimes") {
    print('yay')
    title <- "Percent Offenders Arrested by Agencies' Percent Officers White"
  }
  p <- ggplot(w_officers_arrested, aes(x = w_officers_percent, y = mean_arrested,
                                       color = factor(black_not_white),
                                       size = offenders_count)) +
    geom_point(alpha = 7/10) + scale_size(range = c(1, 3), guide = 'none') +
    stat_smooth(method = "loess", se = F) +
    xlab("Percent Officers White") + ylab(paste("Percent", offense, "Offenders Arrested")) +
    xlim(30, 100) + ylim(0, 100) + theme_bw() +
    ggtitle(title) +
    scale_color_brewer(name = "Offender Race", palette = "Accent", labels = c("White", "Black"))
  
  g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS offenders data and 2013 LEMAS police data. Offenders arrested for offenses other than the offense examined are omitted.\nLines are locally weighted regression (LOESS) models fit to the observations.",
                                     x = unit(0.02, "npc"), just = "left",
                                     gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))
  
  filename <- paste("wofficers_percent_arrested_", offense, ".png", sep = '')
  ggsave(filename, plot = g, dpi = 300, width = 12, height = 10)

  # Arrested vs. not
  title <- paste(offense, "Offenders Arrested by Agencies' Percent Officers White")
  if (offense == "All Crimes") {
    title <- "Offenders Arrested by Agencies' Percent Officers White"
  }
  
  p <- ggplot(subset_data, aes(x = w_officers_percent, y = arrested, color = factor(black_not_white))) +
    geom_point(alpha = 4/10, position = position_jitter(height = 0.1)) + 
    stat_smooth(se = F) +
    xlab("Percent Officers White") + ylab("Arrested") +
    xlim(30, 100) + theme_bw() + ggtitle(title) +
    scale_color_brewer(name = "Offender Race", palette = "Accent", labels = c("White", "Black"))
  
  g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS offenders data and 2013 LEMAS police data. Offenders arrested for offenses other than the offense examined are omitted.\nLines are generalized additive models (GAM) fit to the observations.",
                                     x = unit(0.02, "npc"), just = "left",
                                     gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))
  
  filename <- paste("wofficers_raw_", offense, ".png", sep = '')
  ggsave(filename, plot = g, dpi = 300, width = 12, height = 10)
})


all_data <- data.frame()
## Create a file with all subset's data together
lapply(seq_along(subsets_list), function(i) {
  subset_data <- subsets_list[[i]]
  offense <- names(subsets_list)[[i]]
  offense_clean <- chartr(" ", "_", offense)
  offense_clean <- tolower(offense_clean)
  
  w_officers_arrested <- ddply(subset_data, .(w_officers_percent, black_not_white),
                               summarise, mean_arrested = mean(arrested) * 100,
                               offenders_count = sum(!is.na(arrested)))

  mean_name <- paste("mean_arrested", offense_clean, sep = '_')
  count_name <- paste("offenders_count", offense_clean, sep = '_')
  w_officers_arrested <- rename(w_officers_arrested, c("mean_arrested" = mean_name,
                                                       "offenders_count" = count_name))
  
  if (i == 1) {
    all_data <<- w_officers_arrested
  } else {
    all_data <<- merge(all_data, w_officers_arrested, by = c('w_officers_percent',
                                                            'black_not_white'), all = T)    
  }
  NULL
})

filename <- '../data/wofficers_byoffense.csv'
write.csv(all_data, filename, row.names = F)
