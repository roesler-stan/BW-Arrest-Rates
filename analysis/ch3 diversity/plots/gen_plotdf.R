gen_plot <- function(subset) {
  agency_data <- ddply(subset, .(ori), summarise,
                       w_officers_percent = mean(w_officers_percent, na.rm=T))
  
  plot_data <- ddply(subset, .(ori, black_not_white), summarise,
                     arrested=mean(arrested, na.rm=T) * 100,
                     offenders=sum(!is.na(black_not_white)))
  
  plot_data <- merge(plot_data, agency_data, by="ori", all.x=T, all.Y=F)
  plot_data <- na.omit(plot_data)
  return(plot_data)
}