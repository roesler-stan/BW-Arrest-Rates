rm(list = ls())

load("/Users/katharina/Dropbox/Projects/Mugshots Project/Data/ncvs/incident/35164-0004-Data.rda")
#load("../../Data/ncvs/incident/35164-0004-Data.rda")

df <- da35164.0004
da35164.0004 <- NULL


head(df)
names(df)

# 7727 people in 2013 - why so small?
# Does each row represent a different quarter for the same household?
table(df$YEARQ)
# Type of offense
table(df$V4528)


pocket_picking <- subset(df, V4528 == "(23) Pocket picking")
table(pocket_picking$V4246B)


# Single offender race
table(df$V4246B) # white: 1018
table(df$V4246C) # black: 426
table(df$V4246G) # don't know race: 192
# 426 black offenders, 1018 white offenders

# Multiple offenders race
table(df$V4280) # white: 203
table(df$V4281) # black: 138
table(df$V4283) # don't know race: 48

# Multiple offenders race of most
table(df$V4285A) # 6 black, 8 white, 2 don't know, 24 residue


# Reported to police
table(df$V4399) # 2935 reported, 4725 not reported
# Only 38% of crimes with victims are reported to the police!
