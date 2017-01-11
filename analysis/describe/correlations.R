library(Hmisc)
library(corrplot)
library(plyr)

ivs <- na.omit(dataset[,c("arrested", "black_not_white")])

ori_data <- ddply(dataset, .(ori), summarise,
                  com_bt = mean(com_bt),
                  com_mis = mean(com_mis),
                  com_surv = mean(com_surv),
                  com_nsara = mean(com_nsara),
                  com_col = mean(com_col),
                  com_ptnr = mean(com_ptnr),
                  tech_typ_vpat = mean(tech_typ_vpat),
                  w_officers_percent_standardized = mean(w_officers_percent_standardized),
                  male_officers_percent_standardized = mean(male_officers_percent_standardized),
                  hir_trn_no_p = mean(hir_trn_no_p),
                  min_hiring_educ_gths = mean(min_hiring_educ_gths),
                  ftsworn_standardized = mean(ftsworn_standardized),
                  bdgt_ttl_standardized = mean(bdgt_ttl_standardized))
                  
ivs <- na.omit(ori_data[,c("com_bt","com_mis", "com_surv", "com_nsara", "com_col", "com_ptnr")])

M <- cor(ivs)

# Other types of correlation plots
corrplot.mixed(M)

corrplot(M, method = 'color')

rcorr(as.matrix(ivs), type="pearson")