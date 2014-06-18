basedir<-"C:/me/git/UCI HAR Dataset"

data_subject_test <- read.table(paste0(basedir,"/test/subject_test.txt"), quote="\"")
data_X_test <- read.table(paste0(basedir,"/test/X_test.txt"), quote="\"")
data_y_test <- read.table(paste0(basedir,"/test/y_test.txt"), quote="\"")
data_subject_train <- read.table(paste0(basedir,"/train/subject_train.txt"), quote="\"")
data_X_train <- read.table(paste0(basedir,"/train/X_train.txt"), quote="\"")
data_y_train <- read.table(paste0(basedir,"/train/y_train.txt"), quote="\"")

features <- read.table(paste0(basedir,"/features.txt"), quote="\"")
activity_labels <- read.table(paste0(basedir,"/activity_labels.txt"), quote="\"")