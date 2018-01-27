dataset <- read.csv("file:///C:/Users/Mr Sandipan/Downloads/Analytics Vidhaya/train.csv", header = TRUE)
str(dataset)
dataset.test <- read.csv("file:///C:/Users/Mr Sandipan/Downloads/Analytics Vidhaya/test.csv", header = TRUE)

#Dummy Variables
#Creating new columns Dates and Hours
Hours <- format(as.POSIXct(strptime(dataset$datetime,"%Y-%m-%d %H:%M:%S",tz="")) ,format = "%H")
Dates <- format(as.POSIXct(strptime(dataset$datetime,"%Y-%m-%d %H:%M:%S",tz="")) ,format = "%d/%m/%Y")
dataset$Dates <- Dates
dataset$Hours <- Hours
str(dataset)

#Converting char into Date data type
dataset$Dates<- as.Date(dataset$Dates, "%d/%m/%Y")
str(dataset)

#Converting Date column into specific day, month ,year
dataset$month=format(dataset$Dates,"%m")
dataset$month = as.numeric(dataset$month)
dataset$day=format(dataset$Dates,"%d")
dataset$day = as.numeric(dataset$day)
dataset$year =format(dataset$Dates,"%Y")
dataset$year = as.numeric(dataset$year)

#Converting char into factor data type because it will have only 24 factors which can be handle by R
dataset$Hours <- as.numeric(dataset$Hours)
str(dataset)
dataset$var2 <- as.numeric(dataset$var2)
str(dataset)

#######################
#Dummy Variables
#Creating new columns Dates and Hours
Hours <- format(as.POSIXct(strptime(dataset.test$datetime,"%Y-%m-%d %H:%M:%S",tz="")) ,format = "%H")
Dates <- format(as.POSIXct(strptime(dataset.test$datetime,"%Y-%m-%d %H:%M:%S",tz="")) ,format = "%d/%m/%Y")
dataset.test$Dates <- Dates
dataset.test$Hours <- Hours
str(dataset.test)

#Converting char into Date data type
dataset.test$Dates<- as.Date(dataset.test$Dates, "%d/%m/%Y")
str(dataset.test)

#Converting Date column into specific day, month ,year
dataset.test$month=format(dataset.test$Dates,"%m")
dataset.test$month = as.numeric(dataset.test$month)
dataset.test$day=format(dataset.test$Dates,"%d")
dataset.test$day = as.numeric(dataset.test$day)
dataset.test$year =format(dataset.test$Dates,"%Y")
dataset.test$year = as.numeric(dataset.test$year)

#Converting char into factor data type because it will have only 24 factors which can be handle by R
dataset.test$Hours <- as.numeric(dataset.test$Hours)
str(dataset.test)
dataset.test$var2 <- as.numeric(dataset.test$var2)
str(dataset.test)
#Divide the dataset into training and testing
#library(caTools)
#split <- sample.split(dataset$electricity_consumption, SplitRatio = 0.7)
#training_set <- subset(dataset,split == TRUE)
#head(training_set)
#test_set <- subset(dataset, split == FALSE)
#head(test_set)


#Random Forest
library(randomForest)
regressor = randomForest(x = dataset[c(3,4,7,10,11,12)],
                         y = dataset$electricity_consumption,
                         ntree = 100)

electricity_consumption<-predict(regressor,newdata = dataset.test)
ID <-dataset.test$ID
output.df<- as.data.frame(ID)
output.df$electricity_consumption <- electricity_consumption
write.csv(output.df, "file:///C:/Users/Mr Sandipan/Downloads/Analytics Vidhaya/submission5RandomForest.csv", row.names = FALSE)
