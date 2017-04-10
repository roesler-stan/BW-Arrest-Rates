drugs_narcotics_data <- subset(dataset, offense_drugs_narcotics == 1)
drugs_narcotics_data <- subset(drugs_narcotics_data, arrested == 0 | arrest_drugs_narcotics == 1)

drug_equipment_data <- subset(dataset, offense_drug_equipment == 1)
drug_equipment_data <- subset(drug_equipment_data, arrested == 0 | arrest_drug_equipment == 1)

# Calculate same-day arrest and general arrest rates by agency
drugs_narcotics_byagency <- ddply(drugs_narcotics_data, .(ori), summarise,
                   agency_same_day_arrest = mean(same_day_arrest, na.rm=T) * 100,
                   agency_arrest = mean(arrested, na.rm=T) * 100)
drugs_narcotics_byagency <- na.omit(drugs_narcotics_byagency)
sameday_drugs <- unique(subset(drugs_narcotics_byagency, agency_same_day_arrest >= 90)$ori)

drug_equipment_byagency <- ddply(drug_equipment_data, .(ori), summarise,
                                 agency_same_day_arrest = mean(same_day_arrest, na.rm=T) * 100,
                                 agency_arrest = mean(arrested, na.rm=T) * 100)
drug_equipment_byagency <- na.omit(drug_equipment_byagency)
sameday_drug_equipment <- unique(subset(drug_equipment_byagency, agency_same_day_arrest >= 90)$ori)

drugs_narcotics_data <- merge(drugs_narcotics_data, drugs_narcotics_byagency, by="ori", all.x=T, all.y=F)
drug_equipment_data <- merge(drug_equipment_data, drug_equipment_byagency, by="ori", all.x=T, all.y=F)

# Create subsets with only agencies with more than 90% same-day arrests

drugs_narcotics_data_sameday <- subset(drugs_narcotics_data, ori %in% sameday_drugs)
drug_equipment_data_sameday <- subset(drug_equipment_data, ori %in% sameday_drug_equipment)
