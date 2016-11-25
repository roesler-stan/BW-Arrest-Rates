library(ggplot2)
library(plyr)
library(reshape)
library(grid)
library(gridExtra)
library(RColorBrewer)

grep('date', names(dataset), value = T)
grep('day', names(dataset), value = T)

dataset$sameday_arrest[dataset$arrested == 1] <- 1
dataset$sameday_arrest[is.na(dataset$incident_to_arrest_days)] <- NA
dataset$sameday_arrest[dataset$incident_to_arrest_days > 0] <- 0

table(dataset$sameday_arrest)

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots")

arrested_offenders <- subset(dataset, arrested == 1)

# Make subsets for each offense, excluding anyone who was arrested for an offense other than the one examined
robbery_arrested <- subset(arrested_offenders, offense_robbery == 1)
robbery_arrested <- subset(robbery_arrested, arrested == 0 | arrest_robbery == 1)

aggravated_assault_arrested <- subset(arrested_offenders, offense_aggravated_assault == 1)
aggravated_assault_arrested <- subset(aggravated_assault_arrested, arrested == 0 | arrest_aggravated_assault == 1)

simple_assault_arrested <- subset(arrested_offenders, offense_simple_assault == 1)
simple_assault_arrested <- subset(simple_assault_arrested, arrested == 0 | arrest_simple_assault == 1)

intimidation_arrested <- subset(arrested_offenders, offense_intimidation == 1)
intimidation_arrested <- subset(intimidation_arrested, arrested == 0 | arrest_intimidation == 1)

weapon_arrested <- subset(arrested_offenders, offense_weapon == 1)
weapon_arrested <- subset(weapon_arrested, arrested == 0 | arrest_weapon == 1)

shoplifting_arrested <- subset(arrested_offenders, offense_shoplifting == 1)
shoplifting_arrested <- subset(shoplifting_arrested, arrested == 0 | arrest_shoplifting == 1)

vandalism_arrested <- subset(arrested_offenders, offense_vandalism == 1)
vandalism_arrested <- subset(vandalism_arrested, arrested == 0 | arrest_vandalism == 1)

drugs_narcotics_arrested <- subset(arrested_offenders, offense_drugs_narcotics == 1)
drugs_narcotics_arrested <- subset(drugs_narcotics_arrested, arrested == 0 | arrest_drugs_narcotics == 1)

drug_equipment_arrested <- subset(arrested_offenders, offense_drug_equipment == 1)
drug_equipment_arrested <- subset(drug_equipment_arrested, arrested == 0 | arrest_drug_equipment == 1)


offenders_sameday <- tapply(arrested_offenders$sameday_arrest, arrested_offenders$black_not_white, FUN = mean, na.rm=TRUE) * 100
robbery_sameday <- tapply(robbery_arrested$sameday_arrest, robbery_arrested$black_not_white, FUN = mean, na.rm=TRUE) * 100
aggravated_assault_sameday <- tapply(aggravated_assault_arrested$sameday_arrest, aggravated_assault_arrested$black_not_white, FUN = mean, na.rm=TRUE) * 100
simple_assault_sameday <- tapply(simple_assault_arrested$sameday_arrest, simple_assault_arrested$black_not_white, FUN = mean, na.rm=TRUE) * 100
intimidation_sameday <- tapply(intimidation_arrested$sameday_arrest, intimidation_arrested$black_not_white, FUN = mean, na.rm=TRUE) * 100
weapon_sameday <- tapply(weapon_arrested$sameday_arrest, weapon_arrested$black_not_white, FUN = mean, na.rm=TRUE) * 100
shoplifting_sameday <- tapply(shoplifting_arrested$sameday_arrest, shoplifting_arrested$black_not_white, FUN = mean, na.rm=TRUE) * 100
vandalism_sameday <- tapply(vandalism_arrested$sameday_arrest, vandalism_arrested$black_not_white, FUN = mean, na.rm=TRUE) * 100
drugs_narcotics_sameday <- tapply(drugs_narcotics_arrested$sameday_arrest, drugs_narcotics_arrested$black_not_white, FUN = mean, na.rm=TRUE) * 100
drug_equipment_sameday <- tapply(drug_equipment_arrested$sameday_arrest, drug_equipment_arrested$black_not_white, FUN = mean, na.rm=TRUE) * 100

TAB <- rbind(offenders_sameday, robbery_sameday, aggravated_assault_sameday, simple_assault_sameday,
             intimidation_sameday, weapon_sameday,
             shoplifting_sameday, vandalism_sameday, drugs_narcotics_sameday, drug_equipment_sameday)

df <- data.frame(TAB)
df <- rename(df, c("X0" = "White", "X1" = "Black"))
df <- t(df)

Names <- names(df)
df.m <- melt(df, id.vars = Names)

df.m$X2 <- factor(df.m$X2,
                  levels = c("offenders_sameday", "robbery_sameday", "aggravated_assault_sameday",  "simple_assault_sameday",
                             "intimidation_sameday", "weapon_sameday", "shoplifting_sameday", 
                             "vandalism_sameday", "drugs_narcotics_sameday", "drug_equipment_sameday"),
                  labels = c("All", "Robbery", "Aggravated Assault", "Simple Assault",
                             "Intimidation", "Weapon",
                             "Shoplifting", "Vandalism", "Drugs / Narcotics", "Drug Equipment"))

table_X2 <- table(df.m$X2)
x_levels <- names(table_X2)[order(table_X2)]
df.m$X2 <- factor(df.m$X2, levels = x_levels)
df.m$X1 <- factor(df.m$X1, levels = c('White', 'Black'))


p <- ggplot(df.m, aes(X2, value)) +   
  geom_bar(aes(fill = X1), position = "dodge", stat="identity") +
  ylab("Percent Arrested on Same Day as Incident") + xlab("Offense") +
  ggtitle("Percent of Arrested Offenders who are Arrested on Same Day as Incident") + theme_bw() +
  ylim(0, 100) + scale_fill_brewer(name = "Offender Race", palette = "OrRd") +
  theme(axis.text.x = element_text(size = 10, angle = 45, vjust = 0.5)) +
  geom_text(data = df.m[df.m$X1 == 'White',],
            aes(label = round(value, 0), hjust = 1.9, vjust = -0.5), size = 4) +
  geom_text(data = df.m[df.m$X1 == 'Black',],
            aes(label = round(value, 0), hjust = -0.7, vjust = -0.5), size = 4)

g <- arrangeGrob(p, sub = textGrob("Note: Data are from 2013 NIBRS Offenders data. Offenders arrested for offenses other than the offense examined are omitted, as are police agencies with fewer than 10 offenders\nfor the given offense.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("barplot_sameday.png", g, dpi = 400, width = 12, height = 10)