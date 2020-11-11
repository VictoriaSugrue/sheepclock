library(ggplot2)
library(cowplot)

andro <- read.csv("/Users/victoriasugrue/Desktop/asDMPs.csv") #contains minfi normalised beta values for androgen sensitive DMPs

p1 <- ggplot(andro, aes(x=Age, y=cg21524116, colour=Sex)) + 
  geom_jitter(width=0.2, size=2.5) +
  geom_smooth(method=lm) + 
  ylab("Methylation (%)") + 
  xlab("Chronological Age") + 
  theme_classic() + 
  ggtitle("       MKLN1 (cg21524116)") 

p2 <- ggplot(andro, aes(x=Age, y=cg01822431, colour=Sex)) + 
  geom_jitter(width=0.2, size=2.5) + 
  geom_smooth(method=lm) + 
  ylab("Methylation (%)") + 
  xlab("Chronological Age") + 
  theme_classic() + 
  ggtitle("       ETAA1 (cg01822430)") 

p3 <- ggplot(andro, aes(x=Age, y=cg15851301, colour=Sex)) + 
  geom_jitter(width=0.2, size=2.5) + 
  geom_smooth(method=lm) + 
  ylab("Methylation (%)") + 
  xlab("Chronological Age") + 
  theme_classic() + 
  ggtitle("       LMO4 (cg15851301)") 

p4 <- ggplot(andro, aes(x=Age, y=cg00658920, colour=Sex)) + 
  geom_jitter(width=0.2, size=2.5) + 
  geom_smooth(method=lm) + 
  ylab("Methylation (%)") + 
  xlab("Chronological Age") + 
  theme_classic() + 
  ggtitle("       KIAA2026 (cg00658920)") 

plot_grid(p1, p2, p3, p4, labels = c('A', 'B', 'C', 'D'), label_size = 30, ncol=2)