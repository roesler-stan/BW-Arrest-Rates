# Center continuous IVs around their means
continuous_ivs <- c("w_officers_percent", "b_officers_percent", "male_officers_percent",
                    "age", "bdgt_ttl", "ftsworn",
                    "wofficers_divres", "bdgt_per_ftoff",
                    "agency_offenders_count", "agency_bdgt_per_offender",
                    "agency_bdgt_per_arrestee",
                    "b_residents_percent", "w_residents_percent", "mean_inc",
                    "b_unemp", "w_unemp", "one_race_unemp",
                    "county_bdgt", "county_bdgt_per_resident",
                    "county_offenders_count", "county_offenders_per_resident",
                    "county_arrestees_per_resident")

# subtract mean, divide by twice the standard deviation
for (iv in continuous_ivs) {
  iv_standardized = paste(iv, "standardized", sep = "_")
  iv_mean <- mean(dataset[, iv], na.rm = T)
  dataset[, iv_standardized] <- dataset[, iv] - iv_mean
  
  iv_sd <- sd(dataset[,iv], na.rm = T)
  dataset[, iv_standardized] <- dataset[, iv_standardized] / (2 * iv_sd)
}

dataset$w_officers_percent_standardized_sq <- dataset$w_officers_percent_standardized ** 2
dataset$b_officers_percent_standardized_sq <- dataset$b_officers_percent_standardized ** 2