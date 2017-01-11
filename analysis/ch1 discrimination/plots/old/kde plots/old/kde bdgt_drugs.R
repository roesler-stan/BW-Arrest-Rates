# agency budget and drug offenders' likelihood of arrest
# strange u-shape - most offenders are in low-budget agencies
# No clear trend on effect of budget on likelihood of arrest

pdf("bdgt_ttl_drugs_general.pdf")
officers_kde <- ggplot(drugs_general_data, aes(x = bdgt_ttl))
officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3)  +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("Total Budget (Millions)") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Drugs General Offenders")
dev.off()


pdf("bdgt_ttl_drugs_general_b.pdf")
b_officers_kde <- ggplot(b_drugs_general_data, aes(x = bdgt_ttl))
b_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("Total Budget (Millions)") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of Black Drugs General Offenders")
dev.off()


pdf("bdgt_ttl_drugs_general_w.pdf")
w_officers_kde <- ggplot(w_drugs_general_data, aes(x = bdgt_ttl))
w_officers_kde + geom_density(aes(fill = factor(arrested)), alpha = 2/3) +
  scale_fill_manual("Arrest Status", values = c("seagreen", "dodgerblue2"),
                    labels = c("Not arrested", "Arrested")) +
  xlab("Total Budget (Millions)") + ylab("Density") + theme_bw() +
  ggtitle("Distribution of White Drugs General Offenders")
dev.off()