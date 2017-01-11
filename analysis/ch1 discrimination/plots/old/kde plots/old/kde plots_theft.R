# KDE plots by officers white and arrest status - Theft General

# distribution of white officers
pdf("officers_theft_general.pdf")
officers_kde <- ggplot(theft_general_data, aes(x = w_officers_percent))
officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3)  +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Theft General Offenders")
dev.off()


pdf("officers_theft_general_b.pdf")
b_officers_kde <- ggplot(b_theft_general_data, aes(x = w_officers_percent))
b_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Black Theft General Offenders")
dev.off()


pdf("officers_theft_general_w.pdf")
w_officers_kde <- ggplot(w_theft_general_data, aes(x = w_officers_percent))
w_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of White Theft General Offenders")
dev.off()
