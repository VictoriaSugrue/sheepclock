####This analysis is to compare ASDMR methylation in young males where we have mass data 
library(dplyr)
#install.packages("broom")
library(broom)
options(stringsAsFactors = FALSE)
setwd("~/Dropbox/Sugrue2020_MS/GitHub_FINAL_SUGRUE2021/data/")
#read in ram methylation data and turn into a useful dataframe
data <- read.csv("MASTER_Betas_Minfi_Normalised.csv", stringsAsFactors = F)
datExpr = as.data.frame(t(data[, -c(1:4)]))
colnames(datExpr) <- data$ExternalSampleID
#Split the sex/castration status, remove blood
datExpr[1:10,1:10]
datExpr$Sex

datExpr.ewe <- filter(datExpr, Sex=="Ewe")
datExpr.ram <- filter(datExpr, Sex=="Ram")
datExpr.wether <- filter(datExpr, Sex=="Wether")

#define the ASDMRs and their names
ASDMRs <- read.csv("~/Dropbox/Sugrue2020_MS/Figures_Tables/ELIFE formatted and numbered/Supplementary Tables/Table S3 androgenSensitiveSites.csv", stringsAsFactors = F)

ASDMRs.gene <- c("MKLN1", "ETAA1", "LMO4", "KIAA2026")
ASDMRs.CpG <- c("cg21524116", "cg01822430", "cg15851301", "cg00658920")


#plot the methylation values for the ASDMRS....this is just to check everything is working
par(mfrow = c(2,2))


for (i in 1:length(ASDMRs.gene)){
  
  eval(parse(text=paste("plot(y=as.numeric(datExpr.ewe$",ASDMRs.CpG[i],"), x=as.numeric(datExpr.ewe$Age), ylim=c(0,1), frame.plot=F, col=\"white\", main=\"",ASDMRs.gene[i],"\")", sep="")))
  eval(parse(text=paste("points(y=as.vector(datExpr.ram$",ASDMRs.CpG[i],"), x=datExpr.ram$Age, ylim=c(0,1), col=\"blue\")", sep="")))
  eval(parse(text=paste("points(y=as.vector(datExpr.wether$",ASDMRs.CpG[i],"), x=datExpr.wether$Age, ylim=c(0,1), col=\"green\")", sep="")))
}


##############repeat analysis but only looking at the young rams, add in mass data############

datExpr <- filter(datExpr, Age=="0.539356605")
#read in the mass data
data.mass <- read.csv("YoungRamWetherInfo_DNAQuantEtc.csv", stringsAsFactors = F)
#order both datasets  and then combine, split for Ram and Wether
data.mass <- data.mass[(order(data.mass$Name)),]
datExpr <- datExpr[(order(rownames(datExpr))),]
datExpr <- cbind(datExpr, data.mass)
datExpr.ram <- filter(datExpr, Sex=="Ram")
datExpr.wether <- filter(datExpr, Sex=="Wether")



#plot the methylation vs mass values for the 4 'iconic' asDMRS
par(mfrow = c(1,4))

#for the  asDMRs, calculate slope for rams and wethers, and put into Coeffic.table.ram or Coeffic.table.wether. 
for (i in 1:length(ASDMRs.gene)){
  eval(parse(text=paste("plot(y=datExpr$",ASDMRs.CpG[i],", x=datExpr$Mass..kg., frame.plot = F, xlab = \"Mass (kg)\", ylab = \"",ASDMRs.CpG[i],"_methylation\", main=\"",ASDMRs.gene[i],"\")", sep="")))
  eval(parse(text=paste("points(y=datExpr.ram$",ASDMRs.CpG[i],", x=datExpr.ram$Mass..kg., col=\"green\")", sep="")))
  eval(parse(text=paste("abline(lm(as.numeric(datExpr.ram$",ASDMRs.CpG[i],") ~ datExpr.ram$Mass..kg.), col=\"green\")", sep="")))
  eval(parse(text=paste("print(summary(lm(as.numeric(datExpr.ram$",ASDMRs.CpG[i],") ~ datExpr.ram$Mass..kg.)))", sep="")))
  eval(parse(text=paste("points(y=datExpr.wether$",ASDMRs.CpG[i],", x=datExpr.wether$Mass..kg., col=\"blue\")", sep="")))
  eval(parse(text=paste("abline(lm(as.numeric(datExpr.wether$",ASDMRs.CpG[i],") ~ datExpr.wether$Mass..kg.), col=\"blue\")", sep="")))
  eval(parse(text=paste("print(summary(lm(as.numeric(datExpr.wether$",ASDMRs.CpG[i],") ~ datExpr.wether$Mass..kg.)))", sep="")))
  eval(parse(text=paste("print(tidy(summary(lm(as.numeric(datExpr.wether$",ASDMRs.CpG[i],") ~ datExpr.wether$Mass..kg.))))", sep="")))
  eval(parse(text=paste("print(confint(lm(as.numeric(datExpr.wether$",ASDMRs.CpG[i],") ~ datExpr.wether$Mass..kg.)))", sep="")))
  
}


#############################Calculate correlation between ASDMPs windows and lamb mass######
#ttestlist.test
ttestlist.test <- c()

#define a list for slopes
mean.slope.ram.list <- c()
mean.slope.wether.list <- c()

mass.vs.meth <- c()

for (j in 1:450){
  
  #Define overlap and windows (in this case 10 and 100)
  ASDMRs.gene <- ASDMRs$Gene.Symbol[((10*j)+1):((10*j)+100)]
  ASDMRs.CpG <- ASDMRs$CpG.ID[((10*j)+1):((10*j)+100)]


#Define a table to put slope into
Coeffic.table.ram <- c()
Coeffic.table.wether <- c()



#for the  asDMRs, calculate slope for rams and wethers, and put into Coeffic.table.ram or Coeffic.table.wether. 
for (i in 1:length(ASDMRs.gene)){
eval(parse(text=paste("Coeffic.table <- tidy(summary(lm(as.numeric(datExpr.ram$",ASDMRs.CpG[i],") ~ datExpr.ram$Mass..kg.)))", sep="")))
Coeffic.table.ram <- rbind(Coeffic.table.ram,Coeffic.table[2,])
eval(parse(text=paste("Coeffic.table <- tidy(summary(lm(as.numeric(datExpr.wether$",ASDMRs.CpG[i],") ~ datExpr.wether$Mass..kg.)))", sep="")))
Coeffic.table.wether <- rbind(Coeffic.table.wether,Coeffic.table[2,])

mean.slope.ram <- mean(mass.vs.meth$ram)
mean.slope.wether <- mean(mass.vs.meth$wether)

}

mass.vs.meth <- list("ram"=Coeffic.table.ram$estimate, "wether"=Coeffic.table.wether$estimate)


t.test.test <- t.test(mass.vs.meth$ram)
ttestlist.test <- c(ttestlist.test,t.test.test$p.value)
print(paste("Replication ",j," is complete", sep = ""))

#make list of slopes
mean.slope.ram.list <- c(mean.slope.ram.list, mean.slope.ram)
mean.slope.wether.list <- c(mean.slope.wether.list, mean.slope.wether)


}

par(mfrow=c(2,1))

#plot slope for each window
plot(mean.slope.ram.list, frame.plot = F, col="green", ylim = c(-0.005,0.005), las=1, ylab="Association", pch=16)

abline(h=0, col="black")
points(mean.slope.wether.list, col="blue", pch=16)
#plot significance
plot(ttestlist.test, log ="y", col="red", frame.plot=F, las=1, ylab="Significance", pch=16)



################Plot the signficance line###############
####### note this works once the "ttestlist.test.control.txt" file has been created, otherwise run "simulation for background" below.....


#read the file ttestlist.test.control
ttestlist.test.control.txt <- read.csv("ttestlist.test.control.txt")

#find 99% quantile and plot it
threshold_control=as.numeric(quantile(ttestlist.test.control,probs = 0.01))
abline(h=threshold_control, col="red")

##########################END FOR FIGURE##############





##############running a simulation for the background###################

#create ttestlist.test.control
ttestlist.test.control <- c()


for (j in 1:10000){
  
  #define random numbers for the sampling
  ran.num.ASDMR <-  sample(4:37495, 100)
  #Use these random numbers to pick out random CpGs
  ASDMRs.gene.control <- "test"
  ASDMRs.CpG.control <- colnames(datExpr[ran.num.ASDMR])
  
  #Define a control table to put slope into
  Coeffic.table.ram.control <- c()
  Coeffic.table.wether.control <- c()
  
  
  #for control asDMRs, calculate slope for rams and wethers, and put into Coeffc.table.ram or Coeffic.table.wether.control
  for (i in 1:length(ASDMRs.CpG.control)){
    eval(parse(text=paste("Coeffic.table <- tidy(summary(lm(as.numeric(datExpr.ram$",ASDMRs.CpG.control[i],") ~ datExpr.ram$Mass..kg.)))", sep="")))
    Coeffic.table.ram.control <- rbind(Coeffic.table.ram.control,Coeffic.table[2,])
    eval(parse(text=paste("corr.ram.control <- cor(as.numeric(datExpr.ram$",ASDMRs.CpG.control[i],"), datExpr.ram$Mass..kg.)", sep="")))
    eval(parse(text=paste("Coeffic.table <- tidy(summary(lm(as.numeric(datExpr.wether$",ASDMRs.CpG.control[i],") ~ datExpr.wether$Mass..kg.)))", sep="")))
    Coeffic.table.wether.control <- rbind(Coeffic.table.wether.control,Coeffic.table[2,])
    eval(parse(text=paste("corr.wether.control <- cor(as.numeric(datExpr.wether$",ASDMRs.CpG.control[i],"), datExpr.wether$Mass..kg.)", sep="")))
  }
  
  mass.vs.meth <- list("ram"=Coeffic.table.ram$estimate, "wether"=Coeffic.table.wether$estimate, "control.ram"=Coeffic.table.ram.control$estimate, "control.wether"=Coeffic.table.wether.control$estimate)
  
  
  
  
  
  
  #t.test.ramvswether <- t.test(mass.vs.meth$ram, mass.vs.meth$wether)
  t.test.control <- t.test(mass.vs.meth$control.ram, mass.vs.meth$control.wether)
  ttestlist.test.control <- c(ttestlist.test.control,t.test.control$p.value)
  print(paste("Replication ",j," is complete", sep = ""))
  
}

#save the file ttestlist.test.control
write.csv(ttestlist.test.control, "ttestlist.test.control.txt", row.names = F)

################Plot the signficance line###############
####### note this works once the "ttestlist.test.control.txt" file has been created, otherwise run "simulation for background" below.....


#read the file ttestlist.test.control
ttestlist.test.control.txt <- read.csv("ttestlist.test.control.txt")

#find 99% quantile and plot it
threshold_control=as.numeric(quantile(ttestlist.test.control,probs = 0.01))
abline(h=threshold_control, col="red")




##############Plot the top 50 ASDMPs, plus the random samples###################

mass.vs.meth <- list("ram"=Coeffic.table.ram$estimate, "wether"=Coeffic.table.wether$estimate,  "control.ram"=Coeffic.table.ram.control$estimate, "control.wether"=Coeffic.table.wether.control$estimate)
dev.off()
stripchart(mass.vs.meth, pch=16, col=c("green", "blue"), vertical=TRUE, frame.plot=F, method="jitter", las=2)

t.test.ramvswether <- t.test(mass.vs.meth$ram, mass.vs.meth$wether)
t.test.control <- t.test(mass.vs.meth$control.ram, mass.vs.meth$control.wether)

