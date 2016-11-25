# These are important variables.  If any row is missing on any of theses, remove that row.

varlist <- c("ori", "fips_county1_no", "w_officers_percent", "b_officers_percent",
             "arrested", "black_not_white", "sex")
#"bdgt_ttl", "com_bt", "tech_typ_vpat", "hir_trn_no_p", "min_hiring_educ_gths", "b_residents_percent"

for (var in varlist) {
  dataset <- subset(dataset, !is.na(dataset[var]))
}

dataset <- subset(dataset, dataset$sex == 'male' | dataset$sex == 'female')  
