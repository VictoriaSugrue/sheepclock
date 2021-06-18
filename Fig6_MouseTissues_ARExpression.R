######AR EXPRESSION

setwd("~/Dropbox/Sugrue2020_MS/GitHub_FINAL_SUGRUE2021/data/")
data <- read.csv("GSE10246.csv")
rownames(data) <- data[,1]
data <- data[,-(1)]


#normalise data between probes on lacrimal gland.2
data$X1422982_at <- data$X1422982_at/data["Lacrimal_gland.2","X1422982_at"]
data$X1437064_at <- data$X1437064_at/data["Lacrimal_gland.2","X1437064_at"]
data$X1455647_at <- data$X1455647_at/data["Lacrimal_gland.2","X1455647_at"]

#order tissues from most highly expressed to least
#data <- data[order(-(rowMeans(data))),]

means <- as.data.frame(rowMeans(data))
data <- cbind(data, means)

#transpose for plotting
data.trans <- t(sapply(data, as.numeric))
colnames(data.trans) <- row.names(data)

#calculate mean and sd
#mean = colMeans(data.trans, na.rm=T)
#no.of.samples = apply(!is.na(data.trans), 2, sum)
#std.dev <- apply(data.trans, 2, sd)

library(reshape2)


pos <- grepl('Epidermis.1|Epidermis.2|Skeletal.muscle.1|Skeletal.muscle.2|Kidney.1|Kidney.2', colnames(data.trans))
neg <- grepl('Liver.1|Liver.2|Cerebellum.1|Cerebellum.2|Cerebral_cortex.1|Cerebral_cortex.2', colnames(data.trans))
#mean <- as.data.frame(mean)
#std.dev <- as.data.frame(std.dev)



AR <- cbind(pos, neg)
AR <- as.data.frame(AR)
AR <- cbind(AR, data)
AR$pos[AR$pos=="TRUE"] <- "Dimorphic"
AR$neg[AR$neg=="TRUE"] <- "Isomorphic"
ARpos <- AR[!grepl("FALSE", AR$pos),]
ARpos <- ARpos[c(1:6),c(1,3:6)]
ARneg <- AR[!grepl("FALSE", AR$neg),]
ARneg <- ARneg[c(1:6),c(2:6)]
colnames(ARpos) <- c("Expression", "X1422982_at", "X1437064_at", "X1455647_at", "mean")
colnames(ARneg) <- c("Expression", "X1422982_at", "X1437064_at", "X1455647_at", "mean")
min <- rbind(ARneg, ARpos)
meanonly <- min[,-(2:4)]
#minlong = melt(min, id.vars = c("Expression"),
    #           measure.vars = c("X1422982_at", "X1437064_at", "X1455647_at", "mean"))

data_summary <- function(data, varname, groupnames){
  require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=TRUE),
      sd = sd(x[[col]], na.rm=TRUE))
  }
  data_sum<-ddply(data, groupnames, .fun=summary_func,
                  varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}

meansd <- data_summary(meanonly, varname="mean", groupnames="Expression")


AREXP <- ggplot(meansd, aes(x=Expression, y=mean)) + 
  geom_bar(stat = "identity", fill="lightgrey", colour="black") + 
  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd), width=0.5) + 
  geom_jitter(meanonly, mapping = aes(x=Expression, y=mean, colour=Expression), width=0.1, size=2, alpha=1/2) +
  ylab("AR Relative Expression") + 
  xlab("MKLN1 Methylation/Sex") +
  scale_x_discrete(limits = c("Isomorphic", "Dimorphic")) +
  theme_classic() +
  theme(legend.position = 'none')

AREXP

#t.test
x=meanonly$Expression
y=meanonly$mean
t.test(y~x)

###########################



#install.packages("dplyr")
library(dplyr)

#Do N2 dataset
setwd("~/Dropbox/N18.2018-9300-1SheepSkinBloodTimHoreRussellSnell/MouseData/DataN2/")
#read in the methylation beta values for each CpG (data) as well as sample details (sample)
data <- read.csv("dat0Small.csv", row.names = 1)
data[,1:485] <- data[,1:485]*100
sample1 <- read.csv("datSample.csv")

#check if there is samples not suitable for aging studies
sample[c(sample$CanBeUsedForAgingStudies == "no")]

#add in a column for "Sex.col"
sample1$Sex.col <- sample1$Sex
#Change 0s and 1s to Male and Female
sample1$Sex.col <- gsub("M", "blue", sample1$Sex.col)
sample1$Sex.col <- gsub("F", "red", sample1$Sex.col)


sample$SpeciesLatinName
sample$Sex
sample$Tissue

Species <- c()


#Define tissues from mouse
#tissues <- c("Blood", "Cerebellum", "Cortex", "Hippocampus", "Kidney", "Liver", "Muscle", "Striatum", "Tail")
tissues <- c("Muscle", "Tail",  "Kidney", "Blood", "Cerebellum", "Cortex", "Hippocampus", "Liver", "Striatum")

#par(mfrow=c(4,5))

int_breaks <- function(x, n = 5) {
  l <- pretty(x, n)
  l[abs(l %% 1) < .Machine$double.eps ^ 0.5] 
}

#Split up data into tissues of interest
for (i in 1:length(tissues)){
  eval(parse(text=paste("sample1.",tissues[i]," <- filter(sample1, Tissue == \"",tissues[i],"\")", sep="")))
  
  #pull out the names of the individuals of interest
  eval(parse(text=paste("names <- as.character(sample1.",tissues[i],"$Basename)", sep = "")))
  #add in X to match format of header
  samples.to.plot <- paste("X",names, sep="")
  
  eval(parse(text=paste("samples.to.plot.",tissues[i]," <- samples.to.plot", sep="")))
  
  
  
  #make a plot of methylation vs age, colouring by sex
  eval(parse(text=paste("p",tissues[i]," <- ggplot(sample1.",tissues[i],", aes(x=sample1.",tissues[i],"$Age, y=as.numeric(data[\"cg21524116\",samples.to.plot.",tissues[i],"]), colour=sample1.",tissues[i],"$Sex.col)) +
                        geom_point(size=2, alpha=3/4) +
                        geom_smooth(method='lm', se=F) +
                        ylab('Methylation (%)') + 
                        xlab('Age (Years)') + 
                        theme_classic() +
                        theme(legend.position = 'none') + 
                        scale_y_continuous(breaks = int_breaks) + 
                        scale_colour_manual(values=c('#00BFC4', '#F8766D')) + 
                        ggtitle('",tissues[i],"')", sep="")))
  
  #eval(parse(text=paste("p",tissues[i], sep="")))
  
}

library(cowplot)
plot_grid(pBlood, pCerebellum, pCortex, pLiver,pMuscle, pTail, pKidney, AREXP, labels = c('A', 'X', 'X', 'X', 'B', 'X', 'X', 'C', 'H'), label_size = 20, nrow=2)




