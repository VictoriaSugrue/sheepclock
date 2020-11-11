####Correlation of CpG with age using WGCNA

library("WGCNA")
options(stringsAsFactors = FALSE)
setwd("/Users/victoriasugrue/Desktop/WGCNA")
data <- read.csv("minfiall.csv")
datExpr = as.data.frame(t(data[, -c(1)]))
ages <- read.csv("agesall.csv")
age <- t(ages[, -c(1)])

ssnt <- standardScreeningNumericTrait(datExpr, age)
write.csv(ssnt, "standardScreeningNumericTraitALL.csv")