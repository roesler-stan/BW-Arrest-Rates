# KDE plots by agency budget and offender arrest status - Theft General
# Larger budget is related to lower likelihood of arrest.

# distribution of white officers
pdf("bdgt_ttl_theft_general.pdf")
officers_kde <- ggplot(theft_general_data, aes(x = bdgt_ttl))
officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3)  +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("Total Budget (Millions)") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Theft General Offenders")
dev.off()


pdf("bdgt_ttl_theft_general_b.pdf")
b_officers_kde <- ggplot(b_theft_general_data, aes(x = bdgt_ttl))
b_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("Total Budget (Millions)") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Black Theft General Offenders")
dev.off()


pdf("bdgt_ttl_theft_general_w.pdf")
w_officers_kde <- ggplot(w_theft_general_data, aes(x = bdgt_ttl))
w_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("Total Budget (Millions)") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of White Theft General Offenders")
dev.off()