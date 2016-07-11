library(ggplot2)
library(plyr)
library(reshape)
library(grid)
library(gridExtra)
library("RColorBrewer")

setwd("~/Dropbox/Projects/Mugshots Project/Output/plots")

simple_assault_arrested <- tapply(simple_assault_data_white_victim$arrested, simple_assault_data_white_victim$black_not_white, FUN = mean, na.rm=TRUE) * 100
aggravated_assault_arrested <- tapply(aggravated_assault_data_white_victim$arrested, aggravated_assault_data_white_victim$black_not_white, FUN = mean, na.rm=TRUE) * 100
intimidation_arrested <- tapply(intimidation_data_white_victim$arrested, intimidation_data_white_victim$black_not_white, FUN = mean, na.rm=TRUE) * 100
robbery_arrested <- tapply(robbery_data_white_victim$arrested, robbery_data_white_victim$black_not_white, FUN = mean, na.rm=TRUE) * 100

TAB <- rbind(simple_assault_arrested, aggravated_assault_arrested, intimidation_arrested,
             robbery_arrested)

df <- data.frame(TAB)
df <- rename(df, c("X0" = "White", "X1" = "Black"))
df <- t(df)

Names <- names(df)
df.m <- melt(df, id.vars = Names)

df.m$X2 <- factor(df.m$X2,
                  levels = c("simple_assault_arrested", "aggravated_assault_arrested", 
                             "intimidation_arrested", "robbery_arrested"),
                  labels = c("Simple Assault", "Aggravated Assault", "Intimidation", "Robbery"))

table_X2 <- table(df.m$X2)
x_levels <- names(table_X2)[order(table_X2)]
df.m$X2 <- factor(df.m$X2, levels = x_levels)
df.m$X1 <- factor(df.m$X1, levels = c('White', 'Black'))

p <- ggplot(df.m, aes(X2, value)) +   
  geom_bar(aes(fill = X1), position = "dodge", stat="identity") +
  ylab("Percent Arrested") + xlab("Offense") +
  ggtitle("Percent Offenders with a White Victim Arrested") + theme_bw() +
  ylim(0, 100) + scale_fill_brewer(name = "Offender Race", palette = "OrRd") +
  theme(axis.text.x = element_text(size = 10, angle = 45, vjust = 0.5)) +
  geom_text(data = df.m[df.m$X1 == 'White',],
            aes(label = round(value, 0), hjust = 3.5, vjust = -0.5), size = 4) +
  geom_text(data = df.m[df.m$X1 == 'Black',],
            aes(label = round(value, 0), hjust = -2.3, vjust = -0.5), size = 4)

g <- arrangeGrob(p, sub = textGrob("Note: Data are from merged data set, particularly 2013 NIBRS Offenders data. Only offenders who committed the offense alone against a single white victim are included,\nand offenders arrested for offenses other than the offense examined are omitted, as are police agencies with fewer than 10 offenders for the given offense.",
                                   x = unit(0.02, "npc"), just = "left",
                                   gp = gpar(fontsize = 10)), nrow = 2, heights = c(20, 1))

ggsave("barplot_arrest_rates_white_victim.png", g, dpi = 400, width = 12, height = 10)