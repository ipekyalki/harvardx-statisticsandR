#Week 2 Random Variable Notes :

control <- filter(femaleMiceWeights, Diet == "chow") %>% select(Bodyweight) %>% unlist
treatment <- filter(femaleMiceWeights, Diet == "hf") %>% select(Bodyweight) %>% unlist
obs <- mean(treatment) - mean(control)


#Download the femaleControlsPopulation file
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleControlsPopulation.csv"
filename <- "femaleControlsPopulation.csv" 
download(url, destfile=filename)

#Read the file
femaleControlsPopulation <- read.csv("https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleControlsPopulation.csv")
femaleControlsPopulation <- unlist(femaleControlsPopulation)

mean(sample(femaleControlsPopulation, 12))
mean(control)
mean(treatment)
mean(sample(femaleControlsPopulation, 12))
mean(sample(femaleControlsPopulation, 12))

#Random Variable Exercises

#Q1:What is the average of these weights?
mean(femaleControlsPopulation)

#Q2: After setting the seed at 1, set.seed(1) take a random sample of size 5. What is the absolute value (use abs) of the difference between the average of the sample and the average of all the values?
set.seed(1)
abs(mean(sample(femaleControlsPopulation,5) - mean(femaleControlsPopulation)))

#Q3: After setting the seed at 5, set.seed(5) take a random sample of size 5. What is the absolute value of the difference between the average of the sample and the average of all the values?
set.seed(5)
abs(mean(sample(femaleControlsPopulation,5) - mean(femaleControlsPopulation)))

#Week 2 Null Distribution Notes :

control <- filter(femaleMiceWeights, Diet == "chow") %>% select(Bodyweight) %>% unlist
treatment <- filter(femaleMiceWeights, Diet == "hf") %>% select(Bodyweight) %>% unlist
obs <- mean(treatment) - mean(control)

View(femaleControlsPopulation)
femaleControlsPopulation <- unlist(femaleControlsPopulation)
femaleControlsPopulation

n <- 10000
nulls <- vector("numeric",n)
for(i in 1:n){
control2 <- sample(femaleControlsPopulation, 12)
treatment2 <- sample(femaleControlsPopulation, 12)
nulls[i] <- mean(treatment2) - mean(control2)
}

max(nulls)
hist(nulls)

sum(nulls > obs) / n #p-value
#OR
mean(abs(nulls) > obs) #p-value

#Null Distribution Exercises

#Q1:Set the seed at 1, then using a for-loop take a random sample of 5 mice 1,000 times. Save these averages. 
#What proportion of these 1,000 averages are more than 1 gram away from the average of x ?
avg_data <- mean(femaleControlsPopulation)
head(femaleControlsPopulation)
set.seed(3)
n <- 1000
averages <- vector("numeric",n)
for(i in 1:n){
  X <- sample(femaleControlsPopulation, 5)
  averages[i] <- mean(X)
}
mean((abs(averages - avg_data)) > 1)

#Q2: We are now going to increase the number of times we redo the sample from 1,000 to 10,000. 
#Set the seed at 1, then using a for-loop take a random sample of 5 mice 10,000 times. Save these averages. 
#What proportion of these 10,000 averages are more than 1 gram away from the average of x ?
set.seed(3)
n <- 10000
averages <- vector("numeric",n)
for(i in 1:n){
  X <- sample(femaleControlsPopulation, 5)
  averages[i] <- mean(X)
} 
mean((abs(averages - avg_data)) > 1)

#Set the seed at 1, then using a for-loop take a random sample of 50 mice 1,000 times. Save these averages. 
#What proportion of these 1,000 averages are more than 1 gram away from the average of x ?
set.seed(3)
n <- 1000
averages2 <- vector("numeric",n)
for(i in 1:n){
  X <- sample(femaleControlsPopulation, 50)
  averages2[i] <- mean(X)
} 
mean((abs(averages2 - avg_data)) > 1)
