#download the dataset
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- "femaleMiceWeights.csv" 
download(url, destfile=filename)

#read the dataset
femaleMiceWeights <- read.csv("femaleMiceWeights.csv")

#play around with the dataset
femaleMiceWeights[12,2]
femaleMiceWeights$Bodyweight[11]
str(femaleMiceWeights)
femaleMiceWeights$Diet <- as.character(femaleMiceWeights$Diet)
length(femaleMiceWeights$Diet)
femaleMiceWeights$Diet <- as.factor(femaleMiceWeights$Diet)
weights <- femaleMiceWeights$Bodyweight
weights[3:7]

#determine the mean of the bodyweights with hf
library(dplyr)
x <- femaleMiceWeights %>% filter(Diet == "hf")
mean(x$Bodyweight)
#OR
mean(femaleMiceWeights[femaleMiceWeights$Diet == "hf","Bodyweight"])

#taking a random sample of size 1 from the numbers 13 to 24 
#and reporting back the weight of the mouse represented by that row.
set.seed(1)
index <- sample(13:24,1) #getting the index
index
femaleMiceWeights[16,2] #reporting the weight


