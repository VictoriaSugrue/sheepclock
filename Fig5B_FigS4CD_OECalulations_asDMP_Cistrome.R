################## After  (1) finding 'prevalent TFs' in the entire dataset, this script                                                           ########
################## proceeds to calculate the proportion of 'prevalent.TFs in (3) observed overlaps cistrome output from a group of 50 asDMPs,      ########
################## or (2) 'expected' overlaps based on 1000 bootstraps.                                                                            ########
################## (4) The observed/Expected values are then plotted for the first 50; and then (5) selected TFs for all asDMPs                    ######## 




##############(1) First calculate Observed TF proportions for asDMPs (91 files of 50 asDMPs at a time)######################
setwd("~/Dropbox/for_cistrome/docs/ObservedCistomeOverlap/")

#Find cistrome files of interest
infileNms <- list.files(pattern = "*csv")
infileNms

dir.create("PercentagesCalculated")

#Calculate the proportion of each TF in the cistrome output (for a given sample of 50)

#create vector for file naming
file.naming.vector <- c("00","01","02","03","04","05","06","07","08","09",10:91)

#create a total.TF.list, that will eventually hold all the possible TFs binding asDMPs
total.TF.list <- c()

for (i in 1:length(infileNms)){
#  for (i in 1:1){

  command.a <- paste("data <- read.csv(infileNms[",i,"])", sep="")
  print(command.a)
  eval(parse(text=command.a))
  
  TF.list <- as.character(data$Factor)
  #this adds to the total list so none are missed off
  total.TF.list <- c(total.TF.list,TF.list)
  
  #Create Summ.TF for each file
  TF.list <- as.factor(TF.list)
  Summ.TF <- summary.factor(TF.list, maxsum = length(TF.list))
  Summ.TF <- as.data.frame(Summ.TF)
  Summ.TF$Total <- colSums(Summ.TF, na.rm=FALSE)
  Summ.TF$Percentage <- Summ.TF$Summ.TF / Summ.TF$Total * 100 
  Summ.TF <- Summ.TF[order(Summ.TF$Percentage, decreasing=T),]
  write.csv(Summ.TF, paste("PercentagesCalculated/",file.naming.vector[i], "_SummTF.csv", sep=""))
  
  }


#Tally up the most common TFs from the observed dataset
total.TF.list <- as.factor(total.TF.list)
total.Summ.TF <- summary.factor(total.TF.list, maxsum = length(total.TF.list))
total.Summ.TF <- as.matrix(total.Summ.TF)
#order on most prevalent TFs
total.Summ.TF <- total.Summ.TF[order(total.Summ.TF, decreasing=T),]
total.Summ.TF <- as.data.frame(total.Summ.TF)

all.TFs.number <- sum(total.Summ.TF)

proportion.TFs <- total.Summ.TF/all.TFs.number*100

total.Summ.TF <- cbind(total.Summ.TF, proportion.TFs)
prevalent.TFs <- row.names(total.Summ.TF)

#this subsets the data to everything over 0.5% of total output
prevalent.TFs <- prevalent.TFs[1:29]






#################(2) calculate the Expected proportion using 1000 sets of 50 random probes###########
setwd("~/Dropbox/for_cistrome/docs/ExpectedCistromeOverlap/")

#Find files of interest
infileNms <- list.files(pattern = "*csv")
infileNms

dir.create("PercentagesCalculated")


for (i in 1:length(infileNms)){
  #for (i in 1:1){
  
  command.a <- paste("data <- read.csv(infileNms[",i,"])", sep="")
  print(command.a)
  eval(parse(text=command.a))
  
  TF.list <- as.character(data$Factor)
  #this adds to the total list so none are missed off
  total.TF.list <- c(total.TF.list,TF.list)
  
  #Create Summ.TF for each file
  TF.list <- as.factor(TF.list)
  Summ.TF <- summary.factor(TF.list, maxsum = length(TF.list))
  Summ.TF <- as.data.frame(Summ.TF)
  Summ.TF$Total <- colSums(Summ.TF, na.rm=FALSE)
  Summ.TF$Percentage <- Summ.TF$Summ.TF / Summ.TF$Total * 100 
  Summ.TF <- Summ.TF[order(Summ.TF$Percentage, decreasing=T),]
  write.csv(Summ.TF, paste("PercentagesCalculated/",i, "_SummTF.csv", sep=""))
  
}







#################(3) Now find the EXPECTED proportion of "prevalent.TFs"  ###########
setwd("~/Dropbox/for_cistrome/docs/ExpectedCistromeOverlap/PercentagesCalculated/")
percentagefilenames <- list.files(pattern = "*SummTF.csv")
percentagefilenames


#make table to add expected rates from sites of interest
TFs.of.interest.table <- cbind()

#Make an (i) loop going through each of the control files that also has a (j) loop looking at each TF 
for (i in 1:length(percentagefilenames)){
  #for (i in 1:40){
  command.a <- paste("data <- read.csv(percentagefilenames[",i,"])", sep="")
  print(command.a)
  eval(parse(text=command.a))
  
  #create new TFs of interest list
  TFs.of.interest.list <- c()
  
  #start j loop to look at each TF 
  for (j in 1:length(prevalent.TFs)){
  #subset with those TFs of interest
  data2 <- subset(data, data$X %in% prevalent.TFs[j])
  
  #if loop to make sure TFs without occurance still get a value
  if (nrow(data2)>0){
  TFs.of.interest.list <- c(TFs.of.interest.list, data2$Percentage)
  } else {
  TFs.of.interest.list <- c(TFs.of.interest.list, "0")
  }
  
  } #end of j loop
  
  TFs.of.interest.table <- rbind(TFs.of.interest.table, TFs.of.interest.list)

  
  
  }


#add col names and format to a table
colnames(TFs.of.interest.table) <- prevalent.TFs
TFs.of.interest.expected <- as.table(TFs.of.interest.table)



#Plot a couple of these to check they make sense
plot(y=1:1000, x=TFs.of.interest.expected[,"CTCF"])  #CTCF is a common DNA binding factor
plot(y=1:1000, x=TFs.of.interest.expected[,"AR"])    #AR is a less common DNA binding factor



#################(4) Now find the OBSERVED proportion of "prevalent.TFs"  ###########
setwd("~/Dropbox/for_cistrome/docs/ObservedCistomeOverlap/PercentagesCalculated/")
#Find files of interest
percentagefilenames <- list.files(pattern = "*.csv")
percentagefilenames


#make table to add expected rates from sites of interest
TFs.of.interest.table <- cbind()

#Make an (i) loop going through each of the control files that also has a (j) loop looking at each TF 
for (i in 1:length(percentagefilenames)){
  #for (i in 1:40){
  command.a <- paste("data <- read.csv(percentagefilenames[",i,"])", sep="")
  print(command.a)
  eval(parse(text=command.a))
  
  #create new TFs of interest list
  TFs.of.interest.list <- c()
  
  #start j loop to look at each TF 
  for (j in 1:length(prevalent.TFs)){
    #subset with those TFs of interest
    data2 <- subset(data, data$X %in% prevalent.TFs[j])
    
    #if loop to make sure TFs without occurance still get a value
    if (nrow(data2)>0){
      TFs.of.interest.list <- c(TFs.of.interest.list, data2$Percentage)
    } else {
      TFs.of.interest.list <- c(TFs.of.interest.list, "0")
    }
    
  } #end of j loop
  
  TFs.of.interest.table <- rbind(TFs.of.interest.table, TFs.of.interest.list)
  
  
  
}

#add col names and format as table
colnames(TFs.of.interest.table) <- prevalent.TFs
TFs.of.interest.observed <- as.table(TFs.of.interest.table)





#############################################################


            ########calculating O/E ########

#############################################################



#first get the observed and expected values for each prevalent.TF and turn into numeric
TFs.of.interest.expected <- as.data.frame(apply(TFs.of.interest.expected, 2, as.numeric))  # Convert all variable types to numeric
TFs.of.interest.observed <- as.data.frame(apply(TFs.of.interest.observed, 2, as.numeric))  # Convert all variable types to numeric

dev.off()
#############Plot Figure 5B; O/E for first 50#####################
plot(y=TFs.of.interest.observed$AR[1], x=mean(TFs.of.interest.expected$AR), ylim=c(0,20), xlim=c(0,30), frame.plot = F, pch=20, las=1, ylab="% of Cistrome Output Obsersved, Top 50 asDMPs", xlab="% of Cistrome Output Expected")
#arrows(x0=mean(TFs.of.interest.expected$AR)-sd(TFs.of.interest.expected$AR), y0=TFs.of.interest.observed$AR[1], x1=mean(TFs.of.interest.expected$AR)+sd(TFs.of.interest.expected$AR), y1=TFs.of.interest.observed$AR[1], code=3, col="blue", lwd=2, angle=90, length=0.1)
#arrows(x0=min(TFs.of.interest.expected$AR), y0=TFs.of.interest.observed$AR[1], x1=max(TFs.of.interest.expected$AR), y1=TFs.of.interest.observed$AR[1], code=3, col="blue", lwd=2, angle=90, length=0.1)

abline(0,1)

for (i in 1:length(prevalent.TFs)){
  command.a <- paste("points(y=TFs.of.interest.observed$",prevalent.TFs[i],"[1], x=mean(TFs.of.interest.expected$",prevalent.TFs[i],"), ylim=c(0,25), xlim=c(0,10), pch=20, col=\"#fbada7\")",sep="")
  print(command.a)
  eval(parse(text=command.a))
  
  
}

points(y=TFs.of.interest.observed$AR[1], x=mean(TFs.of.interest.expected$AR), ylim=c(0,25), xlim=c(0,10), pch=20, col = "#ddb0ff")
arrows(x0=quantile(TFs.of.interest.expected$AR, probs = 0.95), y0=TFs.of.interest.observed$AR[1], x1=quantile(TFs.of.interest.expected$AR, probs = 0.05), y1=TFs.of.interest.observed$AR[1], code=3, col="#ddb0ff", lwd=2, angle=90, length=0.1)
text(y=TFs.of.interest.observed$AR[1], x=mean(TFs.of.interest.expected$AR), labels="AR", pos=3, col="#ddb0ff")

points(y=TFs.of.interest.observed$FOXA1[1], x=mean(TFs.of.interest.expected$FOXA1), ylim=c(0,25), xlim=c(0,10), pch=20, col="#b0ce66")
arrows(x0=quantile(TFs.of.interest.expected$FOXA1, probs = 0.95), y0=TFs.of.interest.observed$FOXA1[1], x1=quantile(TFs.of.interest.expected$FOXA1, probs = 0.05), y1=TFs.of.interest.observed$FOXA1[1], code=3, lwd=2, angle=90, length=0.1, col="#b0ce66")
text(y=TFs.of.interest.observed$FOXA1[1], x=mean(TFs.of.interest.expected$FOXA1), labels="FOXA1", pos=3, col="#b0ce66")

points(y=TFs.of.interest.observed$NR3C1[1], x=mean(TFs.of.interest.expected$NR3C1), ylim=c(0,25), xlim=c(0,10), pch=20, col = "#ddb0ff")
arrows(x0=quantile(TFs.of.interest.expected$NR3C1, probs = 0.95), y0=TFs.of.interest.observed$NR3C1[1], x1=quantile(TFs.of.interest.expected$NR3C1, probs = 0.05), y1=TFs.of.interest.observed$NR3C1[1], code=3, col="#ddb0ff", lwd=2, angle=90, length=0.1)
text(y=TFs.of.interest.observed$NR3C1[1], x=mean(TFs.of.interest.expected$NR3C1), labels="NR3C1", pos=3, col="#ddb0ff")

points(y=TFs.of.interest.observed$ESR1[1], x=mean(TFs.of.interest.expected$ESR1), ylim=c(0,25), xlim=c(0,10), pch=20, col="#b0ce66")
arrows(x0=quantile(TFs.of.interest.expected$ESR1, probs = 0.95), y0=TFs.of.interest.observed$ESR1[1], x1=quantile(TFs.of.interest.expected$ESR1, probs = 0.05), y1=TFs.of.interest.observed$ESR1[1], code=3, col="#b0ce66", lwd=2, angle=90, length=0.1)
text(y=TFs.of.interest.observed$ESR1[1], x=mean(TFs.of.interest.expected$ESR1), labels="ESR1", pos=3, col="#b0ce66")

points(y=TFs.of.interest.observed$PR[1], x=mean(TFs.of.interest.expected$PR), ylim=c(0,25), xlim=c(0,10), pch=20, col="#b0ce66")
arrows(x0=quantile(TFs.of.interest.expected$PR, probs = 0.95), y0=TFs.of.interest.observed$PR[1], x1=quantile(TFs.of.interest.expected$PR, probs = 0.05), y1=TFs.of.interest.observed$PR[1], code=3, col="#b0ce66", lwd=2, angle=90, length=0.1)
text(y=TFs.of.interest.observed$PR[1], x=mean(TFs.of.interest.expected$PR), labels="PR", pos=3, col="#b0ce66")


points(y=TFs.of.interest.observed$CEBP[1], x=mean(TFs.of.interest.expected$CEBP), ylim=c(0,25), xlim=c(0,10), pch=20, col="#b0ce66")
arrows(x0=quantile(TFs.of.interest.expected$CEBP, probs = 0.95), y0=TFs.of.interest.observed$CEBP[1], x1=quantile(TFs.of.interest.expected$CEBP, probs = 0.05), y1=TFs.of.interest.observed$CEBP[1], code=3, col="#b0ce66", lwd=2, angle=90, length=0.1)
text(y=TFs.of.interest.observed$CEBP[1], x=mean(TFs.of.interest.expected$CEBP), labels="CEBP", pos=3, col="#b0ce66")



points(y=TFs.of.interest.observed$POLR2A[1], x=mean(TFs.of.interest.expected$POLR2A), ylim=c(0,25), xlim=c(0,10), pch=20, col="#b0ce66")
arrows(x0=quantile(TFs.of.interest.expected$POLR2A, probs = 0.95), y0=TFs.of.interest.observed$POLR2A[1], x1=quantile(TFs.of.interest.expected$POLR2A, probs = 0.05), y1=TFs.of.interest.observed$POLR2A[1], code=3, col="#b0ce66", lwd=2, angle=90, length=0.1)
text(y=TFs.of.interest.observed$POLR2A[1], x=mean(TFs.of.interest.expected$POLR2A), labels="POLR2A", pos=3, col="#b0ce66")









###############Plotting O/E for all asDMPs###################
#Supplementary Figure 4C-D
#sanity check to make sure OoverE calc is working
OoverE <- TFs.of.interest.observed$AR/mean(TFs.of.interest.expected$AR)
plot(OoverE, type="l", col="red", frame.plot = F)


par(mfrow=c(2,1))

Hormone.TFs <- c("AR", "NR3C1")

for (i in 1:length(Hormone.TFs)){


  #O/E calculation for each Hormone.TF of interest
  command.a <- paste("OoverE <- TFs.of.interest.observed$",Hormone.TFs[i],"/mean(TFs.of.interest.expected$",Hormone.TFs[i],")", sep="")
  print(command.a)
  eval(parse(text=command.a))
  
  #add in a column to represent the asDMPs index number
  OoverE <- cbind(50*(1:length(OoverE)), OoverE)
  OoverE <- as.data.frame(OoverE)
  colnames(OoverE) <- c("asDMPs", "O/E")
  plot(OoverE, frame.plot = F, type="o", las="1", pch=20, main=Hormone.TFs[i], ylim=c(0,10))
  
  abline(h=1)
  
  
  print(head(OoverE))
  
  
}

