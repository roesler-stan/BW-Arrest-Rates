# WARNING- Scales are wrong - only counts an x-value if it has a value

# bin w_officers_percent into factor variable, then plot mean arrest rate
# this does not incorporate # offenders in each type of agency
shoplifting_data$w_officers_percent_cat <- cut(shoplifting_data$w_officers_percent, seq(0, 100, 1))

# se_arrested = (sd(arrested) / sqrt(sum(!is.na(arrested))))
w_officers_arrested <- ddply(subset(shoplifting_data, !is.na(shoplifting_data$w_officers_percent_cat)),
                             .(w_officers_percent_cat, black_not_white),
                             summarise, mean_arrested = mean(arrested) * 100,
                             sd_arrested = sd(arrested),
                             offenders_count = sum(!is.na(arrested)))

# line plot of average arrest rate by officers white, split by black_not_white
ggplot(w_officers_arrested, aes(x = w_officers_percent_cat,
                                y = mean_arrested, color = factor(black_not_white))) +
  #geom_point(aes(group = black_not_white)) +
  geom_line(aes(group = black_not_white)) +
  xlab("% Officers White") + ylab("% Offenders Arrested") +
  theme_bw() + ggtitle("Percent Offenders Arrested") +
  scale_colour_hue("Offender Race", labels = c("White", "Black")) +
  geom_errorbar(aes(ymin = mean_arrested - (1.96 * sd_arrested),
                    ymax = mean_arrested + (1.96 * sd_arrested)),
                position = "dodge", width = 0.1)
ggsave("shoplifting_wofficers_percent_arrested_grouped_5.png", dpi = 600, width = 12, height = 10)


# scatter plot of average arrest rate by officers white, split by black_not_white
xaxis_levels <- levels(w_officers_arrested$w_officers_percent_cat)[seq(30, 100, 10)]

ggplot(w_officers_arrested, aes(x = w_officers_percent_cat,
                                y = mean_arrested, color = factor(black_not_white))) +
  geom_point(alpha = 8/10) + stat_smooth(method = "loess", aes(group = black_not_white)) +
  xlab("% Officers White") + ylab("% Offenders Arrested") +
  theme_bw() + ggtitle("Percent Shoplifting Offenders Arrested") +
  scale_colour_hue("Offender Race", labels = c("White", "Black")) +
  scale_x_discrete(breaks = xaxis_levels)

ggsave("shoplifting_wofficers_percent_arrested_grouped_scatter_1.png", dpi = 600, width = 12, height = 10)


ggplot(w_officers_arrested, aes(x = w_officers_percent_cat,
                                y = mean_arrested, fill = factor(black_not_white))) +
  geom_bar(stat = "identity", position = "dodge") +
  ylab("% Arrested") + xlab("% Officers White") +
  ggtitle("% Arrested by Race and % Officers White") + theme_bw() +
  theme(axis.text.x = element_text(size = 10, angle = 45, vjust = 0.5)) +
  geom_text(data = w_officers_arrested[w_officers_arrested$black_not_white == 1,],
            aes(label = round(mean_arrested, 0), hjust = -1, vjust = -1), size = 4) +
  geom_text(data = w_officers_arrested[w_officers_arrested$black_not_white == 0,],
          aes(label = round(mean_arrested, 0), hjust = 2, vjust = -1), size = 4) +
  scale_fill_hue("Offender Race", labels = c("White", "Black"))
ggsave("barplot_wofficers_percent_arrested_grouped10.png", dpi = 600, width = 12, height = 10)




black_offenders$w_officers_percent_cat <- cut(black_offenders$w_officers_percent, seq(0, 100, 0.05))
b_arrests_wofficers <- tapply(black_offenders$arrested, black_offenders$w_officers_percent_cat, mean)

b_arrests_wofficers.df <- melt(b_arrests_wofficers)
b_arrests_wofficers.df <- rename(b_arrests_wofficers.df, c(Var1 = "w_officers_percent", value = "b_arrest_rate"))

ggplot(b_arrests_wofficers.df, aes(x = w_officers_percent, y = b_arrest_rate)) + 
  geom_point(size = 1) + xlab("% Officers White") + ylab("% Arrested") + theme_bw() +
  ggtitle("% Black Offenders Arrested by % Officers White")
