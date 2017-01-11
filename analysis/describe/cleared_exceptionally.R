## Examine exceptional clearances

grep("except", names(dataset), value = TRUE)
table(dataset$cleared_exceptionally)

# Most exceptional clearances are recorded as non-arrested
table(dataset$arrested, dataset$cleared_exceptionally)

# -6 = N/A
# 1 = death
# 2 = declined prosecution
# 3 = in custody of other jurisdiction
# 4 = victim refused to cooperate
# 5 = juvenile / no custody

dataset$declined_prosecution <- 0
dataset$declined_prosecution[dataset$cleared_exceptionally == 2] <- 1

dataset$victim_refused <- 0
dataset$victim_refused[dataset$cleared_exceptionally == 4] <- 1


# 3.1% of white offenders are declined prosecution
# 2.8% of black offenders are declined prosecution
prop.table(table(dataset$black_not_white, dataset$declined_prosecution), 1)

# 3.3% of white offenders have a victim refuse to cooperate
# 3.2% of black offenders have a victim refuse to cooperate
prop.table(table(dataset$black_not_white, dataset$victim_refused), 1)
