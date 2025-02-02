# Codebook for Getting and Cleaning Data Course Project

## Project Description
In this project, raw data from the UCI machine learning repository was transformed into a clean data file.

To do this a R script called run_analysis.R was created that does the following:
 0. Checks if the data is present and downloads it if this is not the case.
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for 
    each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data 
    set with the average of each variable for each activity and each subject.

##Study design and data processing

###Collection of the raw data
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained data set has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: [Web Link](https://www.youtube.com/watch?v=XOEN9W05_4A)

###Notes on the original (raw) data 
 The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

##Creating the tidy datafile

###Guide to create the tidy data file
 1. Download the data file from the UCI Machine Learning repository at [this web page](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
    or directly from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into the folder the run_analysis.R script is located.
 2. Set the working directory to this directory.
 3. Run the run_analysis script.

###Cleaning of the data
Cleaning the raw data took place using the run_analysis.R script. This scrip performs the following steps:

 0. Checks if the data set is present. If this is not the case it downloads the data set.
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements of the mean and standard deviation for 
    each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data 
    set with the average of each variable for each activity and each subject.

For an explanation of the code used in the data processing see the [Readme.md](https://github.com/amr2393/Cleaning_data/blob/master/README.md) file accompanying this code book.

##Description of the variables in the tiny_data.txt file


```
## [1] "Dimensions of the tidy dataset (rows, columns):"
```

```
## [1] 11880     4
```

```
## [1] "Summary of the tidy dataset:"
```

```
##     subject                   activity   
##  Min.   : 1.0   LAYING            :1980  
##  1st Qu.: 8.0   SITTING           :1980  
##  Median :15.5   STANDING          :1980  
##  Mean   :15.5   WALKING           :1980  
##  3rd Qu.:23.0   WALKING_DOWNSTAIRS:1980  
##  Max.   :30.0   WALKING_UPSTAIRS  :1980  
##                                          
##                                              sensor     
##  frequency-body-acceleration-jerk-magnitude-mean:  180  
##  frequency-body-acceleration-jerk-magnitude-std :  180  
##  frequency-body-acceleration-jerk-mean-x        :  180  
##  frequency-body-acceleration-jerk-mean-y        :  180  
##  frequency-body-acceleration-jerk-mean-z        :  180  
##  frequency-body-acceleration-jerk-std-x         :  180  
##  (Other)                                        :10800  
##      value         
##  Min.   :-0.99767  
##  1st Qu.:-0.96205  
##  Median :-0.46989  
##  Mean   :-0.48436  
##  3rd Qu.:-0.07836  
##  Max.   : 0.97451  
## 
```

```
## [1] "Variables in the data set:"
```

```
## [1] "subject"  "activity" "Sensor"   "value"
```

###Subject
The subject variable contains information about the subject which the data was taken from.


```
## [1] "Class of the subject variable:"
```

```
## [1] "integer"
```

```
## [1] "Values of the subject variable:"
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
## [24] 24 25 26 27 28 29 30
```

Unit of measurement: - (none)

###Activity
The activity variable contains information about the activity that took place during the measurement.


```
## [1] "Class of the activity variable:"
```

```
## [1] "factor"
```

```
## [1] "Values of the activity variable:"
```

```
## [1] "LAYING"             "SITTING"            "STANDING"          
## [4] "WALKING"            "WALKING_DOWNSTAIRS" "WALKING_UPSTAIRS"
```

Unit of measurement: - (none)

###Sensor
The sensor variable contains information about the sensor that took the measurement.


```
## [1] "Class of the sensor variable:"
```

```
## [1] "factor"
```

```
## [1] "Values of the sensor variable:"
```

```
##  [1] "frequency-body-acceleration-jerk-magnitude-mean"
##  [2] "frequency-body-acceleration-jerk-magnitude-std" 
##  [3] "frequency-body-acceleration-jerk-mean-x"        
##  [4] "frequency-body-acceleration-jerk-mean-y"        
##  [5] "frequency-body-acceleration-jerk-mean-z"        
##  [6] "frequency-body-acceleration-jerk-std-x"         
##  [7] "frequency-body-acceleration-jerk-std-y"         
##  [8] "frequency-body-acceleration-jerk-std-z"         
##  [9] "frequency-body-acceleration-magnitude-mean"     
## [10] "frequency-body-acceleration-magnitude-std"      
## [11] "frequency-body-acceleration-mean-x"             
## [12] "frequency-body-acceleration-mean-y"             
## [13] "frequency-body-acceleration-mean-z"             
## [14] "frequency-body-acceleration-std-x"              
## [15] "frequency-body-acceleration-std-y"              
## [16] "frequency-body-acceleration-std-z"              
## [17] "frequency-body-gyroscope-jerk-magnitude-mean"   
## [18] "frequency-body-gyroscope-jerk-magnitude-std"    
## [19] "frequency-body-gyroscope-magnitude-mean"        
## [20] "frequency-body-gyroscope-magnitude-std"         
## [21] "frequency-body-gyroscope-mean-x"                
## [22] "frequency-body-gyroscope-mean-y"                
## [23] "frequency-body-gyroscope-mean-z"                
## [24] "frequency-body-gyroscope-std-x"                 
## [25] "frequency-body-gyroscope-std-y"                 
## [26] "frequency-body-gyroscope-std-z"                 
## [27] "time-body-acceleration-jerk-magnitude-mean"     
## [28] "time-body-acceleration-jerk-magnitude-std"      
## [29] "time-body-acceleration-jerk-mean-x"             
## [30] "time-body-acceleration-jerk-mean-y"             
## [31] "time-body-acceleration-jerk-mean-z"             
## [32] "time-body-acceleration-jerk-std-x"              
## [33] "time-body-acceleration-jerk-std-y"              
## [34] "time-body-acceleration-jerk-std-z"              
## [35] "time-body-acceleration-magnitude-mean"          
## [36] "time-body-acceleration-magnitude-std"           
## [37] "time-body-acceleration-mean-x"                  
## [38] "time-body-acceleration-mean-y"                  
## [39] "time-body-acceleration-mean-z"                  
## [40] "time-body-acceleration-std-x"                   
## [41] "time-body-acceleration-std-y"                   
## [42] "time-body-acceleration-std-z"                   
## [43] "time-body-gyroscope-jerk-magnitude-mean"        
## [44] "time-body-gyroscope-jerk-magnitude-std"         
## [45] "time-body-gyroscope-jerk-mean-x"                
## [46] "time-body-gyroscope-jerk-mean-y"                
## [47] "time-body-gyroscope-jerk-mean-z"                
## [48] "time-body-gyroscope-jerk-std-x"                 
## [49] "time-body-gyroscope-jerk-std-y"                 
## [50] "time-body-gyroscope-jerk-std-z"                 
## [51] "time-body-gyroscope-magnitude-mean"             
## [52] "time-body-gyroscope-magnitude-std"              
## [53] "time-body-gyroscope-mean-x"                     
## [54] "time-body-gyroscope-mean-y"                     
## [55] "time-body-gyroscope-mean-z"                     
## [56] "time-body-gyroscope-std-x"                      
## [57] "time-body-gyroscope-std-y"                      
## [58] "time-body-gyroscope-std-z"                      
## [59] "time-gravity-acceleration-magnitude-mean"       
## [60] "time-gravity-acceleration-magnitude-std"        
## [61] "time-gravity-acceleration-mean-x"               
## [62] "time-gravity-acceleration-mean-y"               
## [63] "time-gravity-acceleration-mean-z"               
## [64] "time-gravity-acceleration-std-x"                
## [65] "time-gravity-acceleration-std-y"                
## [66] "time-gravity-acceleration-std-z"
```

Unit of measurement: - (none)

####Variable name construction
The variable name are constructed as follows with a dash (-) between the various elements that make up the variable name:

Domain: type of measurement captured (frequency or time).

Sensor placement: placement of the sensor (body indicated on the body).

Measurement: Type of measurement taking place. The body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm. Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing the frequency of the measurements.

Type of data: mathematical procedure carried out on the measurements. The following operations were applied to the data:
 - mean: Mean value
 - std: Standard deviation


Axis: axis on which the measurement took place (x, y, z or none for global (magnitude) measurements).

###Value
The value variable contains information about the mean or standard deviation (see the sensor variable for this) of the movement gathered by a sensor.


```
## [1] "Class of the value variable:"
```

```
## [1] "numeric"
```

```
## [1] "Summary of the value variable:"
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -0.99770 -0.96210 -0.46990 -0.48440 -0.07836  0.97450
```

Unit of measurement: Depending on the type of sensor.

####Notes on values:
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg.
