# Compare # offenders for weapons, drugs/narcotics, and drug equipment
library(ggplot2)
library(gtools)
library(plyr)
library(scales)

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots")

plot_data <- data.frame()

subsets_list <- list("Robbery" = robbery_data,
                     "Aggravated Assault" = aggravated_assault_data,
                     "Simple Assault" = simple_assault_data,
                     "Intimidation" = intimidation_data,
                     "Weapon" = weapon_data,
                     "Shoplifting" = shoplifting_data,
                     "Vandalism" = vandalism_data,
                     "Drugs / Narcotics" = drugs_narcotics_data,
                     "Drug Equipment" = drug_equipment_data)

plots_list <- lapply(seq_along(subsets_list), function(subset_no) {
  subset_data <- subsets_list[[subset_no]]
  arrested <- subset(subset_data, arrested == 1)
  not_arrested <- subset(subset_data, arrested == 0)

  row1 <- data.frame("Offense" = names(subsets_list)[[subset_no]], "Type" = "Not Arrested",
                     "Offenders" = dim(not_arrested)[[1]])
  row2 <- data.frame("Offense" = names(subsets_list)[[subset_no]], "Type" = "Arrested",
                     "Offenders" = dim(arrested)[[1]])
  plot_data <<- smartbind(plot_data, row1)
  plot_data <<- smartbind(plot_data, row2)
})

plot_data <- unique(plot_data)

ggplot(plot_data, aes(x = Offense, y = Offenders, fill = Type)) +
  geom_bar(stat = "identity", position = "dodge") + scale_y_continuous(label = comma) +
  theme_bw() + ggtitle("Number of Criminal Offenders") +
  scale_fill_brewer(name = "Offender Status", palette = "OrRd") +
  theme(axis.text.x = element_text(size = 10, angle = 45, vjust = 0.5))

ggsave("offenders.png", dpi = 300, width = 12, height = 10)
