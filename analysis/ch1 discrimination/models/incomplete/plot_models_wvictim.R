# Plot average marginal probability
# library(devtools)
# devtools::install_github("sjPlot/devel")
# devtools::install_github("sjPlot/sjmisc")

library(effects)
library(sjPlot)
library(sjmisc)
library(Hmisc)
library(ggplot2)

# after running "indiv_wvictim.R"
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/models")

model <- models_wvictims[[1]][[3]]

label(simple_assault_data$black_not_white) <- "Black (ref = W)"

#  sort.coef = "sort.all",
sjp.glmer(model, facet.grid = T,
          title = "Random Intercepts and Slopes by Agency",
          hideErrorBars = T, axisTitle.y = "Intercept / Slope",
          axisTitle.x = "Agency", showValueLabels = F,
          geom.size = 0.5)