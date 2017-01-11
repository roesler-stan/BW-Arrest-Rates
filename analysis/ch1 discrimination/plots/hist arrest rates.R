## Offenders by Agency Arrest Rate

library(scales)
setwd("~/Dropbox/Projects/Mugshots Project/Code/analysis/ch1 discrimination/plots")
# Calculate offender counts and arrest rates
source("calculate_offender_counts.R")
setwd("~/Dropbox/Projects/Mugshots Project/Output/ch1 discrimination/plots")

ALPHA <- 0.8
ggplot(dataset, aes(x=agency_percent_offenders_arrested)) +
  geom_histogram(data=white_offenders, aes(fill="blue", alpha=ALPHA), binwidth=3) +
  geom_histogram(data=black_offenders, aes(fill="violet", alpha=ALPHA), binwidth=3) +
  xlab("% All Offenders Arrested") + ylab("Offenders") + theme_classic() +
  scale_y_continuous(labels=comma) + guides(alpha=F) +
  scale_fill_manual("Offender Race", labels=c("White", "Black"),
                    values=alpha(c("blue", "violet"), ALPHA/2)) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        plot.title = element_text(hjust = 0.5), text = element_text(family="serif"),
        legend.background = element_rect(colour = "gray")) +
  ggtitle("Distribution of Offenders by Agency Arrest Rate")
ggsave('hist_agency_arrested.png', dpi = 400)


# Cumulative histogram
ggplot(dataset, aes(x=agency_percent_offenders_arrested, y=cumsum(..count..))) +
  geom_histogram(data=white_offenders, aes(fill="blue", alpha=ALPHA), binwidth=3) +
  geom_histogram(data=black_offenders, aes(fill="violet", alpha=ALPHA), binwidth=3) +
  xlab("% All Offenders Arrested") + ylab("Cumulative Offenders") + theme_classic() +
  scale_y_continuous(labels=comma) + guides(alpha=F) +
  scale_fill_manual("Offender Race", labels=c("White", "Black"),
                    values=alpha(c("blue", "violet"), ALPHA/2)) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        plot.title = element_text(hjust = 0.5), text = element_text(family="serif"),
        legend.background = element_rect(colour = "gray")) +
  ggtitle("Cumulative Distribution of Offenders by Agency Arrest Rate")
ggsave('cumhist_agency_arrested.png', dpi = 400)


# By agencies' black offenders arrest rate
ggplot(dataset, aes(x=agency_percent_b_offenders_arrested, y=cumsum(..count..))) +
  geom_histogram(data=white_offenders, aes(fill="blue", alpha=ALPHA), binwidth=3) +
  geom_histogram(data=black_offenders, aes(fill="violet", alpha=ALPHA), binwidth=3) +
  xlab("% Black Offenders Arrested") + ylab("Cumulative Offenders") + theme_classic() +
  scale_y_continuous(labels=comma) + guides(alpha=F) +
  scale_fill_manual("Offender Race", labels=c("White", "Black"),
                    values=alpha(c("blue", "violet"), ALPHA/2)) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        plot.title = element_text(hjust = 0.5), text = element_text(family="serif"),
        legend.background = element_rect(colour = "gray")) +
  ggtitle("Cumulative Distribution of Offenders by Agency Black Arrest Rate")
ggsave('cumhist_agency_b_arrested.png', dpi = 400)


# By agencies' white offenders arrest rate
ggplot(dataset, aes(x=agency_percent_w_offenders_arrested, y=cumsum(..count..))) +
  geom_histogram(data=white_offenders, aes(fill="blue", alpha=ALPHA), binwidth=3) +
  geom_histogram(data=black_offenders, aes(fill="violet", alpha=ALPHA), binwidth=3) +
  xlab("% White Offenders Arrested") + ylab("Cumulative Offenders") + theme_classic() +
  scale_y_continuous(labels=comma) + guides(alpha=F) +
  scale_fill_manual("Offender Race", labels=c("White", "Black"),
                    values=alpha(c("blue", "violet"), ALPHA/2)) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        plot.title = element_text(hjust = 0.5), text = element_text(family="serif"),
        legend.background = element_rect(colour = "gray")) +
  ggtitle("Cumulative Distribution of Offenders by Agency White Arrest Rate")
ggsave('cumhist_agency_w_arrested.png', dpi = 400)

