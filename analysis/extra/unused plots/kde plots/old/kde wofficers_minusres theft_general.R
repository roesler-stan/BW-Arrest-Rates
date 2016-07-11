# KDE plots by officers-residents white and arrest status, theft general data
# Not much going on, but maybe whiter officers vs. residents = slightly more likely to arrest
# arrests seem like more normal distribution

pdf("wofficers_minusres_theft_general.pdf")
# distribution of white officers
officers_kde <- ggplot(theft_general_data, aes(x = wofficers_minusres))
officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3)  +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers - Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Theft General Offenders")
dev.off()

pdf("wofficers_minusres_b_theft_general.pdf")
b_officers_kde <- ggplot(b_theft_general_data, aes(x = wofficers_minusres))
b_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers - Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Black Theft General Offenders")
dev.off()

pdf("wofficers_minusres_w_theft_general.pdf")
w_officers_kde <- ggplot(w_theft_general_data, aes(x = wofficers_minusres))
w_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers - Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of White Theft General Offenders")
dev.off()