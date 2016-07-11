library("optimx")

relgrad <- with(model0@optinfo$derivs, solve(Hessian, gradient))
max(abs(relgrad))
relgrad <- with(model1@optinfo$derivs, solve(Hessian, gradient))


relgrad <- with(model3@optinfo$derivs, solve(Hessian, gradient))
# Model 3 is okay (0.0001)
relgrad <- with(model6@optinfo$derivs, solve(Hessian, gradient))
# Model 6 is okay (0.0004)

relgrad <- with(model3_theft@optinfo$derivs, solve(Hessian, gradient))
# Theft Model 3 is almost okay (0.0093)
relgrad <- with(model6_theft@optinfo$derivs, solve(Hessian, gradient))
# Theft Model 6 is almost okay (0.0014)

relgrad <- with(model3_other_theft@optinfo$derivs, solve(Hessian, gradient))
# Model 3 is okay (0.0002)
relgrad <- with(model6_other_theft@optinfo$derivs, solve(Hessian, gradient))
# Model 6 is okay (0.0004)

relgrad <- with(model3_shoplifting@optinfo$derivs, solve(Hessian, gradient))
# Shoplifting Model 3 is almost okay (0.0054)
relgrad <- with(model6_shoplifting@optinfo$derivs, solve(Hessian, gradient))
# Shoplifting Model 6 is not okay (0.9393)

relgrad <- with(model3_drugs_general@optinfo$derivs, solve(Hessian, gradient))
# Drugs General Model 3 is not okay (0.0140)
relgrad <- with(model6_drugs_general@optinfo$derivs, solve(Hessian, gradient))
# Drugs General Model 6 is not okay (0.0109)

relgrad <- with(model6_black_offenders@optinfo$derivs, solve(Hessian, gradient))
# Black Offenders Model 6 is okay (0.0000)
relgrad <- with(model6_white_offenders@optinfo$derivs, solve(Hessian, gradient))
# White Offenders Model 6 is okay (0.0000)

max(abs(relgrad))


# Optimx methods: ’Nelder-Mead’, ’BFGS’, ’CG’, ’L-BFGS-B’, ’nlm’, ’nlminb’, ’spg’, ’ucminf’, ’newuoa’, ’bobyqa’, ’nmkb’, ’hjkb’, ’Rcgmin’, or ’Rvmmin’.
model6_theft_nm <- glmer(arrested ~ black_not_white * w_officers_percent_normalized + age_normalized +
                        tech_typ_vpat + male_officers_percent_normalized + bdgt_ttl_normalized + com_bt +
                        hir_trn_no_p + min_hiring_educ_gths +
                        (1 + black_not_white + w_officers_percent_normalized + black_not_white * w_officers_percent_normalized | ori),
                      data = theft_general_data, family = binomial,
                      control = glmerControl(optimizer = "optimx",
                      optCtrl = list(method = "nlminb", starttests = FALSE, kkt = FALSE)))
summary(model6_theft_nm)
