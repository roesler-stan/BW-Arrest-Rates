p <- ggplot(plot_data, aes(x=offense, y=mean_arrested, color=factor(black_not_white))) +
  geom_errorbar(limits, width=0.25) +
  ylab("Percent Arrested") + xlab("Offense") + ylim(0, 100) +
  ggtitle("Percent Male Offenders Arrested") + theme_classic() +
  scale_color_brewer(name = "Offender Race", palette = "Accent", labels=c("White", "Black")) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        plot.title = element_text(hjust = 0.6), text = element_text(family="serif"),
        legend.background = element_rect(colour = "gray"))