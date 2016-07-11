# KDE plots by officers - residents white and arrest status
# No clear trend
# Young black offenders show no difference from all black offenders

pdf("wofficers_minusres.pdf")
# distribution of white officers
officers_kde <- ggplot(offenders_data, aes(x = wofficers_minusres))
officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3)  +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers - Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Offenders")
dev.off()

pdf("wofficers_minusres_b.pdf")
b_officers_kde <- ggplot(black_offenders, aes(x = wofficers_minusres))
b_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers - Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Black Offenders")
dev.off()

pdf("wofficers_minusres_w.pdf")
b_officers_kde <- ggplot(white_offenders, aes(x = wofficers_minusres))
b_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers - Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of White Offenders")
dev.off()