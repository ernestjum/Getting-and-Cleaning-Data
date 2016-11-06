setwd("./Documents")

library(plyr)
library(knitr)

filePath<-file.path("./getting_and_cleaning_data", "UCI HAR Dataset")
files<-list.files(filePath, recursive = TRUE)

## the following files are needed here

#test/subject_test.txt
#test/X_test.txt
#test/y_test.txt
#train/subject_train.txt
#train/X_train.txt
#train/y_train.txt

# read in the activity files for training and testing sets
activity_test<-read.table(file.path(filePath, "test", "Y_test.txt"), header=FALSE)
activity_train<-read.table(file.path(filePath, "train", "Y_train.txt"), header=FALSE)

# read in subject files for training and testing sets
subject_test<-read.table(file.path(filePath, "test", "subject_test.txt"), header=FALSE)
subject_train<-read.table(file.path(filePath, "train", "subject_train.txt"), header = FALSE)

# read in features for training and testinf sets
features_test<-read.table(file.path(filePath, "test", "X_test.txt"), header=FALSE)
features_train<-read.table(file.path(filePath, "train", "X_train.txt"), header=FALSE)

# Examine the structure of the data sets
S<-function(x){
  str(x)
}


# (1) Merges the training and the test sets to create one data set. 
subject_data<-rbind(subject_train, subject_test)
colnames(subject_data)<-c("subjectID")

activity_data<-rbind(activity_train, activity_test)
colnames(activity_data)<-c("activityType")

features_data<-rbind(features_train, features_test)
names_features<-read.table(file.path(filePath, "features.txt"), head=FALSE)
colnames(features_data)<-names_features$V2

#merge data sets
combined_data<-cbind(features_data,subject_data, activity_data)


# (2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# create the logical vector  which will be used for subsetting

logicalVector<-names_features$V2[grep("mean\\(\\)|std\\(\\)", names_features$V2)]

# subset the data set using the logical vector
subSet<-c(as.character(logicalVector), "subjectID", "activityType")
newData<-subset(combined_data, select = subSet)

# (3) Uses descriptive activity names to name the activities in the data set
activityLabels<-read.table(file.path(filePath, "activity_labels.txt"), header=FALSE)

newData$activityType <- factor(newData$activityType,levels = c(1,2,3, 4,5,6), 
                               labels = c("Walking", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", 
                                          "SITTING", " STANDING", "LAYING"))

# (4)Appropriately labels the data set with descriptive variable names. 
names(newData)<-gsub("^t", "time", names(newData))
names(newData)<-gsub("^f", "Frequency", names(newData))
names(newData)<-gsub("Acc", "Accelerometer", names(newData))
names(newData)<-gsub("Gyro", "Gyroscope", names(newData))
names(newData)<-gsub("Mag", "Magnitude", names(newData))
names(newData)<-gsub("BodyBody", "Body", names(newData))
names(newData)<-gsub("-mean", "Mean", names(newData))
names(newData)<-gsub("-std", "Std", names(newData))



# (5)  Independent tidy data set with the average of each variable for each activity and each subject.
final_data_set<-aggregate(.~subjectID+activityType, newData, mean)
final_data_set<-final_data_set[order(final_data_set$subjectID, final_data_set$activityType), ]


write.table(final_data_set, file = "./getting_and_cleaning_data/cleanDataSet.txt", row=FALSE)
write.table(final_data_set, file = "./getting_and_cleaning_data/cleanDataSet.csv", row=FALSE)

