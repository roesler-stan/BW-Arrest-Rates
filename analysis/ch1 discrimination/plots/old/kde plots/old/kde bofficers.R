# KDE plots by officers black and arrest status

pdf("officers.pdf")
# distribution of white officers
officers_kde <- ggplot(offenders_data, aes(x = b_officers_percent))
officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3)  +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers Black") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Offenders")
dev.off()

pdf("officers_b.pdf")
b_officers_kde <- ggplot(black_offenders, aes(x = b_officers_percent))
b_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers Black") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Black Offenders")
dev.off()

pdf("officers_w.pdf")
b_officers_kde <- ggplot(white_offenders, aes(x = b_officers_percent))
b_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers Black") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of White Offenders")
dev.off()