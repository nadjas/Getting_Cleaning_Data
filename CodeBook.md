# Getting and Cleaning Data Course Project - CODEBOOK

This code book describes the data and the transformations that the code performs on this data.

### The data 

* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

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

### The tidy data set
* The tidy data set contains the mean of all mean and std values of each subject and each activity.
* The data set is stored as a txt file using one space(" ") as the delimiter.
* The first line of the data is the variable name of the data, the names are all quoted by '"'.

### Variables
* Values of Varible Activity consist of data from ```Y_train.txt``` and ```Y_test.txt```
* Values of Varible Subject consist of data from ```subject_train.txt``` and ```subject_test.txt```
* Values of Varibles Features consist of data from ```X_train.txt``` and ```“X_test.txt”```
* Names of Varibles Features come from ```features.txt```
* Levels of Varible Activity come from ```activity_labels.txt```
* By reading the files into R we created variables dataActivityTest, dataActivityTrain, dataSubjectTrain, dataSubjectTest, dataFeaturesTest, dataFeaturesTrain.
* By merging data we created intermediary variables dataSubject, dataActivity, dataFeatures, further (still intermediary) dataCombine, and finally Data.
* By subsetting mean() and std() we created variables subdataFeaturesNames, further selectedNames, and finally Data, which becase a subset of the original variable Data.
* To prepare an independent tidy data set we created a variable Data2 that contans aggregated results from the previous steps. 

#### Transformation 

We assume that the data is already downloaded and unzipped in your working directory. The transformation process is as follows:

* read the "subject", "activity" and "features" files from test and train folders into variables.
* rbind the following pairs: SubjectTrain and SubjectTest, ActivityTraing and ActivityTest, FeaturesTrain and FeaturesTest.
* cbind the resulting three data sets into one.
* subset Name of Features by measurements on the mean and standard deviation, i.e take Names of Features with “mean()” or “std()”
* subset the dataframe by these Names.
* get the descriptive activity names from “activity_labels.txt” file
* replace the unclear and abbreviated names by descriptive names (e.g. "^t"" is replaced by "time")
* create a separate dataset ```tidydata.txt``` and write it to the working directory.
