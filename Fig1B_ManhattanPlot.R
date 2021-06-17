setwd("~/Dropbox/Sugrue2020_MS/GitHub_FINAL_SUGRUE2021/data/")
library(ggplot2)
library(qqman)

association <- read.csv("standardScreeningNumericTraitALL.csv", stringsAsFactors = F)

#hypermethylated with age
hyper <- subset(association, cor>0)
hyper <- hyper[,c(3,5,9:13)]
hyper <- na.omit(hyper)
colnames(hyper) <- c("Correlation", "P", "Probe", "CHR", "BP", "BPend", "SNP")
#package needs chromosomes to be numerical. So ChrX is now Chr27.
hyper$CHR[hyper$CHR=="chrX"] <- "chr27"
hyper$CHR <- as.integer(gsub('chr', '', hyper$CHR))
hyper$CHR <- as.numeric(hyper$CHR)

#hypomethylated with age
hypo <- subset(association, cor<0)
hypo <- hypo[,c(3,5,9:13)]
hypo <- na.omit(hypo)
colnames(hypo) <- c("Correlation", "P", "Probe", "CHR", "BP", "BPend", "SNP")
hypo$CHR[hypo$CHR=="chrX"] <- "chr27"
hypo$CHR <- as.integer(gsub('chr', '', hypo$CHR))
hypo$CHR <- as.numeric(hypo$CHR)

#how many on each chromosome?
as.data.frame(table(hyper$CHR))
as.data.frame(table(hypo$CHR))

#basic manhattan plot
manhattan(hyper, col = c("red", "black"), ylim=c(0,60))

#hyper and hypomethylated probes overlaid
plot(manhattan(hyper, annotatePval=0.00000000000000000000000000000000000000001, 
               annotateTop = FALSE,
               ylim = c(0,60),
               col = c("dodgerblue", "dodgerblue3"),
               main = "Manhattan Plot of ALL hypermethylated with age"))
par(new = TRUE)
plot(manhattan(hypo, annotatePval=0.00000000000000000000000000000000000000001, 
               annotateTop = FALSE,
               ylim = c(0,60),
               col = c("firebrick4", "firebrick3"), 
               main = "Manhattan Plot of ALL hypomethylated with age"))








