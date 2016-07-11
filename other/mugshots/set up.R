rm(list = ls())

setwd('/Users/katharina/Dropbox/Mugshots\ Project/Code/R Analysis')
mugshots_data <- read.csv('../../Data/SQL Output/mugshots_may1415_male_acs_rpl_naois_clean.csv')
nibrs_data <- read.csv('../../Data/SQL Output/nibrs_arrests_13m_final.csv')

mugshots_disorder <- subset(mugshots_data, mugshots_data$disorder == 1)
mugshots_drunk <- subset(mugshots_data, mugshots_data$drunk_public == 1)
mugshots_burglary <- subset(mugshots_data, mugshots_data$burglary == 1)

nibrs_disorder <- subset(nibrs_data, nibrs_data$ucr_offense == "90C")
nibrs_drunk <- subset(nibrs_data, nibrs_data$ucr_offense == "90E")
nibrs_burglary <- subset(nibrs_data, nibrs_data$ucr_offense == "220")