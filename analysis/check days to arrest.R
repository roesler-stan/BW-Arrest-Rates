sum(simple_assault_data$report_to_arrest_days == 0, na.rm = T)
sum(simple_assault_data$report_to_arrest_days > 0, na.rm = T)
sum(simple_assault_data$incident_to_arrest_days == 0, na.rm = T)
sum(simple_assault_data$incident_to_arrest_days > 0, na.rm = T)



# Days between report and arrest
table(simple_assault_data$report_to_arrest_days)
hist(simple_assault_data$report_to_arrest_days, breaks = 100)

table(weapon_data$report_to_arrest_days)
hist(weapon_data$report_to_arrest_days, breaks = 100)

table(simple_assault_data$report_to_arrest_days)
hist(simple_assault_data$report_to_arrest_days, breaks = 100)

table(drugs_narcotics_data$report_to_arrest_days)
hist(drugs_narcotics_data$report_to_arrest_days, breaks = 100)

table(drug_equipment_data$report_to_arrest_days)
hist(drug_equipment_data$report_to_arrest_days, breaks = 100)



# Days between incident and arrest
table(simple_assault_data$incident_to_arrest_days)
hist(simple_assault_data$incident_to_arrest_days, breaks = 100)

table(drugs_narcotics_data$incident_to_arrest_days)
hist(drugs_narcotics_data$incident_to_arrest_days, breaks = 100)

table(drug_equipment_data$incident_to_arrest_days)
hist(drug_equipment_data$incident_to_arrest_days, breaks = 100)
