#####Cistrome TF count 1000 replicates#####

#reach into all the files and get a percentage for how often each factor comes up 
#per batch of 50 sites and writes them into csv files (writing the .csv files could be skipped)
setwd("/Users/victoriasugrue/Documents/Cistrome/results_1000/")
infileNms <- list.files(pattern = "*csv")
infileNms

for (i in 1:length(infileNms)){
  TF.list <- "fakeTF"
  TF.list <-  TF.list[which(TF.list=="fake.TF")]
  
  command.a <- paste("data <- read.csv(infileNms[",i,"])", sep="")
  print(command.a)
  eval(parse(text=command.a))
  
  data <- data %>% filter(bed_col_7 < 5)
  TFs.toadd <- as.character(data$Factor)
  TF.list <- c(TF.list,TFs.toadd)
  
  TF.list <- as.factor(TF.list)
  Summ.TF <- summary.factor(TF.list, maxsum = length(TF.list))
  Summ.TF <- as.data.frame(Summ.TF)
  Summ.TF$Total <- colSums(Summ.TF, na.rm=FALSE)
  Summ.TF$Percentage <- Summ.TF$Summ.TF / Summ.TF$Total * 100 
  write.csv(Summ.TF, paste0(i, ".csv"))
}

#reach into those new .csv files created above, and pull out the ones of interest only
#Factor titles are now column headers 
library("janitor")

setwd("/Users/victoriasugrue/Documents/Cistrome/results_1000/PercentagesCalculated/")
percentagefilenames <- list.files(pattern = "*csv")
percentagefilenames

for (i in 1:length(percentagefilenames)){
  command.a <- paste("data <- read.csv(percentagefilenames[",i,"])", sep="")
  print(command.a)
  eval(parse(text=command.a))
  
  data <- as.data.frame(t(data))
  data <- janitor::row_to_names(data, row_number = 1, remove_row = TRUE)
  datatop <- select(data, one_of("AR", "FOXA1", "CTCF", "NR3C1", "ESR1", "EP300", "POLR2A", "CEBPB", "PR", "BRD4", "OTX2", "SPI1", "GATA3", "HOXB13"))
  write.csv(datatop, paste0(i, "top.csv"))
  
}

#pull out the AR (etc) of each file into a dataframe. best if you are looking at a specific TF
setwd("/Users/victoriasugrue/Documents/Cistrome/results_1000/PercentagesCalculated/Tops/")
topfilenames <- list.files(pattern = "*csv", full.names = TRUE)
topfilenames

AR <- lapply(topfilenames, read.csv, header=TRUE, stringsAsFactors=FALSE)
AR <- lapply(AR, "[", c("AR"))
AR <- as.data.frame(AR)
write.csv(AR, "/Users/victoriasugrue/Documents/Cistrome/results_1000/PercentagesCalculated/Tops/TOPTFS/AR.csv")


#####loop to find the average expected binding rates for EVERY TF#####
#writing to .csv files each time is not necessary
#first transpose the dataframes so TF names are headers
setwd("/Users/victoriasugrue/Documents/Cistrome/results_1000/PercentagesCalculated/")
TFnames <- list.files(pattern = "*csv")
TFnames

for (i in 1:length(TFnames)){
  command.a <- paste("data <- read.csv(TFnames[",i,"])", sep="")
  print(command.a)
  eval(parse(text=command.a))
  
  data <- as.data.frame(t(data))
  data <- janitor::row_to_names(data, row_number = 1, remove_row = TRUE)
  write.csv(data, paste0(i, "transposed.csv"))
  
}

#next pull out only the percentage rows
setwd("/Users/victoriasugrue/Documents/Cistrome/results_1000/PercentagesCalculated/transposed/")
transnames <- list.files(pattern = "*csv")
transnames

for (i in 1:length(transnames)){
  command.a <- paste("data <- read.csv(transnames[",i,"])", sep="")
  print(command.a)
  eval(parse(text=command.a))
  
  data <- data[3,]
  write.csv(data, paste0(i, "percentage.csv"))
}

#combine all columns with identical headers
setwd("/Users/victoriasugrue/Documents/Cistrome/results_1000/PercentagesCalculated/transposed/percentage/")
pernames <- list.files(pattern= "*csv")
pernames

library(data.table)
bound <- rbindlist(lapply(list.files(), fread), fill = TRUE)
write.csv(bound, "bound.csv")