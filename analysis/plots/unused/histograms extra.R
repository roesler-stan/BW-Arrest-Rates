# Agencies with % Officers White
agencies_offenders <- ddply(dataset, .(ori),
                            summarise, offenders = sum(!is.na(black_not_white)))
# xlim = c(0, 200)
hist(agencies_offenders$offenders,
     main = "Agency Offender Counts", col = "gold",
     breaks = 10000, xlab = "# Offenders", ylab = "Agencies", xlim = c(0, 200))

describe(agencies_offenders$offenders)
# offenders_agencies


# Offenders with % Officers White
hist(dataset$w_officers_percent,
     main = "Distribution of Offenders", col = "gold",
     breaks = 100, xlab = "% Officers White", ylab = "Offenders")
# wofficers_offenders

# Agencies with % Officers White
agencies_officers <- ddply(dataset, .(ori),
                           summarise, w_officers_percent = mean(w_officers_percent))
hist(agencies_officers$w_officers_percent,
     main = "Distribution of Agencies", col = "gold",
     breaks = 100, xlab = "% Officers White", ylab = "Agencies")
# wofficers_agencies

# log officers
hist(log(dataset$w_officers_percent),
     main = "Distribution of Offenders", col = "gold",
     breaks = 100, xlab = "Log of % Officers White")

# % Officers / Residents White
hist(dataset$wofficers_divres,
     main = "Distribution of Offenders", col = "gold",
     breaks = 100, xlab = "% Officers / % Residents White")
# wofficers_divres_offenders


# Agencies with % Officers White
agencies_officers <- ddply(dataset, .(ori),
                           summarise, wofficers_divres = mean(wofficers_divres))
hist(agencies_officers$wofficers_divres,
     main = "Distribution of Agencies", col = "gold",
     breaks = 100, xlab = "% Officers / % Residents White", ylab = "Agencies")
# wofficers_divres_agencies


pdf("hist_boffenders_wofficers.pdf")
hist(black_offenders$w_officers_percent[black_offenders$arrested == 0],
     main = "Distribution of Black Offenders", col = "gold",
     breaks = 100, xlab = "% Officers White")

hist(black_offenders$w_officers_percent[black_offenders$arrested == 1],
     col = "firebrick2", add = T, breaks = 100)
dev.off()


pdf("hist_woffenders_wofficers.pdf")
hist(white_offenders$w_officers_percent[white_offenders$arrested == 0],
     main = "Distribution of White Offenders", col = "gold",
     breaks = 100, xlab = "% Officers White")

hist(white_offenders$w_officers_percent[white_offenders$arrested == 1],
     col = "firebrick2", add = T, breaks = 100)
dev.off()


# table of % police white and arrests - ignores # people per agency with % police white
arrested_by_police <- tapply(black_offenders$arrested,
                             black_offenders$w_officers_percent,
                             FUN = mean, na.rm=TRUE)

# one variable histogram - # black offenders with levels of % officers white
m <- ggplot(black_offenders, aes(x = w_officers_percent))
m + geom_histogram(aes(y=..density..), binwidth = 1) +
  geom_density(fill = NA, colour="black")
