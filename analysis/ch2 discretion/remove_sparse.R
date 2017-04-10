# Remove agencies with < 10 offenses of the given type
library(plyr)

agencies_offenders <- ddply(drugs_narcotics_data, .(ori),
                            summarise, offenders = sum(!is.na(black_not_white)))
bad_agencies <- unique(subset(agencies_offenders, offenders < 10)$ori)
drugs_narcotics_data <- subset(drugs_narcotics_data, ! ori %in% bad_agencies)


agencies_offenders <- ddply(drug_equipment_data, .(ori),
                            summarise, offenders = sum(!is.na(black_not_white)))
bad_agencies <- unique(subset(agencies_offenders, offenders < 10)$ori)
drug_equipment_data <- subset(drug_equipment_data, ! ori %in% bad_agencies)
