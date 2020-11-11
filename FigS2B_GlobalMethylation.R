library(ggplot2)

global <- read.csv("/Users/victoriasugrue/Desktop/globalmethaverage.csv") #contains file of average global methylation across all probes in each individual sample

ggplot(global, aes(x=Age, y=average, colour=Sex)) +
  geom_jitter(width=0.1, size=4, alpha=1/1.1) + 
  geom_smooth(method=lm, se=FALSE, size=1) + 
  theme_classic() + 
  ggtitle("Global methylation") + 
  ylab("Average methylation (%)") +
  xlab("Age (years)")