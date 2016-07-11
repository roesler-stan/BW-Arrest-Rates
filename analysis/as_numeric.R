### Convert variables that are incorrectly coded as factors to numeric

dataset$b_unemp[dataset$b_unemp == "-"] <- NaN

vars <- c('b_unemp', 'w_unemp', 'one_race_unemp')

for (iv in vars) {
  dataset[,iv] <- as.numeric(as.character(dataset[,iv]))
}
