# KDE plots by officers white and arrest status - Drugs General

# distribution of white officers
png("officers_drugs_general.png")
officers_kde <- ggplot(drugs_general_data, aes(x = w_officers_percent))
officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3)  +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Drugs General Offenders")
dev.off()


png("officers_drugs_general_b.png")
b_officers_kde <- ggplot(b_drugs_general_data, aes(x = w_officers_percent))
b_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Black Drugs General Offenders")
dev.off()


png("officers_drugs_general_w.png")
w_officers_kde <- ggplot(w_drugs_general_data, aes(x = w_officers_percent))
w_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of White Drugs General Offenders")
dev.off()
