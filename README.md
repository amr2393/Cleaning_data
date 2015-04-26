# Readme for Getting and Cleaning Data Course Project


## Project Description
In this project, raw data from the UCI machine learning repository was transformed into a clean data file that follows the [principles of tidy data](http://vita.had.co.nz/papers/tidy-data.pdf).

To do this a R script called run_analysis.R was created that does the following:
 0. Checks if the data is present and downloads it if this is not the case.
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for 
    each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data 
    set with the average of each variable for each activity and each subject.

## Data gathering
### Source data
The UCI HAR Data set can be downloaded from [this web page](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
    or directly from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

###Collection of the raw data [1]
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained data set has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: [Web Link](https://www.youtube.com/watch?v=XOEN9W05_4A)

###Attribute information [1]
For each record in the data set it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Data processing
Data processing took place using the run_analysis script. This script takes the raw data and transforms it into a single tidy data set. In this section the code of this script is described.

#### Step 1
The first step is to load necessary libraries. We then check to see if the data is present in the local directory and download it if not.
```r
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
```

##### Step 2
Here we load the various datasets and join them into one complete set.
```r
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
```

#### Step 3
Here we subset the data to the relevant columns and rename them to have more understandable names.
```r
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
```

#### Step 4
Finally we map the data to a set of key value pairs, keyed by subject, activity, and sensor. We calculate the mean per key and write to an output file.
```r
# Collapse columns to key-value pairs (keys: subject, activity, sensor) 
dataset = dataset %>% gather(sensor, value, -(1:2))

# Compute mean per subject, per activity, per sensor
dataset = dataset %>% group_by(subject, activity, sensor) %>%
  summarise(mean(value))

# Write out tidy data set to a .txt file.
write.table(dataset, "tidy_data.txt", row.name = FALSE)
```


#Tidy data file
The result of the data processing were saved in a separate text file (tidy_data.txt). The result consists of 4 variables and 11880 rows. The variables used in the tidy file are the following:


```
## [1] "subject"  "activity" "sensor"   "value"
```

All variables are detailed described in the [Code Book.md](https://github.com/JorisSchut/Data-Science/blob/master/Cleaning/wk3/Codebook.md). Please refer to this document for a more detailed explanation of the variables.

##Sources
1. [UCI Machine learning repostiory](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
