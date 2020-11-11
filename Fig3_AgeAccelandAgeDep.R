library(ggnewscale)
library(ggplot2)
library(cowplot)

agedepRAM <- read.csv("/Users/victoriasugrue/Desktop/agedepram.csv") #intact males ranked by age acceleration 
agedepWETHER <- read.csv("/Users/victoriasugrue/Desktop/agedepwether.csv") #castrated males ranked by age acceleration

p1 <- ggplot() + 
  geom_point(data=agedepRAM, aes(x=Rank, y=DNAmAgeLOO, colour=Age), size=5, alpha=1/1.1) + 
  scale_colour_gradient(low="forestgreen", high="yellow", name="Chronological age /n Intact male") + 
  new_scale_color() + 
  geom_point(data=agedepWETHER, aes(x=Rank, y=DNAmAgeLOO, colour=Age), size=5, alpha=1/1.1) + 
  scale_colour_gradient(low="royalblue", high="violet", name="Chronological age /n Castrated male") + 
  theme_classic() + 
  xlab("Rank") +
  ylab("DNAmAge (Years)")

d <- read.csv("/Users/victoriasugrue/Desktop/maturesheepearminfi.csv") #this file contains minfi normalized beta values for ear samples from mature sheep
d2 <- read.csv("/Users/victoriasugrue/Desktop/maturesheepearminfid2.csv") #this file contains means + sd for age acceleration, ear samples from mature sheep

p2 <- ggplot(d2, aes(x=Group, y=mean)) + 
  geom_bar(stat = "identity", fill="lightgrey", colour="black") + 
  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd), width=0.5) + 
  geom_jitter(d, mapping = aes(x=Sex, y=AgeAccelbasedOnAll, colour=Sex), width=0.1, size=4, alpha=1/2) +
  ylab("Age Acceleration (Years)") + theme_classic() + geom_hline(yintercept=0) + 
  theme_classic()

plot_grid(p1, p2, labels = c('A', 'B'), label_size = 30)