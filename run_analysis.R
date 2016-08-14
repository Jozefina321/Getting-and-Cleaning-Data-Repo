#################################################################################################################################
# GETTING AND CLEANING DATA FINAL COURSE ASSIGNMENT
#################################################################################################################################

# This script with the name "run_analysis.R" follows the instructions for the Getting and Cleaning Data Course Project with the following structure:
# The first part of the script deals with the sourcing, preparing and getting know the data that are meant for the analysis.
# The second part deals with the requirements of the course project as follows:
#       1. Merges the training and the test sets to create one data set.
#       2. Extracts only the measurements on the mean and standard deviation for each measurement.
#       3. Uses descriptive activity names to name the activities in the data set
#       4. Appropriately labels the data set with descriptive variable names.
#       5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#################################################################################################################################

## THE FIRST PART

# 1.Download data from the web and store the data into data folder if it exists
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# 2.Unzip the file into data folder as well
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# 3.According to the data set information we have 3 groups of data: Activity, Subject and Features.
#   Read the data into R through the function read.table()

#Activity
Y_train <- read.table('./data/UCI HAR Dataset/train/y_train.txt',header = FALSE)
Y_test <- read.table('./data/UCI HAR Dataset/test/Y_test.txt', header = FALSE)

#Subject
subject_train <- read.table('./data/UCI HAR Dataset/train/subject_train.txt', header = FALSE)
subject_test <- read.table('./data/UCI HAR Dataset/test/subject_test.txt', header = FALSE)

#Features
features <- read.table('./data/UCI HAR Dataset/features.txt',header = FALSE)
X_train <- read.table('./data/UCI HAR Dataset/train/X_train.txt',header = FALSE)
X_test <- read.table('./data/UCI HAR Dataset/test/X_test.txt', header = FALSE)

# 4. Exploring the structure of the data
        # For example data set X_test
head(X_test, n=10)
tail(X_test, n=10)
str(X_test)
names(X_test)

#################################################################################################################################

## THE SECOND PART

# 1.Merges the training and the test sets to create one data set.
        # Joing together all variables that belong together based on the rows binding, i.e., Activity, Subject, Features
ActivityData <- rbind(Y_train, Y_test)
SubjectData <- rbind(subject_train, subject_test)
FeaturesData <- rbind (X_train, X_test)
head(FeaturesData, n=10)
        # To add a corresponding name to the group of data
names(ActivityData) <- c("Activity")
names(SubjectData) <- c("Subject")
names(FeaturesData) <- features$V2
        # To merge all relevant columns together into one data set
MergedData <- cbind(ActivityData, SubjectData)
OneData <- cbind(FeaturesData, MergedData)
View(OneData)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
        # As we are interested only in the mean and standard deviation, we subset only the relevant names of features
subsetData <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
        # Subsetting the data table by the relevant/selected names of features
selectedFNames<-c(as.character(subsetData), "Subject", "Activity" )
OneData<-subset(OneData,select=selectedFNames)
        # Find out the structure of the newly-created data frame
dim(OneData)

# 3.Uses descriptive activity names to name the activities in the data set
        # As the file “activity_labels.txt” includes descriptive activity names, we read it into R
activityLabels <- read.table('./data/UCI HAR Dataset/activity_labels.txt',header = FALSE)
        # Changing the variable Activity into factor format using descriptive activity names
OneData$Activity <- as.character(OneData$Activity)
for (i in 1:6){
        OneData$Activity[OneData$Activity == i] <- as.character(activityLabels[i,2])
}
OneData$Activity <- as.factor(OneData$Activity)
        # Check for the factor variable
head(OneData$Activity,10)
tail(OneData$Activity,10)

# 4.Appropriately labels the data set with descriptive variable names.
colNames  = colnames(OneData)
for (i in 1:length(colNames)) 
{
        colNames[i] = gsub("std","STD",colNames[i])
        colNames[i] = gsub("mean","Mean",colNames[i])
        colNames[i] = gsub("^(t)","Time",colNames[i])
        colNames[i] = gsub("^(f)","Frequency",colNames[i])
        colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
        colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
        colNames[i] = gsub("[Gg]yro","Gyroscope",colNames[i])
        colNames[i] = gsub("Acc","Accelerometer",colNames[i])
}
colnames(OneData) = colNames
names(OneData)

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
install.packages("plyr") # in the case that you have not installed yet
library(plyr)
OneData2<-aggregate(. ~Subject + Activity, OneData, mean)
OneData2<-OneData2[order(OneData2$Subject,OneData2$Activity),]
write.table(OneData2, file = "Mytidydata.txt",row.name=FALSE)

# To look at the tidy data
tidydata <- read.table('./data/UCI HAR Dataset/Mytidydata.txt', header = TRUE)
View(tidydata)
str(tidydata)
names(tidydata)