library(ggplot2)

weight <- read.csv("/Users/victoriasugrue/Desktop/sheepweights.csv")

summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
  library(plyr)
  
  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # This does the summary. For each group's data frame, return a vector with
  # N, mean, and sd
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = mean   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  
  # Rename the "mean" column    
  datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}

weightsummary <- summarySE(weight, measurevar="mass", groupvars="sex")
weightsummary

weightsummary2 <- weightsummary
weightsummary2$sex <- factor(weightsummary2$sex)

# Error bars represent standard error of the mean
ggplot(weightsummary2, aes(x=sex, y=mass, fill=sex)) + 
  geom_bar(position=position_dodge(), colour="black", stat="identity") +
  geom_errorbar(aes(ymin=mass-se, ymax=mass+se),
                width=.5,                    # Width of the error bars
                position=position_dodge(.9)) +
  theme_bw() +
  ggtitle("Weights of young rams and wethers") +
  ylab("Mass (kg)") +
  xlab("Castration status") + 
  scale_fill_manual(values=c("#CCCCCC","#FFFFFF")) 




