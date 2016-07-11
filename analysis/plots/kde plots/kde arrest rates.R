# distribution of white officers
ggplot(shoplifting_data, aes(x = w_officers_percent)) +
  geom_density(aes(fill = factor(arrested)), alpha = 2/3)  +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Offenders")
ggsave('w_officers_percent.png', dpi = 600, width = 12, height = 10)


ggplot(black_offenders, aes(x = w_officers_percent)) +
  geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Black Offenders")
ggsave('w_officers_percent_b.png', dpi = 600, width = 12, height = 10)

png("w_officers_percent_w.png")
w_officers_kde <- ggplot(white_offenders, aes(x = w_officers_percent))
w_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of White Offenders")
dev.off()
