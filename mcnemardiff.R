# Author: Timothy Dobbins
# Date: 11 July 2022
# Purpose: Function to present the proportions, difference in proportions and 95% confidence interval
#          of the difference in two paired proportions

# NOTE: variable names must be surrounded by quotation marks, see example usage below

mcNemarDiff <- function(data, var1, var2, digits = 3) {
  if (!requireNamespace("epibasix", quietly = TRUE)) {
    stop("This function requires epibasix to be installed")
  }
  
  tab <- table(data[[var1]], data[[var2]])
  p1 <- (tab[1, 1] + tab[1, 2]) / sum(tab)
  p2 <- (tab[1, 1] + tab[2, 1]) / sum(tab)
  pd <- epibasix::mcNemar(tab)$rd
  pd.cil <- epibasix::mcNemar(tab)$rd.CIL
  pd.ciu <- epibasix::mcNemar(tab)$rd.CIU
  print(paste0(
    "Proportion 1: ",
    format(round(p1, digits = digits), nsmall = digits),
    "; Proportion 2: ", format(round(p2, digits = digits), nsmall = digits)
  ))
  print(paste0(
    "Difference in paired proportions: ",
    format(round(pd, digits = digits), nsmall = digits),
    "; 95% CI: ", format(round(pd.cil, digits = digits), nsmall = digits),
    " to ", format(round(pd.ciu, digits = digits), nsmall = digits)
  ))
}


# Example usage
# 
# drug <- readRDS("data/examples/Example_7.3.rds")
# 
# drug$druga <- relevel(drug$druga, ref="Yes")
# drug$drugb <- relevel(drug$drugb, ref="Yes")
# 
# mcNemarDiff(data = drug, var1 = "druga", var2 = "drugb")
