# CODE BOOK OF THE COURSERA DATA PROJECT

# SHORT DESCRIPTION OF THE AIM

This Code Book serves to describe the main steps and processes that were conducted in the script calles `run_analysis.R` as a part of the Final Assignment within the course Getting and Cleaning Data.

# DATA DESCRIPTION
Data set contains information about three groups of data and activity_labels as well. The data could be devided into 3 groups as mentioned as follows:

* `Activity`: Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* `Subject`: Volunteers that performed the activity within an age bracket of 19-48 years (ID from 1 to 30)
* `Features`:
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ).
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
   * `tBodyAcc-XYZ`
   * `tGravityAcc-XYZ`
   * `tBodyAccJerk-XYZ`
   * `tBodyGyro-XYZ`
   * `tBodyGyroJerk-XYZ`
   * `tBodyAccMag`
   * `tGravityAccMag`
   * `tBodyAccJerkMag`
   * `tBodyGyroMag`
   * `tBodyGyroJerkMag`
   * `fBodyAcc-XYZ`
   * `fBodyAccJerk-XYZ`
   * `fBodyGyro-XYZ`
   * `fBodyAccMag`
   * `fBodyAccJerkMag`
   * `fBodyGyroMag`
   * `fBodyGyroJerkMag`

For the puproses of our project we will concentrate only on the 2 set of variables that were estimated from these signals: 
`mean()`: Mean value
`std()`: Standard deviation

Based on the information before, we can split the files into three groups:
* `Activity`: `Y_trains.txt`, `Y_test.txt`              
* `Subject`: `subject_train.txt`, `subject_test.txt`    
* `Features`: `X_train.txt`, `X_test.txt`

# DOWNLOADING AND READING DATA as the first part of the script

The data was download from the following web: 
`https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`through `fileUrl` function and subsequently unzipped.
Reading the Activity, Subject and Features Data with `read.table()` function.

# PROCESSING THE DATA as the second part of the script

`library(plyr)`
1. Merges the training and the test sets to create one data set.
 a) Joing together all variables that belong together based on the rows binding, i.e., `Activity`, `Subject`, `Features`
 b) To add a corresponding name to the group of data
 c) To merge all relevant columns together into one data set
2. Extracts only the measurements on the `mean` and `standard deviation` for each measurement.
 a) As we are interested only in the mean and standard deviation, we subset only the relevant names of features
 b) Subsetting the data table by the relevant/selected names of features
 c) Find out the structure of the newly-created data frame
3. Uses descriptive activity names to name the activities in the data set
 a) As the file `activity_labels.txt` includes descriptive activity names, we read it into R
 b) Changing the variable Activity into factor format using descriptive activity names
 c) Check for the factor variable
4. Appropriately labels the data set with descriptive variable names.
 a) Attribute with descriptive variable names with `for()` function
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 a) To compute the mean for both subject and activity variable
 b) Create the tidy data
6. To look at the tidy data we can see the following names of the columns:
*`Subject` 
*`Activity` 
*`TimeBodyAccelerometer-Mean()-X` 
*`TimeBodyAccelerometer-Mean()-Y` 
*`TimeBodyAccelerometer-Mean()-Z` 
*`TimeBodyAccelerometer-STD()-X` 
*`TimeBodyAccelerometer-STD()-Y` 
*`TimeBodyAccelerometer-STD()-Z` 
*`TimeGravityAccelerometer-Mean()-X` 
*`TimeGravityAccelerometer-Mean()-Y` 
*`TimeGravityAccelerometer-Mean()-Z` 
*`TimeGravityAccelerometer-STD()-X` 
*`TimeGravityAccelerometer-STD()-Y` 
*`TimeGravityAccelerometer-STD()-Z` 
*`TimeBodyAccelerometerJerk-Mean()-X` 
*`TimeBodyAccelerometerJerk-Mean()-Y` 
*`TimeBodyAccelerometerJerk-Mean()-Z` 
*`TimeBodyAccelerometerJerk-STD()-X` 
*`TimeBodyAccelerometerJerk-STD()-Y` 
*`TimeBodyAccelerometerJerk-STD()-Z` 
*`...`
