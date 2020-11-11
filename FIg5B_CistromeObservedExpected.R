library(ggplot2)

obsexpminmaxselect <- read.csv("/Users/victoriasugrue/Dropbox/for_cistrome/obsexpminmaxselect.csv") #contains observed and expected ratios of TF binding 

ggplot(obsexpminmaxselect, aes(x=averagecontrol, y=averageramwether50, colour=ratio)) +
  geom_point(size=5, alpha=0.6) +
  geom_text(data=obsexpminmaxselect, aes(x=averagecontrol, y=averageramwether50, label=factor), 
            vjust=2, size=4) +
  geom_errorbar(aes(xmin=min, xmax=max), width=0.3, colour="gray") +
  geom_abline() +
  theme_classic() +
  ylab("% of Cistrome Output, Ram v Wether Top 50 (log10)") +
  xlab("% of Cistrome Output, Control 50 x 1000 (log10)")