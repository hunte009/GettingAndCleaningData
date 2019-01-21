library(dplyr)
setwd("C:/Users/User/Documents/coursera/Getting and Cleaning Data")
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
## 1) Merges the training and the test sets to create one data set.
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(subject, y, x)
## 2) Extracts only the measurements on the mean and standard deviation 
## for each measurement.
## find all columns containing mean
meancol <- grep("mean",names(Merged_Data))
## find all columns containing std
stdcol <- grep("std",names((Merged_Data)))
## combine mean and std and add columns 1 and 2 containing subject and code
totallist <- c(1,2,meancol,stdcol)
## sort the columns to have the same order as in the original Merged_Data
totallist <- sort(totallist)
## put selected columns in df
df <- Merged_Data[totallist]
## 3) Uses descriptive activity names to name the activities in the data set.
df$code <- activities[df$code, 2]
## 4) Appropriately labels the data set with descriptive variable names.
names(df)[2] = "Activity"
names(df)<-gsub("...X", ".X", names(df),fixed=TRUE)
names(df)<-gsub("...Y", ".Y", names(df),fixed=TRUE)
names(df)<-gsub("...Z", ".Z", names(df),fixed=TRUE)
names(df)<-gsub("mean..", "mean", names(df),fixed=TRUE)
names(df)<-gsub("Freq..", "Freq", names(df),fixed=TRUE)
names(df)<-gsub("std..", "std", names(df),fixed=TRUE)
names(df)<-gsub("gravity", "Gravity", names(df), ignore.case = TRUE)
names(df)<-gsub("Acc", "Accelerometer", names(df), ignore.case = TRUE)
names(df)<-gsub("Gyro", "Gyroscope", names(df), ignore.case = TRUE)
names(df)<-gsub("BodyBody", "Body", names(df), ignore.case = TRUE)
names(df)<-gsub("Mag", "Magnitude", names(df), ignore.case = TRUE)
names(df)<-gsub("^t", "Time", names(df), ignore.case = TRUE)
names(df)<-gsub("^f", "Frequency", names(df), ignore.case = TRUE)
## 5) From the data set in step 4, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject.
df2 <- group_by(df, subject, Activity)
df2 <- summarise_all(df2, funs(mean))
write.table(df2, file = "df2.txt", row.names = TRUE)
