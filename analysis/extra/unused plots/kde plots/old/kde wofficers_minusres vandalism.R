# KDE plots by officers-residents white and arrest status, vandalism data


pdf("wofficers_minusres_vandalism.pdf")
# distribution of white officers
officers_kde <- ggplot(vandalism_data, aes(x = wofficers_minusres))
officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3)  +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers - Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Vandalism Offenders")
dev.off()

pdf("wofficers_minusres_b_vandalism.pdf")
b_officers_kde <- ggplot(b_vandalism_data, aes(x = wofficers_minusres))
b_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers - Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Black Vandalism Offenders")
dev.off()

pdf("wofficers_minusres_w_vandalism.pdf")
w_officers_kde <- ggplot(w_vandalism_data, aes(x = wofficers_minusres))
w_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers - Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of White Vandalism Offenders")
dev.off()