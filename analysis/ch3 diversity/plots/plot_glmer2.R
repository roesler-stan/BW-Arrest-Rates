# Plot average marginal probability
library(effects)
library(sjPlot)
library(sjmisc)
library(Hmisc)
library(ggplot2)

label(simple_assault_data$black_not_white) <- "Black (ref = W)"

#  sort.coef = "sort.all",
sjp.glmer(m2_simple_assault, facet.grid = T,
          title = "Random Intercepts and Slopes by Agency",
          hideErrorBars = T, axisTitle.y = "Intercept / Slope",
          axisTitle.x = "Agency", showValueLabels = F,
          geom.size = 0.5)

# Bug here, may need to reinstall ggplot2
save_plot("m2_simple_assault_random.png", fig = ggplot2::last_plot(), width = 12, height = 10,
          dpi = 600, theme = "theme_bw", axis.textsize = 0)



eff <- effect("black_not_white * w_officers_percent_standardized", m3_simple_assault,
              xlevels = list(w_officers_percent_standardized = -5:2, black_not_white = c(0, 1)))

eff_df <- data.frame(eff)

ggplot(eff_df) + geom_line(aes(w_officers_percent_standardized, fit, linetype = factor(black_not_white))) +
  theme_bw() + xlab("Percent Officers White (Standardized)") + ylab("Predicted Probability of Arrest") +
  scale_linetype_discrete("Offender Race", labels = c("White", "Black")) +
  ggtitle("Simple Assault Offenders' Predicted Probability of Arrest\nby % Officers White")


plot(eff, multiline = T, main= "Interaction of Officers' and Offenders' Race")
