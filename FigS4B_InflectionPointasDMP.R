library(ggplot2)

asDMPs <- read.csv("/Users/victoriasugrue/Desktop/asDMPlist.csv")

first <- asDMPs[1:1000,]
second <- asDMPs[4000:4694,1:8]

p1 <- ggplot(first, aes(x=Rank, y=pvalue)) + 
  geom_point(size=2.5, shape=1, stroke=1) + 
  ylab("P-Value (log10)") + 
  xlab ("Rank")
p1.breaks <- p1 + 
  scale_y_continuous(trans = "log", breaks = c(1E-30, 1E-25, 1E-20, 1E-15, 1E-10, 1E-05, 0), limits=c(0.000000000000000000000000000001, 0.1))
p1.breaks.annotate <- p1.breaks + 
  annotate("rect", xmin=0, xmax=50, ymin=0, ymax= 0.1, 
                                           fill=NA, colour="red")
p1f <- p1.breaks.annotate + 
  theme_classic()                                  
p1f                              

p2 <- ggplot(second, aes(x=Rank, y=pvalue)) + 
  geom_point(size=2.5, shape=1, stroke=1) + 
  ylab("P-Value (log10)") + 
  xlab ("Rank") + 
  xlim(4000,5000)   
p2.breaks <- p2 + 
  scale_y_continuous(breaks = c(1E-30, 1E-25, 1E-20, 1E-15, 1E-10, 1E-05, 0), limits=c(0.000000000000000000000000000001, 0.1), trans = "log")

p2f <- p2.breaks + 
  theme_classic()                               
p2f     

plot_grid(p1f, p2f, labels=NULL, ncol=2)
