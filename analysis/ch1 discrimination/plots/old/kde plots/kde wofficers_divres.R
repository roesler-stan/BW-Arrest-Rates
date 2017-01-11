# KDE plots by officers white and arrest status

png("wofficers_divres.png")
# distribution of white officers
officers_kde <- ggplot(single_offenders, aes(x = wofficers_divres))
officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3)  +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers / Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Offenders") + xlim(0, 2.5)
dev.off()

png("wofficers_divres_b.png")
b_officers_kde <- ggplot(black_offenders, aes(x = wofficers_divres))
b_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers / Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Black Offenders") + xlim(0, 2.5)
dev.off()

png("wofficers_divres_w.png")
w_officers_kde <- ggplot(white_offenders, aes(x = wofficers_divres))
w_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers / Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of White Offenders") + xlim(0, 2.5)
dev.off()
