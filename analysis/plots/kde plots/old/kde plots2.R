# Different method of producing KDE plots - worse colors

pdf("b_officers2.pdf")
# Black offenders' distribution
b <- ggplot(black_offenders, aes(x = w_officers_percent, colour = factor(arrested),
                                 group = factor(arrested)))

b + geom_density() + xlab("% Officers White") +
  ylab("Density") + ggtitle("Distribution of Black Offenders") + 
  scale_colour_discrete("Arrest Status",
                        labels = c("Not arrested", "Arrested")) + theme_bw()
dev.off()


pdf("w_officers2.pdf")
# White offenders' distribution
w <- ggplot(white_offenders, aes(x = w_officers_percent, colour = factor(arrested),
                                 group = factor(arrested)))

w + geom_density() + xlab("% Officers White") +
  ylab("Density") + ggtitle("Distribution of Black Offenders") + 
  scale_colour_discrete("Arrest Status",
                        labels = c("Not arrested", "Arrested")) + theme_bw()
dev.off()
