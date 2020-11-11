## this script is for testing the difference in age acceleration between rams and wethers
#grouping variable must have only 2 levels (in this case is Sex)

#for ear male mature using sheep only clock, basedOnAll
sheep <- read.csv("/Users/victoriasugrue/Documents/AgeAccelMaleSheepMature.csv")
wilcox.test(as.numeric(sheep$AgeAccelbasedOnAll)~sheep$Sex, 
            correct=FALSE, exact=FALSE, alternative=c("two.sided"))