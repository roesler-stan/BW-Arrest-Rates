# Ch 1 - See if race matters at the indiv level:
  # ICC for whether offender is arrested or black
  # multilevel logit with varying intercept to correct for agency baselines
  # logit with clustered SE - Huber-White estimater of covariance matrix
  # logit with a dummy for each agency?
    # bad b/c many clusters with few observations, perfectly correlated within clusters
    # also not clear which agency should be the reference group

# Ch 3 - See if race matters more for some agencies than others:
  # logit for each agency -> OLS to predict coefficients
  # logit with clustered SE
  # multilevel logit with interaction
  # multilevel logit with varying coef -> OLS to predict coef
  # Plot varying intercepts and coefficients

