#this file contains scripts for the following figures: 1B, 2, 3, 4, 5A-B, and supplementary figures 2B, 4A, 6

#####Figure 1B: Manhattan Plot#####

install.packages("qqman")
library("qqman")

#hypERmethylated with age
#NOTE: wont allow characters in the CHR column, so X is now chr27.
#also any unmapped probe is removed 
hyper <- read.csv("/Users/victoriasugrue/Desktop/manhattanallhyper.csv")
str(hyper)
head(hyper)

#how many on each chromosome?
as.data.frame(table(hyper$CHR))

#hypOmethylated with age#
hypo <- read.csv("/Users/victoriasugrue/Desktop/manhattanallhypo.csv")
str(hypo)
head(hypo)

#how many on each chromosome?
as.data.frame(table(hypo$CHR))

#basic manhattan plot
manhattan(hypo, col = c("red", "black"), ylim=c(0,60))

#hyper and hypomethylated probes overlaid
plot(manhattan(hyper, annotatePval=0.00000000000000000000000000000000000000001, 
               annotateTop = FALSE,
               ylim = c(0,60),
               col = c("dodgerblue", "dodgerblue3"),
               main = "Manhattan Plot of ALL hypermethylated with age",
               chrlabs = c(1:26, "X")))
par(new = TRUE)
plot(manhattan(hypo, annotatePval=0.00000000000000000000000000000000000000001, 
               annotateTop = FALSE,
               ylim = c(0,60),
               col = c("firebrick4", "firebrick3"), 
               main = "Manhattan Plot of ALL hypomethylated with age",
               chrlabs = c(1:26, "X")), add=TRUE)


######Figure 2: Sheep Clocks#####

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



#####Figure 3: Age Acceleration and Age Dependency#####

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




#####Figure 4: Androgen-Sensitive Differentially Methylated Probes#####

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




#####Figure 5A: asDMP by P-Value and Androgen Receptor Binding#####


library(ggplot2)
library(scales)
theme_set(theme_minimal())

ARramwether <- read.csv("/Users/victoriasugrue/Desktop/ARramwether2.csv") #contains p-values for top 50 asDMPs & information regarding AR binding (from Cistrome database)

positions <- c("DLX1 cg05219494", "FOSB cg10427592", "CASZ1 cg03329528", "TTN cg20683822", "ADAMTS6 cg14411132", "LINC01102 cg13869290", "KIAA2026 cg22489511", "cg13296708", 
               "ZBTB7B cg04627377", "SLMAP cg05072035", "TRPV3 cg20318153", "RBM10 cg26112867", "PRDM6 cg13468491", "NMT1 cg16080654", "cg14319933", "cg22698853", "SLC6A7 cg21349273", 
               "cg12603816", "GAS1 cg03275335", "KCNC2 cg25996664", "SRSF7 cg06959732", "ASXL3 cg20424596",  "IGSF21 cg19124333", "FAM172A cg03032396", "BRINP3 cg24451994", 
               "NOVA1 cg01675333", "MAP2K5 cg08979438", "LINC01235 cg12120400", "RUNX1T1 cg01090134", "SCUBE3 cg12357722", "FN1 cg07158748",  "PHC3 cg20017216",  
               "KCNIP1 cg11035838",  "LINC01894 cg14592546", "CASZ1 cg06145973", "CACNA1I cg06579027", "SRRM2 cg07324453",  "cg09315446",  "BCOR cg18315252", 
               "NOVA1 cg03121178", "LINC01364 cg12863556", "RBM10 cg03197661",  "LINC01364 cg11082332",  "TEX41 cg12129962", "SETD5 cg17489709", "KIAA2026 cg00658920", 
               "LINC01364 cg15851301",  "cg05771328",  "cg01822430", "MKLN1 cg21524116"
)

ggplot(ARramwether, aes(x=name, y=logo10, colour=AR, shape=Intact.male.methylation)) + 
  geom_point(size=3) + 
  scale_x_discrete(limits = positions) + 
  ylab("P-Value (log10)") + 
  xlab ("CpG ID and Gene Name") + 
  scale_y_reverse() + 
  coord_flip() 





#####Figure 5B: Cistrome Observed v Expected TF Binding#####


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




######Supplementary Figure 2B: Global Methylation######


library(ggplot2)

global <- read.csv("/Users/victoriasugrue/Desktop/globalmethaverage.csv") #contains file of average global methylation across all probes in each individual sample

ggplot(global, aes(x=Age, y=average, colour=Sex)) +
  geom_jitter(width=0.1, size=4, alpha=1/1.1) + 
  geom_smooth(method=lm, se=FALSE, size=1) + 
  theme_classic() + 
  ggtitle("Global methylation") + 
  ylab("Average methylation (%)") +
  xlab("Age (years)")




#####Supplementary Figure 4A: Inflection Point of asDMP P-Value#####


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




#####Supplementary Figure 6: Lamb Mass#####

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