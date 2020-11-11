#read in minfi normalised beta values
minfibetas <- read.csv("/Users/victoriasugrue/Documents/Data_Files/MASTERS_DoNotEdit/MASTER_Betas_Minfi_Normalised.csv", header=FALSE)

#transpose the dataframe and remove unneeded columns
tminfibetas <- as.data.frame(t(minfibetas[,-c(1:2)]))

#read in file for headers and transpose it, assign the headers to the minfi normalised data
headers <- read.csv("/Users/victoriasugrue/Documents/Data_Files/MASTERS_DoNotEdit/MASTER_Minfi_Headers_forR.csv", header=FALSE)
theaders <- as.list(t(headers))
names(tminfibetas) <- theaders


#this treats the data as factors, not numeric, so graphs don't work
#to fix this, first must convert the columns of interest to numeric data
#change the cg to whichever is of interest
tminfibetas$Age=as.numeric(levels(tminfibetas$Age))[tminfibetas$Age] #run once only
tminfibetas$cg21524116=as.numeric(levels(tminfibetas$cg21524116))[tminfibetas$cg21524116] #run for each cg you wish to plot

#plot:
#this is for a jittered scatterplot of Age x Probe methylation with a linear regression applied
#again, change cg 
library(ggplot2)
p1 <- ggplot(tminfibetas, aes(x=Age, y=cg21524116, colour=Sex)) + 
  geom_jitter(width=0.1) + 
  geom_smooth(method=lm) +
  ggtitle("MKLN1 cg21524116")
p1 + scale_x_continuous("Age") + scale_y_continuous(limits=c(0,1)) 



#subset into blood only, if desired
blood <- tminfibetas[1:168,]

blood$Age=as.numeric(levels(blood$Age))[blood$Age]
blood$cg21524116=as.numeric(levels(blood$cg21524116))[blood$cg21524116]

p1 <- ggplot(blood, aes(x=Age, y=cg21524116, colour=BloodSex)) + 
  geom_jitter(width=0.1) + 
  geom_smooth(method=lm) +
  ggtitle("MKLN1 sheep blood cg21524116")
p1 + scale_x_continuous("Age") + scale_y_continuous(limits=c(0,1)) 

#subset into ear only, if desired
ear <- tminfibetas[169:432,]



