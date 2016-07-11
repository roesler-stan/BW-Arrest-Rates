black_offenders <- subset(dataset, black_not_white == 1)
white_offenders <- subset(dataset, black_not_white == 0)

simple_assault_data <- subset(dataset, offense_simple_assault == 1)
simple_assault_data <- subset(simple_assault_data, arrested == 0 | arrest_simple_assault == 1)

aggravated_assault_data <- subset(dataset, offense_aggravated_assault == 1)
aggravated_assault_data <- subset(aggravated_assault_data, arrested == 0 | arrest_aggravated_assault == 1)

intimidation_data <- subset(dataset, offense_intimidation == 1)
intimidation_data <- subset(intimidation_data, arrested == 0 | arrest_intimidation == 1)

robbery_data <- subset(dataset, offense_robbery == 1)
robbery_data <- subset(robbery_data, arrested == 0 | arrest_robbery == 1)

shoplifting_data <- subset(dataset, offense_shoplifting == 1)
shoplifting_data <- subset(shoplifting_data, arrested == 0 | arrest_shoplifting == 1)

vandalism_data <- subset(dataset, offense_vandalism == 1)
vandalism_data <- subset(vandalism_data, arrested == 0 | arrest_vandalism == 1)

drugs_narcotics_data <- subset(dataset, offense_drugs_narcotics == 1)
drugs_narcotics_data <- subset(drugs_narcotics_data, arrested == 0 | arrest_drugs_narcotics == 1)

drug_equipment_data <- subset(dataset, offense_drug_equipment == 1)
drug_equipment_data <- subset(drug_equipment_data, arrested == 0 | arrest_drug_equipment == 1)

weapon_data <- subset(dataset, offense_weapon == 1)
weapon_data <- subset(weapon_data, arrested == 0 | arrest_weapon == 1)