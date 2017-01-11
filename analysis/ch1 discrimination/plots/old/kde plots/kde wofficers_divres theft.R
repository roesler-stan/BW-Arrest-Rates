# KDE plots by officers white and arrest status

png("wofficers_divres_theft.png")
officers_kde <- ggplot(theft_general_data, aes(x = wofficers_divres))
officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3)  +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers / Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Theft Offenders") + xlim(0, 2.5)
dev.off()

png("wofficers_divres_theft_b.png")
b_officers_kde <- ggplot(subset(theft_general_data, theft_general_data$black_not_white == 1),
                         aes(x = wofficers_divres))
b_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers / Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Black Theft Offenders") + xlim(0, 2.5)
dev.off()

png("wofficers_divres_theft_w.png")
w_officers_kde <- ggplot(subset(theft_general_data, theft_general_data$black_not_white == 0),
                         aes(x = wofficers_divres))
w_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers / Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of White Theft Offenders") + xlim(0, 2.5)
dev.off()