library(ggplot2)

setwd("~/Dropbox/Mugshots Project/Public/Output/plots")

#method = "lm", "loess"
ggplot(simple_assault_data, aes(x = w_officers_percent, y = arrested, color = factor(black_not_white))) +
  geom_point(alpha = 4/10, position = position_jitter(height = 0.1)) + 
  stat_smooth() +
  xlab("% Officers White") + ylab("Arrested") +
  xlim(30, 100) + theme_bw() + ggtitle("Simple Assault Offenders Arrested") +
  scale_colour_hue("Offender Race", labels = c("White", "Black")) + ylim(-0.4, 1.4)
ggsave("simple_assault_wofficers_arrested.png", dpi = 600, width = 12, height = 10)



# Separately by race
ggplot(black_offenders, aes(x = w_officers_percent, y = arrested)) +
  geom_point(alpha = 1/20, position = position_jitter(height = 0.3)) + 
  stat_smooth() + xlab("% Officers White") + ylab("Arrested") +
  xlim(30, 100) + theme_bw() + ggtitle("Black Offenders") + ylim(-0.4, 1.4)
ggsave("wofficers_black_arrested.png", dpi = 600, width = 12, height = 10)


ggplot(white_offenders, aes(x = w_officers_percent, y = arrested)) +
  geom_point(alpha = 1/20, position = position_jitter(height = 0.3)) + 
  stat_smooth() + xlab("% Officers White") + ylab("Arrested") +
  xlim(30, 100) + theme_bw() + ggtitle("White Offenders") + ylim(-0.4, 1.4)
ggsave("wofficers_white_arrested.png", dpi = 600, width = 12, height = 10)