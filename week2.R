#Week 2 Random Variable Notes :

control <- filter(femaleMiceWeights, Diet == "chow") %>% select(Bodyweight) %>% unlist
treatment <- filter(femaleMiceWeights, Diet == "hf") %>% select(Bodyweight) %>% unlist
mean(treatment) - mean(control)

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

