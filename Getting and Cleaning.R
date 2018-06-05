#Setting the working directory where the files are stored.
setwd("C:/Users/c.chandrakanth/Documents/R Coursera/data/GC/UCI HAR Dataset")
#Importing all the files to modify and use it in the later studies.
features <- read.table("features.txt")
activitylabels <- read.table("activity_labels.txt")
#Going to the test directory
setwd("./test")
#Importing all the files to modify and use it in the later studies.
xTstTe <- read.table("X_test.txt")
yTstTe <- read.table("y_test.txt")
subTstTe <- read.table("subject_test.txt")
#Going to the train directory
setwd("../train")
#Importing all the files to modify and use it in the later studies.
xTstTr <- read.table("X_train.txt")
yTstTr <- read.table("y_train.txt")
subTstTr <- read.table("subject_train.txt")
#Attaching feature names, actvity and id's to the data.
names(xTstTe) <- features$V2
names(xTstTr) <- features$V2
names(yTstTe) <- c("activity")
names(yTstTr) <- c("activity")
names(subTstTe) <- c("id")
names(subTstTr) <- c("id")
#Merging the id, activity and features data through column bind.
test <- cbind(subTstTe, yTstTe, xTstTe)
train <- cbind(subTstTr,yTstTr, xTstTr)
#Merging all the test and train data's through row bind.
data <- rbind(train,test)
#Extracting the mean and standard deviation names from the merged set. 
meanstd <- grep(".*(mean\\(|std\\())", names(data))
#Extracting the mean and standard deviation data from the merged set. 
meanstd_data <- data[,c(1,2,meanstd)]
#Replacing all the numerics with the activity names.
for (i in seq(1:length(activitylabels$V1))) 
{ 
  meanstd_data$activity <- gsub(as.character(activitylabels$V1[i]),activitylabels$V2[i],meanstd_data$activity) 
}
#Calculating the averages.
average_data <- aggregate(meanstd_data[,3:68],list(meanstd_data$activity,meanstd_data$id),mean)
#Exporting the data.
write.table(average_data,"C:/Users/c.chandrakanth/Documents/AverageData.txt",row.names = FALSE)




