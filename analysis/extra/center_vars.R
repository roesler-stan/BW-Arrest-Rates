# Center continuous IVs around their means
continuous_ivs <- c("w_officers_percent", "male_officers_percent", "age", "bdgt_ttl")

for (iv in continuous_ivs) {
  iv_centered = paste(iv,"centered", sep = "_")
  iv_mean <- mean(dataset[,iv], rm.na = T)
  dataset[,iv_centered] <- dataset[,iv] - iv_mean
}