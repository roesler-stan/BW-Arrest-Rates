# Remove agencies with < 10 offenses of the given type
library(plyr)

agencies_offenders <- ddply(dataset, .(ori),
                            summarise, offenders = sum(!is.na(black_not_white)))
bad_agencies <- unique(subset(agencies_offenders, offenders < 10)$ori)
dataset <- subset(dataset, ! ori %in% bad_agencies)

agencies_offenders <- ddply(simple_assault_data, .(ori),
                            summarise, offenders = sum(!is.na(black_not_white)))
bad_agencies <- unique(subset(agencies_offenders, offenders < 10)$ori)
simple_assault_data <- subset(simple_assault_data, ! ori %in% bad_agencies)

agencies_offenders <- ddply(aggravated_assault_data, .(ori),
                            summarise, offenders = sum(!is.na(black_not_white)))
bad_agencies <- unique(subset(agencies_offenders, offenders < 10)$ori)
aggravated_assault_data <- subset(aggravated_assault_data, ! ori %in% bad_agencies)

agencies_offenders <- ddply(intimidation_data, .(ori),
                            summarise, offenders = sum(!is.na(black_not_white)))
bad_agencies <- unique(subset(agencies_offenders, offenders < 10)$ori)
intimidation_data <- subset(intimidation_data, ! ori %in% bad_agencies)

agencies_offenders <- ddply(robbery_data, .(ori),
                            summarise, offenders = sum(!is.na(black_not_white)))
bad_agencies <- unique(subset(agencies_offenders, offenders < 10)$ori)
robbery_data <- subset(robbery_data, ! ori %in% bad_agencies)

agencies_offenders <- ddply(shoplifting_data, .(ori),
                            summarise, offenders = sum(!is.na(black_not_white)))
bad_agencies <- unique(subset(agencies_offenders, offenders < 10)$ori)
shoplifting_data <- subset(shoplifting_data, ! ori %in% bad_agencies)

agencies_offenders <- ddply(vandalism_data, .(ori),
                            summarise, offenders = sum(!is.na(black_not_white)))
bad_agencies <- unique(subset(agencies_offenders, offenders < 10)$ori)
vandalism_data <- subset(vandalism_data, ! ori %in% bad_agencies)

agencies_offenders <- ddply(drugs_narcotics_data, .(ori),
                            summarise, offenders = sum(!is.na(black_not_white)))
bad_agencies <- unique(subset(agencies_offenders, offenders < 10)$ori)
drugs_narcotics_data <- subset(drugs_narcotics_data, ! ori %in% bad_agencies)

agencies_offenders <- ddply(drug_equipment_data, .(ori),
                            summarise, offenders = sum(!is.na(black_not_white)))
bad_agencies <- unique(subset(agencies_offenders, offenders < 10)$ori)
drug_equipment_data <- subset(drug_equipment_data, ! ori %in% bad_agencies)

# Weapon offenses
agencies_offenders <- ddply(weapon_data, .(ori),
                            summarise, offenders = sum(!is.na(black_not_white)))
bad_agencies <- unique(subset(agencies_offenders, offenders < 10)$ori)
weapon_data <- subset(weapon_data, ! ori %in% bad_agencies)
