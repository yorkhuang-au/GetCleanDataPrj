# Course Project 2
## Tasks
The script run_analysis.R is the R script for course project 2. It implements the following steps.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Implementation

* The data\_dir variable has the root directory of the input dataset. One can change data_dir to suit the actual data folder.
* It first reads in all the datasets except those in the folder "Inertial Signals" because data in this folder will be excluded from the
final dataset anyway.
* Function cbind() is used to bind the subject, activity and feature dataset for train and test data respectively. Then function
rbind() is used to combined the train and test datasets.
* Regular expression "mean[(][)]|std[(][)]" is used to extract features that contain either "mean()" or "std()".
This regular expression can be changed to add or remove selected features.
* Function merge() is used to join main data frame with the activity label data frame on the activity_id column.
* Function names() is used to assign the proper names for every variables. Note that "[]" is removed from the variable names.
* Function aggregate() is used to split the dataset by subject and activity, and then carry out mean() on every variables
except subject, activity_id and activity.