# Data Set Codebook: Getting and Cleaning Data Course Project
## Prepared by Paul H


###Summary
Data from the embedded accelerometer and gyroscope of a Samsung Galaxy S was collected on 30 volunteers wearing the device. The data was collected during six activities: WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, and LAYING. Seventy percent of the volunteers were used for generating training data and 30% for testing. 561 attributes were generated for each activity. 

A description of the experiment and data collected can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#’  

The data for the course project was provided as a zip file available from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

####Files included with the zip:  
* README.txt - Brief overview of the data collection process and data collected 
* Features_info.txt - Brief description of the features vector variables  
*  __The following files were used to build the dataset:__    
+ Activity_labels.txt – the six activities and numeric key(1-6)  
+ Features.txt – list of 561 attributes and numeric key(1-561)  
+ Subject_train.txt - Human subjects key corresponding to rows in X_train.txt for the thirty subjects (1 - 30)
+ X_train.txt -Training set of 561 attributes
+ y_train.txt  Training activities numeric key corresponding to rows in X_train.txt
+ Subject_test.txt  Human subjects numeric key corresponding to rows in X_test.txt
+ X_test.txt  Test set of 561 attributes .
+ y_test.txt Test activities numeric key corresponding to rows in X_test.txt


 The training and test datasets were combined into one dataset and the attributes filtered to 66 that had “mean” or “std” (standard deviation) in the attribute name. Further information on the procedure (run_analysis.R) is provided in the Readme  document. 

#### The tidy data set   

The tidy data set is 180 rows x 68 columns. Cols 1 and 2 are the Subject and Activity Name, respectively. The remaining 66 columns were selected from the original 561 columns to include only those columns dealing with mean”or std dev.”The rows correspond to the 30 subjects x 6 activities  (180 rows) with the data for each subject-attribute pair averaged over the respective activity. Frequency domain signals are denotd by attribute names beginning with 'f'. 


###Tidy Data Set variables

The data generated from the orginal experiment can be roughly divided into body and gravity accleration signals along the x, y, and z directions. These attributes are denoted by 'ACC' in the attribute name. Other derived attributes are denoted by 'Jerk' for a jerk movement, 'Gyro' for angular velocity and 'Mag' for magnitude.

 
* Subject - Subject number (1 - 30)
* Activity - Names for the six activities( WALKING, WALKING UPSTAIRS, WALKING  \n DOWNSTAIRS, SITTING, STANDING, and LAYING)

* tBodyAcc-mean()-X  
* tBodyAcc-mean()-Y  
* tBodyAcc-mean()-Z  
* tBodyAcc-std()-X  
* tBodyAcc-std()-Y  
* tBodyAcc-std()-Z  

* tGravityAcc-mean()-X  
* tGravityAcc-mean()-Y    
* tGravityAcc-mean()-Z  
* tGravityAcc-std()-X  
* tGravityAcc-std()-Y  
* tGravityAcc-std()-Z  

* tBodyAccJerk-mean()-X  
* tBodyAccJerk-mean()-Y  
* tBodyAccJerk-mean()-Z  
* tBodyAccJerk-std()-X  
* tBodyAccJerk-std()-Y    
* tBodyAccJerk-std()-Z  

* tBodyGyro-mean()-X
* tBodyGyro-mean()-Y
* tBodyGyro-mean()-Z
* tBodyGyro-std()-X
* tBodyGyro-std()-Y
* tBodyGyro-std()-Z

* tBodyGyroJerk-mean()-X
* tBodyGyroJerk-mean()-Y
* tBodyGyroJerk-mean()-Z
* tBodyGyroJerk-std()-X
* tBodyGyroJerk-std()-Y
* tBodyGyroJerk-std()-Z

* tBodyAccMag-mean()
* tBodyAccMag-std()
* tGravityAccMag-mean()
* tGravityAccMag-std()

* tBodyAccJerkMag-mean()
* tBodyAccJerkMag-std()
* tBodyGyroMag-mean()
* tBodyGyroMag-std()
* tBodyGyroJerkMag-mean()
* tBodyGyroJerkMag-std()

* fBodyAcc-mean()-X
* fBodyAcc-mean()-Y
* fBodyAcc-mean()-Z
* fBodyAcc-std()-X
* fBodyAcc-std()-Y
* fBodyAcc-std()-Z

* fBodyAccJerk-mean()-X
* fBodyAccJerk-mean()-Y
* fBodyAccJerk-mean()-Z
* fBodyAccJerk-std()-X
* fBodyAccJerk-std()-Y
* fBodyAccJerk-std()-Z

* fBodyGyro-mean()-X
* fBodyGyro-mean()-Y
* fBodyGyro-mean()-Z
* fBodyGyro-std()-X
* fBodyGyro-std()-Y
* fBodyGyro-std()-Z

* fBodyAccMag-mean()
* fBodyAccMag-std()

* fBodyBodyAccJerkMag-mean()
* fBodyBodyAccJerkMag-std()
* fBodyBodyGyroMag-mean()
* fBodyBodyGyroMag-std()
* fBodyBodyGyroJerkMag-mean()
* fBodyBodyGyroJerkMag-std()
