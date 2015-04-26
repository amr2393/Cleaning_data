library(stringr)
library(tidyr)
library(dplyr)

#Check if the zipfile containing the raw data is present and download it if this is not the case.
if (!file.exists("cleandata.zip")) {
  download.file(
    url  = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
    destfile = "cleandata.zip",
    meth = "curl",
    mode = "wb"
  )
  
  #Unzip the zipfile into the working directory.
  unzip("cleandata.zip")
}

# Load all the data
features = read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

x.train = read.table("./UCI HAR Dataset/train/X_train.txt")
y.train = read.table("./UCI HAR Dataset/train/y_train.txt")
subj.train = read.table("./UCI HAR Dataset/train/subject_train.txt")

x.test = read.table("./UCI HAR Dataset/test/X_test.txt")
y.test = read.table("./UCI HAR Dataset/test/y_test.txt")
subj.test = read.table("./UCI HAR Dataset/test/subject_test.txt")

# Combine all the data
dataset = rbind(
    cbind(subj.train, x.train, y.train),
    cbind(subj.test, x.test, y.test)
  )
colnames(dataset) = c('Subject', features$V2, 'ActivityID')

# Filter columns down to mean/std dev related ones
keep.ix = grepl("mean|std|Subject|ActivityID", colnames(dataset)) &
  !grepl("meanFreq", colnames(dataset))
dataset = dataset[, keep.ix]

# Rename activities
activity.names = read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
colnames(activity.names) = c("ActivityID", "Activity") 
dataset = merge(dataset, activity.names, by = "ActivityID")
# Reorder columns and drop activity ID
dataset = dataset[, c("Subject", "Activity", colnames(dataset)[!grepl("Subject|Activity", colnames(dataset))])]

# Clean up names
tmp.names = colnames(dataset)

tmp.names = str_replace_all(tmp.names, "Acc", "-acceleration-")
tmp.names = str_replace_all(tmp.names, "Gyro", "-gyroscope-")
tmp.names = str_replace_all(tmp.names, "Mag", "-magnitude")
tmp.names = str_replace_all(tmp.names, "\\(\\)", "")
tmp.names = str_replace_all(tmp.names, "^t", "time-")
tmp.names = str_replace_all(tmp.names, "^f", "frequency-")
tmp.names = str_replace_all(tmp.names, "tBody", "time-body-")
tmp.names = str_replace_all(tmp.names, "BodyBody", "body")
tmp.names = str_replace_all(tmp.names, "--", "-")

tmp.names = tolower(tmp.names)

colnames(dataset) = tmp.names

# Collapse columns to key-value pairs (keys: subject, activity, sensor) 
dataset = dataset %>% gather(sensor, value, -(1:2))

# Compute mean per subject, per activity, per sensor
dataset = dataset %>% group_by(subject, activity, sensor) %>%
  summarise(mean(value))

# Write out tidy data set to a .txt file.
write.table(dataset, "tidy_data.txt", row.name = FALSE)
