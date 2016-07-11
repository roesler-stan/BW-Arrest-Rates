libary(sjplot)

# random intercepts
sjp.glmer(model1, type = "re")

sjp.int(model1, type = "cond")
sjp.int(model1, type = "eff", showCI = TRUE)
sjp.int(model1, type = "eff", facet.grid = T, showCI = TRUE)

model1, facet.grid = T,
title = "Random Intercepts and Slopes by Agency",
hideErrorBars = T, axisTitle.y = "Intercept / Slope",
axisTitle.x = "Agency", showValueLabels = F,
geom.size = 0.5)