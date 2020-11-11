library(ggplot2)
library("cowplot")
setwd("/Users/victoriasugrue/Dropbox/N18.2018-9300-1SheepSkinBloodTimHoreRussellSnell/Subset_Sheep_PredictionResultsJosephZoller/")

#figure A: sheep pan tissue, sheep clock
sheepA <- read.csv("datPredictedAgeN18FinalJosephZoller.csv")

#figure B: sheep blood
sheepB <- read.csv("datPredictedAgeN18FinalJosephZoller.csv")
sheepB <- sheepB[1:168,]

#figure c: sheep ear
sheepC <- read.csv("datPredictedAgeN18FinalJosephZoller.csv")
sheepC <- sheepC[169:432,]

#figure d: human+sheep, normal age, both
sheephumanD <- read.csv("datPredictedAge_HumanSheep_FinalJosephZoller.csv")

#figure e: human+sheep, normal age, sheep only
sheephumanE <- read.csv("datPredictedAge_HumanSheep_FinalJosephZoller.csv")
sheephumanE <- sheephumanE[1878:2309,]

#figure f: human+sheep, relage, both
sheephumanF <- read.csv("datPredictedRelativeAge_HumanSheep_FinalJosephZoller.csv")

#figure g: human+sheep, relage, sheep only 
sheephumanG <- read.csv("datPredictedRelativeAge_HumanSheep_FinalJosephZoller.csv")
sheephumanG <- sheephumanG[1878:2309,]


p1 <- ggplot(sheepA, aes(x=Age, y=DNAmAgeLOO, colour=Tissue)) + 
  geom_point() + 
  geom_abline(intercept = 0, slope = 1, linetype="dashed") + 
  geom_smooth(method='lm', se= F, size = 0.6, colour="black", aes(group=1))
p1 <- p1 + theme(legend.position = "none")
p2 <- ggplot(sheepB, aes(x=Age, y=DNAmAgeLOO, colour=Tissue)) + 
  geom_point() + 
  geom_abline(intercept = 0, slope = 1, linetype="dashed") + 
  geom_smooth(method='lm', se= F, size = 0.6, colour="black", aes(group=1))
p2 <- p2 + theme(legend.position = "none")
p3 <- ggplot(sheepC, aes(x=Age, y=DNAmAgeLOO, colour=Tissue)) + 
  geom_point() + 
  geom_abline(intercept = 0, slope = 1, linetype="dashed") + 
  geom_smooth(method='lm', se= F, size = 0.6, colour="black", aes(group=1))
p3 <- p3 + theme(legend.position = "none")
p4 <- ggplot(sheephumanD, aes(x=Age, y=DNAmAgeLOFO10Balance, colour=SpeciesLatinName)) + 
  geom_point() + 
  geom_abline(intercept = 0, slope = 1, linetype="dashed") + 
  geom_smooth(method='lm', se= F, size = 0.6, colour="black", aes(group=1))
p4 <- p4 + theme(legend.position = "none")
p5 <- ggplot(sheephumanE, aes(x=Age, y=DNAmAgeLOFO10Balance, colour=Tissue)) + 
  geom_point() + 
  geom_abline(intercept = 0, slope = 1, linetype="dashed") + 
  geom_smooth(method='lm', se= F, size = 0.6, colour="black", aes(group=1))
p5 <- p5 + theme(legend.position = "none")
p6 <- ggplot(sheephumanF, aes(x=RelAge, y=DNAmRelAgeLOFO10Balance, colour=SpeciesLatinName)) + 
  geom_point() + 
  geom_abline(intercept = 0, slope = 1, linetype="dashed") + 
  geom_smooth(method='lm', se= F, size = 0.6, colour="black", aes(group=1))
p6 <- p6 + theme(legend.position = "none")
p7 <- ggplot(sheephumanG, aes(x=RelAge, y=DNAmRelAgeLOFO10Balance, colour=Tissue)) + 
  geom_point() + 
  geom_abline(intercept = 0, slope = 1, linetype="dashed") + 
  geom_smooth(method='lm', se= F, size = 0.6, colour="black", aes(group=1))
p7 <- p7 + theme(legend.position = "none")

prow <- plot_grid(p1, p2, p3, p4, p5, NULL, p6, p7, labels = c('A', 'B', 'C', 'D', 'E', "", 'F', 'G'), label_size = 15, ncol=3)
prow








