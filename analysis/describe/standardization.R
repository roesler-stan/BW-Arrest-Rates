# Check whether standardizing within a subset is different from standardizing and then taking a subset
# E.g. does the distribution of % officers white look different?

simple_assault_data_new <- simple_assault_data

# Center continuous IVs around their means
continuous_ivs <- c("w_officers_percent", "b_officers_percent", "male_officers_percent",
                    "age", "bdgt_ttl", "ftsworn",
                    "wofficers_divres", "bdgt_per_ftoff",
                    "agency_offenders_count", "agency_bdgt_per_offender", "agency_bdgt_per_arrestee",
                    "b_residents_percent", "w_residents_percent", "mean_inc",
                    "b_unemp", "w_unemp", "one_race_unemp",
                    "zipcode_bdgt", "zipcode_bdgt_per_resident",
                    "zipcode_offenders_count", "zipcode_offenders_per_resident", "zipcode_arrestees_per_resident")

# subtract mean, divide by twice the standard deviation
for (iv in continuous_ivs) {
  iv_standardized = paste(iv,"standardized", sep = "_")
  iv_mean <- mean(simple_assault_data[,iv], na.rm = TRUE)
  iv_sd <- sd(simple_assault_data[,iv], na.rm = TRUE)
  simple_assault_data_new[,iv_standardized] <- (simple_assault_data[,iv] - iv_mean) / (2 * iv_sd)
}

mean(simple_assault_data$w_officers_percent_standardized)
mean(simple_assault_data_new$w_officers_percent_standardized)

sd(simple_assault_data$w_officers_percent_standardized)
sd(simple_assault_data_new$w_officers_percent_standardized)

hist(simple_assault_data$w_officers_percent_standardized)
hist(simple_assault_data_new$w_officers_percent_standardized)
