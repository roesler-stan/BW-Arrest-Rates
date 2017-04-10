intercepts <- ranef(multilevel_novictims[[1]][[1]])[[1]]
intercepts <- data.frame(intercepts)

head(intercepts)
row.names(intercepts) <- NULL
intercepts <- rename(intercepts, c("X.Intercept."="intercept"))

mean(intercepts$intercept, na.rm=T)
