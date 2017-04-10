library(plyr)

# Fix an issue with wofficers_divres and bofficers_divres
dataset$wofficers_divres <- dataset$w_officers_percent / dataset$w_residents_percent
dataset$bofficers_divres <- dataset$b_officers_percent / dataset$b_residents_percent

# Calculate % of officers regularly assigned the same beat
dataset$com_bt_percent <- (dataset$com_nbt / dataset$ftsworn) * 100
# % engaged in SARA-type CP
dataset$com_nsara_percent <- (dataset$com_nsara / dataset$ftsworn) * 100

# Log vars for skewed distributions
dataset$agency_arrestees_count_natlog <- log(dataset$agency_arrestees_count + 0.0001)
dataset$agency_offenders_count_log <- log(dataset$agency_offenders_count)
dataset$ftsworn_log <- log(dataset$ftsworn)
dataset$ptsworn_log <- log(dataset$ptsworn + 0.0001)

# Calculate county-level variables
ori_data <- ddply(dataset, .(ori), summarise,
                  total_residents = mean(total_residents, na.rm = T),
                  b_residents = mean(b_residents, na.rm = T),
                  w_residents = mean(w_residents, na.rm = T),
                  ftsworn = mean(ftsworn, na.rm = T),
                  fips_county1_no = unique(fips_county1_no),
                  offenders = sum(!is.na(arrested)))

county_data <- ddply(ori_data, .(fips_county1_no), summarise,
                     total_residents = mean(total_residents, na.rm = T),
                     b_residents = mean(b_residents, na.rm = T),
                     w_residents = mean(w_residents, na.rm = T),
                     ftsworn = sum(ftsworn, na.rm = T),
                  offenders = sum(offenders))

county_data$county_ftsworn_per_resident <- (county_data$ftsworn / county_data$total_residents) / 1000
county_data$county_ftsworn_per_black_resident <- (county_data$ftsworn / county_data$b_residents) / 1000
county_data$county_ftsworn_per_white_resident <- (county_data$ftsworn / county_data$w_residents) / 1000

cols <- c("fips_county1_no", "county_ftsworn_per_resident",
          "county_ftsworn_per_black_resident", "county_ftsworn_per_white_resident")
dataset <- merge(dataset, county_data[, cols], by = "fips_county1_no", all.x = T, all.y = F)
county_data <- NULL


# Create agency-level variable
dataset$agency_ftsworn_per_offender <- dataset$ftsworn / dataset$agency_offenders_count
dataset$agency_arrest_rate <- dataset$agency_arrestees_count / dataset$agency_offenders_count
