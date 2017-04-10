# Count how many people have at least one of the 9 offenses:
# 956434 offenders (73.6%), 454462 arrestees (72.1%)

offenses <- c("robbery", "aggravated_assault", "simple_assault", "intimidation", "weapon",
              "shoplifting", "vandalism",  "drugs_narcotics", "drug_equipment")
offenders <- paste0("offense_", offenses)
arrestees <- paste0("arrest_", offenses)

dataset$offender_in_nine <- 0
for (offender in offenders) {
  print(offender)
  dataset$offender_in_nine[dataset[, offender] == 1] <- 1  
}

dataset$arrestee_in_nine <- 0
dataset$arrestee_in_nine[dataset$arrested == 0] <- NA
for (arrestee in arrestees) {
  dataset$arrestee_in_nine[dataset[, arrestee] == 1] <- 1  
}

table(dataset$offender_in_nine)
prop.table(table(dataset$offender_in_nine))
table(dataset$arrestee_in_nine)
prop.table(table(dataset$arrestee_in_nine))
