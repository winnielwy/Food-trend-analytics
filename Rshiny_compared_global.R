load("data.RData")

regress <- function(ym, xm, dataDF){
  print("in regress")
  print("ym=")
  print(ym)
  print("xm=")
  print(xm)
  fit <- lm(ym~xm, dataDF)
  print("fit=")
  print(fit)
  return(fit)
}

#input parameters
c1 <- "avgprice"
c2 <- "sentiment"
c3 <- "avgprice"
c4 <- "HipInc" 

myDataCity <- subset(food)
myDataFood <- subset(food)
