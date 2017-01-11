# Count how many people have at least one of the 8 offenses

offenses <- c("robbery", "aggravated_assault", "simple_assault", "intimidation", "weapon",
              "shoplifting", "vandalism",  "drugs_narcotics", "drug_equipment")
offenders <- paste0("offense_", offenses)
arrestees <- paste0("arrest_", offenses)

dataset$offender_in_eight <- 0
for (offender in offenders) {
  print(offender)
  dataset$offender_in_eight[dataset[, offender] == 1] <- 1  
}

dataset$arrestee_in_eight <- 0
dataset$arrestee_in_eight[dataset$arrested == 0] <- NA
for (arrestee in arrestees) {
  dataset$arrestee_in_eight[dataset[, arrestee] == 1] <- 1  
}

table(dataset$offender_in_eight)
prop.table(table(dataset$offender_in_eight))
table(dataset$arrestee_in_eight)
prop.table(table(dataset$arrestee_in_eight))
