# Getting and Cleaning Data in R: Week 4 Project
Author: S. Geller

*Description*\
This codebook contains additional information about the variables, data and transformations used in this course project.

*Source Data*\
Data and a description can be found here [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


### Data Set Information (per UCI website)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Attribute Information
For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment. 

### The provided dataset included the following files:
- 'README.txt'
- 'activity_labels.txt': Links the class labels with their activity name
- 'features.txt': List of all features
- 'features_info.txt': Information about the variables used on the feature vector
- 'train/X_train.txt': Training set
- 'train/y_train.txt': Training labels
- 'test/X_test.txt': Test set
- 'test/y_test.txt': Test labels

The following files are available for the both train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

### The goals of this project are to create an R script that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Walkthrough of process
The installation and getting data uses techniques taught with `download.file` and reading data with `fread`. 
The the activity labels and features text file are loaded and column names are assigned.
The mean and standard deviation features are filtered out with `grep`. A measurements variable is created, which contains the variable names to be labeled, and tidys the name with `gsub`.   
With the column indexes containing mean and std, the train and test set files can be loaded. 
The train and test files are then merged with 'rbind'.

With a merged data set, the crucial part comes where we have to create an new data set with the average of each variable for each activity and each subject. 
To do that we first have to convert the variables in the `Activity` and `Subject_Num` columns into factors. 
Then we can utilize reshape library to `melt` and `cast` the variables, in order to get the mean. 
Finally the tidy and clean dataset is written into a new file.


#### Descriptive names given for labels 
* "t" = "Time"
* "f" = "Frequency"
* "Acc" = "Accelerometer"
* "Gyro" = "Gyroscope"
* "Mag" = "Magnitude"
* "BodyBody" = "Body"
* "()" = "" 
