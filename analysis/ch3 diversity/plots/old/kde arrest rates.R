setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/plots")

# distribution of white officers
ggplot(white_offenders, aes(x = w_officers_percent)) +
  geom_density(aes(fill = factor(arrested)), alpha = 2/3)  +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of White Offenders")
ggsave('w_officers_percent.png', dpi = 400)

ggplot(black_offenders, aes(x = w_officers_percent)) +
  geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Black Offenders")
ggsave('w_officers_percent_b.png', dpi = 400)
