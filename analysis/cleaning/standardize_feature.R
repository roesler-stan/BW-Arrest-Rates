# subtract mean, divide by twice the standard deviation
standardize <- function(col) {
  var_mean <- mean(col, na.rm=T)
  var_sd <- sd(col, na.rm=T)
  return((col - var_mean) / (2 * var_sd))
}