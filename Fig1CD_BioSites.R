setwd("~/Dropbox/Sugrue2020_MS/GitHub_FINAL_SUGRUE2021/data/")
data <- read.csv("MASTER_Betas_Minfi_Normalised.csv", stringsAsFactors = F)
sample <- read.csv("datPredictedAgeN18FinalJosephZoller.csv", stringsAsFactors = F)
library(ggplot2)
library(dplyr)


#transpose, make cgid column headers
tdata <- as.data.frame(t(data[, -c(1:2)]))
colnames(tdata) <- data$ExternalSampleID

#make new dataframe with probes of interest only, add age
corrdata <- select(tdata, "cg10708287", "cg12097121", "cg16071226", "cg00953859")
corrdata$Age <- sample$Age
colnames(corrdata) <- c("FGF8", "HOXC4", "PAX5", "PAX6", "Age")

longcorrdata = melt(corrdata, id.vars = c("Age"),
                    measure.vars = c("FGF8", "HOXC4", "PAX5", "PAX6"))
colnames(longcorrdata) <- c("Age", "Gene", "Methylation")

longcorrdata$Age=as.numeric(longcorrdata$Age)
longcorrdata$Methylation=as.numeric(longcorrdata$Methylation)

#multiply by 100 to give methylation %
longcorrdata$Methylation <- longcorrdata$Methylation * 100



ggplot(longcorrdata, aes(x=Age, y=Methylation, colour=Gene)) + 
  geom_jitter(width=0.1) +
  stat_smooth(method="lm", formula=y~log(x), fill="grey") +
  ylab("Methylation (%)") +
  xlab("Age (Years)") +
  theme_classic()


#####1D: IGF1
IGF1corr <- select(tdata, "cg18266944")
IGF1corr$Age <- sample$Age
IGF1corr$Female <- sample$Female
IGF1corr$Tissue <- sample$Tissue
IGF1corr <- subset(IGF1corr, Female=="Female")
IGF1corr <- subset(IGF1corr, Tissue=="Ear")
colnames(IGF1corr) <- c("IGF1", "Age")

longIGF1 = melt(IGF1corr, id.vars = c("Age"),
                    measure.vars = c("IGF1"))
colnames(longIGF1) <- c("Age", "Gene", "Methylation")

longIGF1$Age=as.numeric(longIGF1$Age)
longIGF1$Methylation=as.numeric(longIGF1$Methylation)

#multiply by 100 to give methylation %
longIGF1$Methylation <- longIGF1$Methylation * 100

#plot
ggplot(longIGF1, aes(x=Age, y=Methylation, colour=Gene)) + 
  geom_jitter(width=0.1) +
  stat_smooth(method="lm", formula=y~log(x), fill="grey") +
  ylab("Methylation (%)") +
  xlab("Age (Years)") +
  theme_classic()
