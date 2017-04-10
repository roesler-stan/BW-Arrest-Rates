# do this before dropping rows
table(dataset$race, dataset$sex)

table(dataset$black_not_white)

# first var is the rows
prop.table(table(dataset$black_not_white, dataset$arrested), 1)
# 47.7 % of black offenders arrested, 52.3% not arrested

mean(dataset$age, na.rm=T)
