library(ggplot2)
library(plyr)
library(reshape)
library(grid)
library(gridExtra)
library("RColorBrewer")

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots")

subsets_list <- list("Robbery" = robbery_data,
                     "Aggravated Assault" = aggravated_assault_data,
                     "Simple Assault" = simple_assault_data,
                     "Intimidation" = intimidation_data,
                     "Weapon" = weapon_data,
                     "Shoplifting" = shoplifting_data,
                     "Vandalism" = vandalism_data,
                     "Drugs / Narcotics" = drugs_narcotics_data,
                     "Drug Equipment" = drug_equipment_data)

barplots_data_list <- lapply(seq_along(subsets_list), function(i) {
  subset_ori <- ddply(subsets_list[[i]], .(ori, black_not_white),
                      summarise, mean_arrested = mean(arrested) * 100)
  offenders_arrested <- ddply(subset_ori, .(black_not_white),
                      summarise, mean_arrested = mean(mean_arrested))
  offenders_arrested
})

TAB <- rbind(barplots_data_list[[1]], barplots_data_list[[2]],
             barplots_data_list[[3]], barplots_data_list[[4]],
             barplots_data_list[[5]], barplots_data_list[[6]],
             barplots_data_list[[7]], barplots_data_list[[8]],
             barplots_data_list[[9]])

df <- data.frame(TAB)
lapply(seq_along(subsets_list), function(i) {
  df[(i * 2) - 1, 'Offense'] <<- names(subsets_list)[[i]]
  df[i * 2, 'Offense'] <<- names(subsets_list)[[i]]
})
df$black_not_white[df$black_not_white == 1] <- 'Black'
df$black_not_white[df$black_not_white == 0] <- 'White'
df$black_not_white <- factor(df$black_not_white, levels = c('White', 'Black'))

df$Offense <- factor(df$Offense, levels = names(subsets_list))


p <- ggplot(df, aes(x = Offense, y = mean_arrested, fill = factor(black_not_white))) +
  geom_bar(stat = "identity", position = "dodge") +
  ylab("Percent Arrested") + xlab("Offense") +
  ggtitle("Agencies' Percent Black and White Offenders Arrested") + theme_bw() +
  ylim(0, 100) + scale_fill_brewer(name = "Offender Race", palette = "OrRd") +
  theme(axis.text.x = element_text(size = 12, angle = 45, vjust = 0.5),
        axis.title = element_text(size = 16),
        plot.title = element_text(size = 18)) +
  geom_text(data = df[df$black_not_white == 'White',],
            aes(label = round(mean_arrested, 0), hjust = 1.9, vjust = -0.5), size = 4) +
  geom_text(data = df[df$black_not_white == 'Black',],
            aes(label = round(mean_arrested, 0), hjust = -0.7, vjust = -0.5), size = 4)

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS offenders data. Offenders arrested for offenses other than the offense examined are omitted, as are police agencies with fewer than\n10 offenders for the given offense.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("barplot_agency_arrest_rates.png", g, dpi = 400, width = 12, height = 10)
