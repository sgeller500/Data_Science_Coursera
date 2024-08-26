##Project Goals:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
  # measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
  # with the average of each variable for each activity and each subject.



# Load Packages
library(data.table)
library(reshape2)


# Get the Data
path <- getwd()
FileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(FileURL, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")



# Load activity labels and features files; assign column names
activity_labels <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt")
                         , col.names = c("classLabels", "activityName"))
features <- fread(file.path(path, "UCI HAR Dataset/features.txt")
                  , col.names = c("index", "featureNames"))


# Extract mean and standard deviation
# Add descriptive variable names 
features_want <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[features_want, featureNames]
measurements <- gsub('[()]', '', measurements)
measurements <- gsub('^t', 'Time', measurements)
measurements <- gsub('^f', 'Frequency', measurements)
measurements <- gsub('Acc', 'Accelerometer', measurements)
measurements <- gsub('Gyro', 'Gyroscope', measurements)
measurements <- gsub('Mag', 'Magnitude', measurements)
measurements <- gsub('BodyBody', 'Body', measurements)
measurements <- gsub('()', "", measurements)



# Load data files, filter based on features_want while retaining data.frame class
train <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, features_want, with = FALSE]
setnames(train, colnames(train), measurements) 

train_activities <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt")
                         , col.names = c("Activity"))
train_subjects <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt")
                        , col.names = c("Subject_Num"))
training <- cbind(train_subjects, train_activities, train)


test <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, features_want, with = FALSE]
setnames(test, colnames(test), measurements)
test_activities <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt")
                         , col.names = c("Activity"))
test_subjects <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt")
                       , col.names = c("Subject_Num"))
testing <- cbind(test_subjects, test_activities, test)


# Merge test and train data sets
mergedDT <- rbind(training,testing)


# Convert classLabels to Activity Name
mergedDT[["Activity"]] <- factor(mergedDT[, Activity]
                                  , levels = activity_labels[["classLabels"]]
                                  , labels = activity_labels[["activityName"]])


# Turn Subject_Num into factors
mergedDT[["Subject_Num"]] <- as.factor(mergedDT[, Subject_Num])


# melt and cast the data table
mergedDT <- melt.data.table(mergedDT, id=c("Subject_Num", "Activity")) 
mergedDT <- dcast(mergedDT, Subject_Num + Activity ~ variable, mean) 


# Write final tidy data into new file
fwrite(mergedDT, file="tidyData.txt")


