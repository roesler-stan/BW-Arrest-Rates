library(ggplot2)
library(plyr)
library(reshape)
library(grid)
library(gridExtra)
library(RColorBrewer)

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots")

robbery_arrested <- tapply(robbery_data$arrested, robbery_data$black_not_white, FUN = mean, na.rm=TRUE) * 100
aggravated_assault_arrested <- tapply(aggravated_assault_data$arrested, aggravated_assault_data$black_not_white, FUN = mean, na.rm=TRUE) * 100
simple_assault_arrested <- tapply(simple_assault_data$arrested, simple_assault_data$black_not_white, FUN = mean, na.rm=TRUE) * 100
intimidation_arrested <- tapply(intimidation_data$arrested, intimidation_data$black_not_white, FUN = mean, na.rm=TRUE) * 100
weapon_arrested <- tapply(weapon_data$arrested, weapon_data$black_not_white, FUN = mean, na.rm=TRUE) * 100
shoplifting_arrested <- tapply(shoplifting_data$arrested, shoplifting_data$black_not_white, FUN = mean, na.rm=TRUE) * 100
vandalism_arrested <- tapply(vandalism_data$arrested, vandalism_data$black_not_white, FUN = mean, na.rm=TRUE) * 100
drugs_narcotics_arrested <- tapply(drugs_narcotics_data$arrested, drugs_narcotics_data$black_not_white, FUN = mean, na.rm=TRUE) * 100
drug_equipment_arrested <- tapply(drug_equipment_data$arrested, drug_equipment_data$black_not_white, FUN = mean, na.rm=TRUE) * 100

TAB <- rbind(robbery_arrested, aggravated_assault_arrested, simple_assault_arrested,
             intimidation_arrested, weapon_arrested,
             shoplifting_arrested, vandalism_arrested, drugs_narcotics_arrested, drug_equipment_arrested)

df <- data.frame(TAB)
df <- rename(df, c("X0" = "White", "X1" = "Black"))
df <- t(df)

Names <- names(df)
df.m <- melt(df, id.vars = Names)

df.m$X2 <- factor(df.m$X2,
                  levels = c("robbery_arrested", "aggravated_assault_arrested",
                             "simple_assault_arrested", "intimidation_arrested",  "weapon_arrested",
                             "shoplifting_arrested", "vandalism_arrested",
                             "drugs_narcotics_arrested", "drug_equipment_arrested"),
                  labels = c("Robbery", "Aggravated Assault", "Simple Assault", "Intimidation",
                             "Weapon", "Shoplifting", "Vandalism", "Drugs / Narcotics", "Drug Equipment"))

table_X2 <- table(df.m$X2)
x_levels <- names(table_X2)[order(table_X2)]
df.m$X2 <- factor(df.m$X2, levels = x_levels)
df.m$X1 <- factor(df.m$X1, levels = c('White', 'Black'))


p <- ggplot(df.m, aes(X2, value)) +   
  geom_bar(aes(fill = X1), position = "dodge", stat="identity") +
  ylab("Percent Arrested") + xlab("Offense") +
  ggtitle("Percent Black and White Offenders Arrested") + theme_bw() +
  ylim(0, 100) + scale_fill_brewer(name = "Offender Race", palette = "OrRd") +
  theme(axis.text.x = element_text(size = 12, angle = 45, vjust = 0.5),
        axis.title = element_text(size = 16),
        plot.title = element_text(size = 18)) +
  geom_text(data = df.m[df.m$X1 == 'White',],
            aes(label = round(value, 0), hjust = 1.9, vjust = -0.5), size = 4) +
  geom_text(data = df.m[df.m$X1 == 'Black',],
            aes(label = round(value, 0), hjust = -0.7, vjust = -0.5), size = 4)

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS offenders data. Offenders arrested for offenses other than the offense examined are omitted, as are police agencies with fewer than\n10 offenders for the given offense.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("barplot_arrest_rates.png", g, dpi = 400, width = 12, height = 10)
