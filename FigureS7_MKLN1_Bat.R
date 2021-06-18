#install.packages("dplyr")
library(dplyr)

#Find bat folder
setwd("~/Dropbox/N18.2018-9300-1SheepSkinBloodTimHoreRussellSnell/MouseData/BatDataN15/")
#read in the methylation beta values for each CpG (data) as well as sample details (sample)
data <- read.csv("dat0Small.csv", row.names = 1)
sample <- read.csv("datSample.csv")

#add in a column for "Sex.col"
sample$Sex.col <- sample$Sex
#Change 0s and 1s to Male and Female
sample$Sex.col <- gsub("M", "blue", sample$Sex.col)
sample$Sex.col <- gsub("F", "red", sample$Sex.col)


#check if there is samples not suitable for aging studies
sample[c(sample$CanBeUsedForAgingStudies == "no")]

sample$SpeciesLatinName
sample$Family
sample$Sex

#choose the species needed - either all or a selection of Pteropus
Species <- c("Phyllostomus discolor", "Phyllostomus hastatus", "Pteropus hypomelanus","Pteropus poliocephalus", "Pteropus pumilus", "Pteropus rodricensis", "Pteropus vampyrus")





par(mfrow=c(3,3))


for (j in 1:length(Species)){
  
  #define species
  eval(parse(text=paste("sample1 <- filter(sample, SpeciesLatinName == \"",Species[j],"\")", sep = ""))) 
  
#Define tissues from bat
tissues <- c("Skin")

#Split up data into tissues of interest
for (i in 1:length(tissues)){
  eval(parse(text=paste("sample.",tissues[i]," <- filter(sample1, Tissue == \"",tissues[i],"\")", sep="")))
}



#pull out the names of the individuals of interest
names <- as.character(sample.Skin$Basename)
#add in X to match format of header
samples.to.plot <- paste("X",names, sep="")



#make a plot of methylation vs age, colouring by sex
plot(y=as.numeric(data["cg21524116",samples.to.plot]), x=sample.Skin$Age, col=sample.Skin$Sex.col, pch=20, frame.plot = F, main = Species[j], las=1, ylim=c(0,1),ylab="MKLN1 (cg21524116) methylation", xlab = "Age (years)", xlim=c(0,20))
}


#######################end#################





