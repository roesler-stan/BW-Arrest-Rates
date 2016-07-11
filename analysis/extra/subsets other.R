burglary_data <- subset(dataset, dataset$offense_burglary == 1)
burglary_data <- subset(burglary_data, burglary_data$arrested == 0 | burglary_data$arrest_burglary == 1)

auto_parts_theft_data <- subset(dataset, dataset$offense_auto_parts_theft == 1)
auto_parts_theft_data <- subset(auto_parts_theft_data, auto_parts_theft_data$arrested == 0 | auto_parts_theft_data$arrest_auto_parts_theft == 1)

theft_from_machine_data <- subset(dataset, dataset$offense_theft_from_machine == 1)
theft_from_machine_data <- subset(theft_from_machine_data, theft_from_machine_data$arrested == 0 | theft_from_machine_data$arrest_theft_from_machine == 1)

purse_snatching_data <- subset(dataset, dataset$offense_purse_snatching == 1)
purse_snatching_data <- subset(purse_snatching_data, purse_snatching_data$arrested == 0 | purse_snatching_data$arrest_purse_snatching == 1)

fraud_data <- subset(dataset, dataset$offense_fraud_general == 1)
fraud_data <- subset(fraud_data, fraud_data$arrested == 0 | fraud_data$arrest_fraud_general == 1)

embez_data <- subset(dataset, dataset$offense_embezzlement == 1)
embez_data <- subset(fraud_data, embez_data$arrested == 0 | embez_data$arrest_embezzlement == 1)

pocket_picking_data <- subset(dataset, dataset$offense_pocket_picking == 1)
pocket_picking_data <- subset(pocket_picking_data, pocket_picking_data$arrested == 0 | pocket_picking_data$arrest_pocket_picking == 1)

stolen_property_data <- subset(dataset, dataset$offense_stolen_property == 1)
stolen_property_data <- subset(stolen_property_data, stolen_property_data$arrested == 0 | stolen_property_data$arrest_stolen_property == 1)

other_theft_data <- subset(dataset, dataset$offense_other_theft == 1)
other_theft_data <- subset(other_theft_data, other_theft_data$arrested == 0 | other_theft_data$arrest_other_theft == 1)

building_theft_data <- subset(dataset, dataset$offense_building_theft == 1)
building_theft_data <- subset(building_theft_data, building_theft_data$arrested == 0 | building_theft_data$arrest_building_theft == 1)

weapon_data <- subset(dataset, dataset$offense_weapon == 1)
weapon_data <- subset(weapon_data, weapon_data$arrested == 0 | weapon_data$arrest_weapon == 1)

auto_theft_data <- subset(dataset, dataset$offense_auto_theft == 1)
auto_theft_data <- subset(auto_theft_data, auto_theft_data$arrested == 0 | auto_theft_data$arrest_auto_theft == 1)

theft_from_auto_data <- subset(dataset, dataset$offense_theft_from_auto == 1)
theft_from_auto_data <- subset(theft_from_auto_data, theft_from_auto_data$arrested == 0 | theft_from_auto_data$arrest_theft_from_auto == 1)

forcible_rape_data <- subset(dataset, dataset$offense_forcible_rape == 1)
forcible_rape_data <- subset(forcible_rape_data, forcible_rape_data$arrested == 0 | forcible_rape_data$arrest_forcible_rape == 1)