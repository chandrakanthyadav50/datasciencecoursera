setwd("C:/Users/c.chandrakanth/Documents/R Coursera/data/GC/UCI HAR Dataset")
features <- read.table("features.txt")
activitylabels <- read.table("activity_labels.txt")
setwd("./test")
xTstTe <- read.table("X_test.txt")
yTstTe <- read.table("y_test.txt")
subTstTe <- read.table("subject_test.txt")
setwd("../train")
xTstTr <- read.table("X_train.txt")
yTstTr <- read.table("y_train.txt")
subTstTr <- read.table("subject_train.txt")
names(xTstTe) <- features$V2
names(xTstTr) <- features$V2
names(yTstTe) <- c("activity")
names(yTstTr) <- c("activity")
names(subTstTe) <- c("id")
names(subTstTr) <- c("id")
test <- cbind(xTstTe, yTstTe, subTstTe)
train <- cbind(xTstTr, yTstTr, subTstTr)
data <- rbind(train,test)
meanstd <- grep(".*(mean\\(|std\\())", names(data))
data_mean_std <- data[, c(meanstd, 562, 563)]
data_namedactivity <- data_mean_std
for(i in seq(1:length(activitylabels$V1))) {
  data_namedactivity$activity <- gsub(as.character(activitylabels$V1[i]), activitylabels$V2[i], data_namedactivity$activity)
}
data_averages <- aggregate(data_namedactivity[, 1:66], list(data_namedactivity$activity, data_namedactivity$id), mean)
write.table(data_averages, "C:/Users/c.chandrakanth/Documents/R Coursera/data/MergeData.txt", row.names=FALSE)

