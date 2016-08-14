# COURSE PROJECT 

# SHORT DESCRIPTION OF THE AIM

This Code Book serves to describe the main steps and processes that were conducted in the script calles `run_analysis.R` as a part of the Final Assignment within the course Getting and Cleaning Data.

# DOWNLOADING AND READING DATA as the first part of the script

The data was download from the following web: 
`https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`through `fileUrl` function and subsequently unzipped.
Reading the Activity, Subject and Features Data with `read.table()` function.
* `Y_trains.txt`
* `Y_test.txt`
* `subject_train.txt`
* `subject_test.txt`
* `X_train.txt`
* `X_test.txt`

# PROCESSING THE DATA as the second part of the script

`library(plyr)`
`library(knitr)`
`library(markdown)`

1. Merges the training and the test sets to create one data set.
 * Joing together all variables that belong together based on the rows binding, i.e., `Activity`, `Subject`, `Features`
 * To add a corresponding name to the group of data
 * To merge all relevant columns together into one data set by row binding
 
2. Extracts only the measurements on the `mean` and `standard deviation` for each measurement.
 * As we are interested only in the mean and standard deviation, we subset only the relevant names of features
 * Subsetting the data table by the relevant/selected names of features
 * Find out the structure of the newly-created data frame
 
3. Uses descriptive activity names to name the activities in the data set
 * As the file `activity_labels.txt` includes descriptive activity names, we read it into R
 * Changing the variable Activity into factor format using descriptive activity names
 * Check for the factor variable
 
4. Appropriately labels the data set with descriptive variable names.
 * Attribute with descriptive variable names with `for()` function
 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 * Computing the mean for both `Subject` and `Activity` variable
 * Create the tidy data with the name `Mytidydata.txt`

This repository contains the following files:
* `CodeBook.md`: information about data and variable description and tidy data structure
* `README.md`: this file containing information about how all of the scripts work and how they are connected
* `run_analysis.R`: the R script of the project