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
averages2 <- vector("numeric",n)
for(i in 1:n){
  X <- sample(femaleControlsPopulation, 5)
  averages2[i] <- mean(X)
} 
mean((abs(averages2 - avg_data)) > 1)

#Q3:Set the seed at 1, then using a for-loop take a random sample of 50 mice 1,000 times. Save these averages. 
#What proportion of these 1,000 averages are more than 1 gram away from the average of x ?
set.seed(3)
n <- 1000
averages3 <- vector("numeric",n)
for(i in 1:n){
  X <- sample(femaleControlsPopulation, 50)
  averages3[i] <- mean(X)
} 
mean((abs(averages3 - avg_data)) > 1)

#Probability Distributions Exercises
install.packages("gapminder")
library(gapminder)
data(gapminder)
head(gapminder)

#Q1:What is the proportion of countries in 1952 that have a life expectancy less than or equal to 40?
library(dplyr)
y <- filter(gapminder, year=="1952") %>% select(lifeExp) %>% unlist
head(y)
mean(y <= 40)

#Q2:What is the proportion of countries in 1952 that have a life expectancy between 40 and 60 years? 
#Hint: this is the proportion that have a life expectancy less than or equal to 60 years, minus the proportion that have a life expectancy less than or equal to 40 years.
mean(y <= 60) - mean(y <= 40)


#Normal Distribution Exercises

#Q1:Use a histogram to "look" at the distribution of averages we get with a sample size of 5 and a sample size of 50. 
#How would you say they differ?
library(rafalib) 
?mypar
mypar(1,2) # used for displaying two graphs on the same page
bigpar(1,2) #uses big fonts which are good for presentations
hist(averages2, xlim=c(18,30))
hist(averages3, xlim=c(18,30))

#Q2:For the last set of averages, the ones obtained from a sample size of 50, what proportion are between 23 and 25?
#F(25)-F(23)
mean(averages3 <= 25) - mean(averages3 <= 23)

#Q3:Now ask the same question of a normal distribution with average 23.9 and standard deviation 0.43.
#mu = 23.9, sigma=0.43
?pnorm #gives the distribution function
pnorm( (25-23.9) / 0.43) - pnorm((23-23.9) / 0.43) 
#OR
pnorm(25,23.9,0.43)-pnorm(23,23.9,0.43)

#Population, Samples and Estimates Exercises
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/mice_pheno.csv"
filename <- basename(url)
download(url, destfile=filename)
mice_pheno <- na.omit(read.csv(filename))

#Q1:Use dplyr to create a vector x with the body weight of all males on the control (chow) diet. What is this population's average?
library(dplyr)
maleBW_chow <- filter(mice_pheno,Sex == "M", Diet == "chow" ) %>% select(Bodyweight) %>% unlist
maleBW_chow <- as.numeric(maleBW_chow)
x <- mean(maleBW_chow, na.rm=TRUE)

#Q2:Now use the rafalib package and use the popsd function to compute the population standard deviation.
library(rafalib)
?popsd
popsd(maleBW_chow,na.rm = TRUE)

#Q3: Set the seed at 1. Take a random sample X  of size 25 from x. What is the sample average?
set.seed(1)
X <- mean((sample(maleBW_chow, 25)))

#Q4: Use dplyr to create a vector y with the body weight of all males on the high fat hf) diet. 
#What is this population's average?
maleBW_hf <- filter(mice_pheno, Sex == "M", Diet == "hf") %>% select(Bodyweight) %>% unlist
y <- mean(maleBW_hf, na.rm = TRUE)

#Q5: Now use the rafalib package and use the popsd function to compute the population standard deviation.
popsd(maleBW_hf, na.rm = TRUE)

#Q6: Set the seed at 1. Take a random sample Y of size 25 from y. What is the sample average?
set.seed(1)
Y <- mean(sample(maleBW_hf,25))

#Q7:What is the difference in absolute value between  x(bar)- y(bar) and X(bar)- Y(bar) ?
abs((y-x)-(Y-X))

#Q8: Repeat the above for females. Make sure to set the seed to 1 before each sample call. 
#What is the difference in absolute value between x(bar)- y(bar) and X(bar)- Y(bar) ?
femaleBW_chow <- filter(mice_pheno, Sex == "F", Diet == "chow") %>% select(Bodyweight) %>% unlist
femaleBW_hf <- filter(mice_pheno, Sex == "F", Diet == "hf") %>% select(Bodyweight) %>% unlist

a <- mean(femaleBW_chow, na.rm = TRUE)
b <- mean(femaleBW_hf, na.rm = TRUE)

set.seed(1)
A <- mean(sample(femaleBW_chow,25))
set.seed(1)
B <- mean(sample(femaleBW_hf,25))

set.seed(1)
abs((a-b) - (A-B))

#Central Limit Theorem Exercises
?pnorm
help("Distributions")

#Q1:If a list of numbers has a distribution that is well approximated by the normal distribution, 
#what proportion of these numbers are within one standard deviation away from the list's average?
pnorm(1)-pnorm(-1)

#Q2:What proportion of these numbers are within two standard deviations away from the list's average?
pnorm(2) - pnorm(-2)

#Q3:What proportion of these numbers are within three standard deviations away from the list's average?
pnorm(3) - pnorm(-3)

#Q4:Define y to be the weights of males on the control diet. 
#What proportion of the mice are within one standard deviation away from the average weight (remember to use popsd for the population sd)?
y <- filter(mice_pheno, Sex== "M", Diet == "chow") %>% select(Bodyweight) %>% unlist
z <- (y-mean(y))/popsd(y)
mean(abs(z)<=1)

#Q5:What proportion of these numbers are within two standard deviations away from the list's average?
mean(abs(z)<=2)

#Q6:What proportion of these numbers are within three standard deviations away from the list's average?
mean(abs(z)<=3)

#Q7:Note that the numbers for the normal distribution and our weights are relatively close. 
#Also, notice that we are indirectly comparing quantiles of the normal distribution to quantiles of the mouse weight distribution. 
#We can actually compare all quantiles using a qqplot. 
#Which of the following best describes the qq-plot comparing mouse weights to the normal distribution?
mypar(1) 
qqnorm(z)
abline(0,1)
#The mouse weights are well approximated by the normal distribution, although the larger values (right tail) are larger than predicted by the normal. 
#This is consistent with the differences seen between question 3 and 6

#Q8:Create the above qq-plot for the four populations: male/females on each of the two diets. 
#What is the most likely explanation for the mouse weights being well approximated? What is the best explanation for all these being well approximated by the normal distribution?
mypar(2,2)
y <- filter(mice_pheno, Sex=="M" & Diet=="chow") %>% select(Bodyweight) %>% unlist
z <- ( y - mean(y) ) / popsd(y)
qqnorm(z);abline(0,1)
y <- filter(mice_pheno, Sex=="F" & Diet=="chow") %>% select(Bodyweight) %>% unlist
z <- ( y - mean(y) ) / popsd(y)
qqnorm(z);abline(0,1)
y <- filter(mice_pheno, Sex=="M" & Diet=="hf") %>% select(Bodyweight) %>% unlist
z <- ( y - mean(y) ) / popsd(y)
qqnorm(z);abline(0,1)
y <- filter(mice_pheno, Sex=="F" & Diet=="hf") %>% select(Bodyweight) %>% unlist
z <- ( y - mean(y) ) / popsd(y)
qqnorm(z);abline(0,1)
#This just happens to be how nature behaves in this particular case. Perhaps the result of many biological factors averaging out. 

#We will now take a sample of size 25 from the population of males on the chow diet. The average of this sample is our random variable. 
#We will use the replicate to observe 10,000 realizations of this random variable. Set the seed at 1, generate these 10,000 averages. 
#Make a histogram and qq-plot of these 10,000 numbers against the normal distribution.
#We can see that, as predicted by the CLT, the distribution of the random variable is very well approximated by the normal distribution.
y <- filter(mice_pheno, Sex=="M" & Diet=="chow") %>% select(Bodyweight) %>% unlist
set.seed(1)
avgs <- replicate(10000, mean( sample(y, 25)))
mypar(1,2)
hist(avgs)
qqnorm(avgs)
qqline(avgs)

#Q9:What is the average of the distribution of the sample average?
mean(avgs)  
  
#Q10:What is the standard deviation of the distribution of sample averages?
library(rafalib)
popsd(avgs)

