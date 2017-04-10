# For 4 violent crimes analyzed, only include offenders who committed the offense
# alone against a single black or white victim whose gender and relationship
# to offender (whether know each other) are non-missing

# This is to ensure that the given offender victimized the given victim

robbery_data_with_victim <- subset(robbery_data, recsofr == 1 & recsvic == 1)
robbery_data_with_victim <- subset(robbery_data_with_victim, victim_analyzing_sex == 'male' | victim_analyzing_sex == 'female')
robbery_data_with_victim <- subset(robbery_data_with_victim, !is.na(victim_analyzing_interracial))
robbery_data_with_victim <- subset(robbery_data_with_victim, !is.na(victim_analyzing_known))
robbery_data_with_victim <- subset(robbery_data_with_victim, !is.na(offense_in_residence1))

aggravated_assault_data_with_victim <- subset(aggravated_assault_data, recsofr == 1 & recsvic == 1)
aggravated_assault_data_with_victim <- subset(aggravated_assault_data_with_victim, victim_analyzing_sex == 'male' | victim_analyzing_sex == 'female')
aggravated_assault_data_with_victim <- subset(aggravated_assault_data_with_victim, !is.na(victim_analyzing_interracial))
aggravated_assault_data_with_victim <- subset(aggravated_assault_data_with_victim, !is.na(victim_analyzing_known))
aggravated_assault_data_with_victim <- subset(aggravated_assault_data_with_victim, !is.na(offense_in_residence1))

simple_assault_data_with_victim <- subset(simple_assault_data, recsofr == 1 & recsvic == 1)
simple_assault_data_with_victim <- subset(simple_assault_data_with_victim, victim_analyzing_sex == 'male' | victim_analyzing_sex == 'female')
simple_assault_data_with_victim <- subset(simple_assault_data_with_victim, !is.na(victim_analyzing_interracial))
simple_assault_data_with_victim <- subset(simple_assault_data_with_victim, !is.na(victim_analyzing_known))
simple_assault_data_with_victim <- subset(simple_assault_data_with_victim, !is.na(offense_in_residence1))

intimidation_data_with_victim <- subset(intimidation_data, recsofr == 1 & recsvic == 1)
intimidation_data_with_victim <- subset(intimidation_data_with_victim, victim_analyzing_sex == 'male' | victim_analyzing_sex == 'female')
intimidation_data_with_victim <- subset(intimidation_data_with_victim, !is.na(victim_analyzing_interracial))
intimidation_data_with_victim <- subset(intimidation_data_with_victim, !is.na(victim_analyzing_known))
intimidation_data_with_victim <- subset(intimidation_data_with_victim, !is.na(offense_in_residence1))

# Subsets with white victims only
simple_assault_data_white_victim <- subset(simple_assault_data_with_victim, victim_analyzing_race == 'white')
aggravated_assault_data_white_victim <- subset(aggravated_assault_data_with_victim, victim_analyzing_race == 'white')
intimidation_data_white_victim <- subset(intimidation_data_with_victim, victim_analyzing_race == 'white')
robbery_data_white_victim <- subset(robbery_data_with_victim, victim_analyzing_race == 'white')
