##part 1: Merge the training and the test sets to create one data set
#read data into variables
dataActivityTest  <- read.table("./UCI HAR Dataset/test/Y_test.txt", header = FALSE)
dataActivityTrain <- read.table("./UCI HAR Dataset/train/Y_train.txt",header = FALSE)
dataSubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
dataSubjectTest  <- read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE)
dataFeaturesTest  <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)
dataFeaturesTrain <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)
#merge training and test datasets by binding rows
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)
#set names to variables
names(dataSubject)<- "subject"
names(dataActivity)<- "activity"
dataFeaturesNames <- read.table("./UCI HAR Dataset/features.txt", head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2
#merge all datasets by column in a dataframe called "Data"
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)
##part2: Extract only the measurements on the mean and standard deviation for each measurement
#Subset Features names by measurements on the mean and standard deviation
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
# Subset "Data" by seleted names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)
##part 3: Use descriptive activity names to name the activities in the data set
# read activity names
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE)
# factorize variable "activity" in "Data"
##part 4: Appropriately label the data set with descriptive variable names 
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
##part 5: From the data set in part 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
library(plyr)
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
