#set base directory to read data
basedir<-"C:/Rwork/UCI HAR Dataset"

#read data files
data_subject_train <- read.table(paste0(basedir,"/train/subject_train.txt"), quote="\"")
data_X_train <- read.table(paste0(basedir,"/train/X_train.txt"), quote="\"")
data_y_train <- read.table(paste0(basedir,"/train/y_train.txt"), quote="\"")

data_subject_test <- read.table(paste0(basedir,"/test/subject_test.txt"), quote="\"")
data_X_test <- read.table(paste0(basedir,"/test/X_test.txt"), quote="\"")
data_y_test <- read.table(paste0(basedir,"/test/y_test.txt"), quote="\"")

data_features <- read.table(paste0(basedir,"/features.txt"), quote="\"")
data_activity_labels <- read.table(paste0(basedir,"/activity_labels.txt"), quote="\"")

#merge test and train rows
data_subject_merged<- rbind(data_subject_train,data_subject_test)
colnames(data_subject_merged) <-"SubjectID"
data_X_merged <-rbind(data_X_train,data_X_test)
data_Y_merged <-rbind(data_y_train,data_y_test)

#pinpoint column indexes for mean and std
mean_std_columns<-grep("-mean\\(\\)|-std\\(\\)", data_features[, 2])

#make a new data set from data_X, restricted to mean and std observations
data_X_final <- data_X_merged[, mean_std_columns]
colnames(data_X_final) <- data_features[mean_std_columns, 2]


#Use descriptive activity names to name the activities in the data set
data_activity_labels[, 2] = gsub("_", "", data_activity_labels[, 2])
data_Y_merged[,1] = data_activity_labels[data_Y_merged[,1], 2]
colnames(data_Y_merged) <- "Activity"

#Combine all data to single dataset and write to a file
finalTotalData <- cbind(data_subject_merged, data_Y_merged, data_X_final)
write.table(finalTotalData, paste0(basedir,"/finalTotalData.txt"))


#Construct and save the independent tidy data set with the averages 
#of each variable for each activity and each subject
require(data.table)
require(reshape2)
datatable<-data.table(finalTotalData)
melted<-melt(dt, id=c("SubjectID", "Activity"))
aggregated<-dcast(melted, SubjectID + Activity ~ variable, fun.aggregate=mean)

#export affregated set to both txt and csv
write.table(aggregated, paste0(basedir,"/finalAggregated.txt"))
write.csv(aggregated, paste0(basedir,"/finalAggregatedCSV.csv"))
