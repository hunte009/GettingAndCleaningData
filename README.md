# Machine-Learning
The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set.

The dataset is available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

I have created one R script in R Version 1.1.456 called run_analysis.R that does the following.

1) Merges the training and the test sets to create one data set.
  Firstly I import the features, subject_test, test and train data for both x an y into a descriptive variable.
  Then I bind the test and train x, y and subject data together by row before I combine them all into into a dataframe by column.
  
2) Extracts only the measurements on the mean and standard deviation for each measurement.
  Find those measurements containing "mean" and "std", storing them in a list. In the resulting dataframe we need columns 1 and 
  2 containing subject and code. In order to maintain some kind of order resembling the original data, I have combined and sorted the
  lists containing the two terms.  

3) Uses descriptive activity names to name the activities in the data set
  I have used the names of the activities in activity_labels.txt to substitute the activity codes in column 2.

4) Appropriately labels the data set with descriptive variable names.
  Label column 2 "Activity"
  Replace "...X" with ".X"
  Replace "...Y" with ".Y"
  Replace "...Z" with ".Z"
  Replace "mean.." with "mean"
  Replace "Freq.." with "Freq"
  Replace "std.." with "std"
  Replace "gravity" with "Gravity"
  Replace "Acc" with "Accelerometer"
  Replace "Gyro" with "Gyroscope"
  Replace "BodyBody" with "Body"
  Replace "Mag" with "Magnitude"
  Replace "^t" with "Time", names(df)
  Replace "^f" with "Frequency"
  
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  Firstly I group all data by "Activity" and then summarise and calculate the mean for the different groups. The result is stored in df2.
  
Finally I have exported df2 to df2.txt using write.table() with row.name=FALSE.
