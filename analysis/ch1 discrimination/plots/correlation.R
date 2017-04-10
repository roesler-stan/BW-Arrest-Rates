library(reshape2)

reorder_cormat <- function(cormat){
  # Use correlation between variables as distance
  dd <- as.dist((1-cormat)/2)
  hc <- hclust(dd)
  cormat <-cormat[hc$order, hc$order]
}

# Get upper triangle of the correlation matrix
get_upper_tri <- function(cormat){
  cormat[lower.tri(cormat)]<- NA
  return(cormat)
}

print_correlation <- function(data, title) {
  # Only keep numeric columns
  cols <- sapply(data, is.numeric)
  data <- data[, cols]

  ivs <- na.omit(data)
  ivs$ori <- NULL
  #rcorr(as.matrix(ivs), type="pearson")
  
  cormat <- round(cor(ivs),2)
  cormat <- reorder_cormat(cormat)
  diag(cormat) <- NA
  upper_tri <- get_upper_tri(cormat)
  melted_cormat <- melt(upper_tri, na.rm = TRUE)
  # Heatmap
  ggplot(data = melted_cormat, aes(Var2, Var1, fill = value))+
    geom_tile(color = "white")+
    scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                         midpoint = 0, limit = c(-1,1), space = "Lab", 
                         name="Pearson\nCorrelation") +
    theme_minimal()+ 
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))+
    coord_fixed() + ggtitle(title)
}