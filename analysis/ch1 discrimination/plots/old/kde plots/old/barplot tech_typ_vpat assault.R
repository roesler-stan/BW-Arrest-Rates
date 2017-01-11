arrested_byrace <- aggregate(small_data_assault_general$arrested,
                             by = list(factor(small_data_assault_general$black_not_white),
                                       factor(small_data_assault_general$tech_typ_vpat)),
                             FUN = mean, na.rm = T)

ggplot(data = arrested_byrace, aes(x = Group.2, y=x, fill=Group.1)) + 
  geom_bar(stat = "identity", position = position_dodge()) + 
  ylab("% Arrested") + xlab("Body Cameras") +
  ggtitle("% Assault Offenders Arrested by Race and Body Cameras") + theme_bw() +
  scale_fill_manual("Offender Race", values = c("gray", "pink"),
                    labels = c("White", "Black"))
