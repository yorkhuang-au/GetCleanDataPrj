
##
##  Read all files
##
data_dir <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/"

# Read train data
subject_train <- read.table(paste(data_dir, "train/subject_train.txt", sep="")
                            , header=FALSE)
y_train <- read.table(paste(data_dir, "train/y_train.txt", sep="")
                      , header=FALSE)
x_train <- read.table(paste(data_dir, "train/X_train.txt", sep="")
                      , header=FALSE)
# Read test data
subject_test <- read.table(paste(data_dir, "test/subject_test.txt", sep="")
                           , header=FALSE)
y_test <- read.table(paste(data_dir, "test/y_test.txt", sep="")
                     , header=FALSE)
x_test <- read.table(paste(data_dir, "test/X_test.txt", sep="")
                     , header=FALSE)

# Read meta data
activity_labels <- read.table(paste(data_dir, "activity_labels.txt", sep="")
                              , header=FALSE
                              , col.names = c("activity_id","activity")
                              , as.is = c("activity_id","activity"))
features <- read.table(paste(data_dir, "features.txt", sep="")
                       , header=FALSE
                       , col.names=c("id","name")
                       , as.is=c("id","name"))

##
##Step 1 - Merges the training and the test sets to create one data set.
##
dall <- rbind(cbind(subject_train, y_train, x_train)
          , cbind(subject_test, y_test, x_test))

##
##Step 2 - Extracts only the measurements on the mean and standard deviation 
##         for each measurement. 
## Only extract features which has mean() or std() in its label. This can be
## changed to add or remove features by modifying the regular expression in
## the grepl function.

selected_cols <- grepl("mean[(][)]|std[(][)]", features$name)

# The 1st and the 2nd columns are subject and activity_id
dsel <- dall[, c(TRUE,TRUE,selected_cols)]

##
##Step 3 - Uses descriptive activity names to name the activities in the data 
## set
##
dlbl <- merge(dsel, activity_labels, by.x=2, by.y=1 )

##
##Step 4 - Appropriately labels the data set with descriptive variable names. 
##
names(dlbl) <- c("activity_id", "subject",
                          gsub("[(][)]", "", features[selected_cols,"name"])
                 , "activity")

##
##Step 5 - creates a second, independent tidy data set with the average of each 
## variable for each activity and each subject.
##
dmean <- with(dlbl, aggregate( 
  dlbl[, !names(dlbl) %in% c("subject","activity","activity_id")], 
  list(subject=subject, activity=activity), mean))


write.table(format(dmean, scientific=TRUE), file="tidy_data.txt"
            , row.names=FALSE, quote=FALSE)


