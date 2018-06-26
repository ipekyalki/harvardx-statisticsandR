#Getting Started Exercises
#download the dataset
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- "femaleMiceWeights.csv" 
download(url, destfile=filename)

#Q1: Read in the file femaleMiceWeights.csv and report the exact name of the column containing the weights.
femaleMiceWeights <- read.csv("femaleMiceWeights.csv")
# -> Bodyweight

#Q2:The [ and ] symbols can be used to extract specific rows and specific columns of the table. What is the entry in the 12th row and second column?
femaleMiceWeights[12,2]

#Q3:You should have learned how to use the $ character to extract a column from a table and return it as a vector. Use $ to extract the weight column and report the weight of the mouse in the 11th row.
femaleMiceWeights$Bodyweight[11]

#Q4:The length function returns the number of elements in a vector. How many mice are included in our dataset?
str(femaleMiceWeights)
femaleMiceWeights$Diet <- as.character(femaleMiceWeights$Diet)
length(femaleMiceWeights$Diet)

#Q5:To create a vector with the numbers 3 to 7, we can use seq(3,7) or, because they are consecutive, 3:7. 
#View the data and determine what rows are associated with the high fat or hf diet. Then use the mean function to compute the average weight of these mice.
femaleMiceWeights$Diet <- as.factor(femaleMiceWeights$Diet)
weights <- femaleMiceWeights$Bodyweight
weights[3:7]

#determine the mean of the bodyweights with hf
library(dplyr)
x <- femaleMiceWeights %>% filter(Diet == "hf")
mean(x$Bodyweight)
#OR
mean(femaleMiceWeights[femaleMiceWeights$Diet == "hf","Bodyweight"])

#Q6:One of the functions we will be using often is sample. Read the help file for sample using ?sample. 
#Now take a random sample of size 1 from the numbers 13 to 24 and report back the weight of the mouse represented by that row. 
#Make sure to type set.seed(1) to ensure that everybody gets the same answer.
set.seed(1)
index <- sample(13:24,1) #getting the index
index
femaleMiceWeights[16,2] #reporting the weight


#dplyr Exercises 
#download a new dataset related to mammalian sleep
library(downloader)
url="https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"
filename <- basename(url)
download(url,filename)

#Q1: Read in the msleep_ggplot2.csv file with the function read.csv and use the function class to determine what type of object is returned.
msleep <- read.csv("msleep_ggplot2.csv")
class(msleep)

#Q2: Now use the filter function to select only the primates. How many animals in the table are primates? Hint: the nrow function gives you the number of rows of a data frame or matrix.
library(dplyr)
primates <- filter(msleep, order == "Primates")
nrow(primates)

#Q3:What is the class of the object you obtain after subsetting the table to only include primates?
class(primates)  
  
#Q4: Now use the select function to extract the sleep (total) for the primates. What class is this object? Hint: use %>% to pipe the results of the filter function to select.
primates <- filter(msleep, order == "Primates") %>% select(sleep_total)
class(primates)

#Q5: Now we want to calculate the average amount of sleep for primates (the average of the numbers computed above). 
#One challenge is that the mean function requires a vector so, if we simply apply it to the output above, we get an error. 
#Look at the help file for unlist and use it to compute the desired average.
primates <- filter(msleep, order == "Primates") %>% select(sleep_total) %>% unlist(primates)
mean(primates)

#Q6: For the last exercise, we could also use the dplyr summarize function. We have not introduced this function, 
#but you can read the help file and repeat exercise 5, this time using just filter and summarize to get the answer.
primates <- filter(msleep, order == "Primates") %>% summarise(mean(sleep_total))
primates




