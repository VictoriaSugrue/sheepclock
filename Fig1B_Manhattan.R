#install.packages("qqman")
#library("qqman")

#####hypERmethylated with age#####
##NOTE: wont allow characters in the CHR column, so X is now chr27.
#also any unmapped probe is removed 
hyper <- read.csv("/Users/victoriasugrue/Desktop/manhattanallhyper.csv")
str(hyper)
head(hyper)

#how many on each chromosome?
as.data.frame(table(hyper$CHR))

#####hypOmethylated with age#####
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







