# KDE plots by officers-residents white and arrest status, drugs general data
# For both black and white offenders, whiter officers vs. residents = more likely to arrest

pdf("wofficers_minusres_drugs_general.pdf")
# distribution of white officers
officers_kde <- ggplot(drugs_general_data, aes(x = wofficers_minusres))
officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3)  +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers - Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Drugs General Offenders")
dev.off()

pdf("wofficers_minusres_b_drugs_general.pdf")
b_officers_kde <- ggplot(b_drugs_general_data, aes(x = wofficers_minusres))
b_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers - Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Black Drugs General Offenders")
dev.off()

pdf("wofficers_minusres_w_drugs_general.pdf")
w_officers_kde <- ggplot(w_drugs_general_data, aes(x = wofficers_minusres))
w_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("% Officers - Residents White") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of White Drugs General Offenders")
dev.off()