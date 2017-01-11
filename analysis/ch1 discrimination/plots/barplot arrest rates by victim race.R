library(ggplot2)
library(plyr)
library(grid)
library(gridExtra)
library(RColorBrewer)
library(gtools)

setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/plots")

subsets_list <- list("Robbery" = robbery_data_with_victim,
                       "Aggravated Assault" = aggravated_assault_data_with_victim,
                       "Simple Assault" = simple_assault_data_with_victim,
                       "Intimidation" = intimidation_data_with_victim)

plot_data <- data.frame()
nothing <- lapply(seq_along(subsets_list), function(i) {
  subset_name <- names(subsets_list)[[i]]
  subset_data <- subsets_list[[i]]
  subset_data$victim_black_not_white[subset_data$victim_analyzing_race == 'white'] <- 0
  subset_data$victim_black_not_white[subset_data$victim_analyzing_race == 'black'] <- 1
  
  subset_means <- ddply(subset(subset_data, !is.na(victim_black_not_white)),
                        .(black_not_white, victim_black_not_white), summarise,
                        arrested = mean(arrested, na.rm=T) * 100)
  subset_means$offense <- subset_name
  #subset_means$type <- paste0("o_", subset_means$black_not_white, "v_", subset_means$victim_black_not_white)
  plot_data <<- smartbind(plot_data, subset_means)
  NULL
})
plot_data <- unique(plot_data)
row.names(plot_data) <- NULL
offense_levels <- c("Robbery", "Aggravated Assault", "Simple Assault", "Intimidation")
plot_data$offense <- factor(plot_data$offense,
                  levels=offense_levels, labels=offense_levels)

tg <- textGrob("Note: Data are from 2013 NIBRS offenders data. Offenders arrested for offenses other than the offense examined are omitted, as are police agencies with fewer than 10 offenders\nfor the given offense.",
               x = unit(0.02, "npc"), just = "left",
               gp = gpar(fontsize=6, fontfamily="serif"))

races <- list("Black" = 1, "White" = 0)
nothing <- lapply(seq_along(races), function(i) {
  race <- names(races)[[i]]
  race_value <- races[[i]]
  plot_subset <- subset(plot_data, victim_black_not_white==race_value)
  p <- ggplot(plot_subset, aes(x=offense, y=arrested,
                               fill=factor(black_not_white))) +
    geom_bar(position="dodge", stat="identity") + ylim(0, 60) +
    scale_fill_brewer(name = "Offender Race", palette = "OrRd", labels=c("White", "Black")) +
    ylab("Percent Arrested") + xlab("Offense") + theme_classic() +
    ggtitle(paste0("Percent Offenders with ", race, " Victim Arrested")) +
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
          plot.title = element_text(hjust = 0.5),
          text = element_text(family="serif"),
          legend.background = element_rect(colour = "gray")) +
    geom_text(data = plot_subset[plot_subset$black_not_white == 0,],
              aes(label = round(arrested, 0), hjust = 2.9, vjust = -0.5, family="serif"), size = 3) +
    geom_text(data = plot_subset[plot_subset$black_not_white == 1,],
              aes(label = round(arrested, 0), hjust = -1.8, vjust = -0.5, family="serif"), size = 3)
  
  g <- arrangeGrob(p, sub = tg, nrow=2, heights=c(20, 1))
  ggsave(paste0("barplot_", race, "_victim.png"), g, dpi=400)
  NULL
})
