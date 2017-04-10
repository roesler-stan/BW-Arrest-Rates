dataset$same_day_arrest[dataset$incident_to_arrest_days == 0] <- 1
dataset$same_day_arrest[dataset$incident_to_arrest_days > 0] <- 0

# Create variable that is 0 without arrest
drugs_narcotics_data$same_day_arrest_nona <- drugs_narcotics_data$same_day_arrest
drug_equipment_data$same_day_arrest_nona <- drug_equipment_data$same_day_arrest
drugs_narcotics_data$same_day_arrest_nona[drugs_narcotics_data$arrested==0] <- 0
drug_equipment_data$same_day_arrest_nona[drug_equipment_data$arrested==0] <- 0
# Create variable for other-day arrests, 0 without arrest
drugs_narcotics_data$other_day_arrest_nona[drugs_narcotics_data$arrested==1] <- 1
drugs_narcotics_data$other_day_arrest_nona[drugs_narcotics_data$same_day_arrest==1] <- 0
drugs_narcotics_data$other_day_arrest_nona[drugs_narcotics_data$arrested==0] <- 0
# drug equipment
drug_equipment_data$other_day_arrest_nona[drug_equipment_data$arrested==1] <- 1
drug_equipment_data$other_day_arrest_nona[drug_equipment_data$same_day_arrest==1] <- 0
drug_equipment_data$other_day_arrest_nona[drug_equipment_data$arrested==0] <- 0
