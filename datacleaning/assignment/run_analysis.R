library(reshape2)


# main processing function
# download data if requered
# load data into memory if requered
# merge the data and labels 
# clean variable names
# removed all measurments that are not means or standard deviations
# group each measument by subject and activity type and caclculate means for each group
# return this new table of data
Process <- function() {

  ReadRawData()
  train <- MergeAndClean(trainSubject, trainLabel, trainData)
  test <- MergeAndClean(testSubject, testLabel, testData)
  mergedData <- rbind(train, test)
  
  
  mergedDataMelted <- melt(mergedData, id = c("subject", "activity"))
  mergedDataMeans <- dcast(mergedDataMelted, subject + activity ~ variable, mean)
  mergedDataMeans
}



# If the data has not been loaded or load it into memory. if data is not in the data directory, 
# download from internet and then unzip before loading into memory. 
ReadRawData <- function() {
  if(!exists("inited")){
    Init()
  }
  
  if(!loaded){
    DownLoadDataIfRequered()
    
    testSubject <<- read.table("./UCI HAR Dataset/test/subject_test.txt",  header = FALSE, na.strings = "?")
    testData <<- read.table("./UCI HAR Dataset/test/X_test.txt",  header = FALSE, na.strings = "?")
    testLabel <<- read.table("./UCI HAR Dataset/test/y_test.txt",  header = FALSE, na.strings = "?")
    
    trainSubject <<- read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE, na.strings = "?")
    trainData <<- read.table("./UCI HAR Dataset/train/X_train.txt",  header = FALSE, na.strings = "?")
    trainLabel <<- read.table("./UCI HAR Dataset/train/y_train.txt",  header = FALSE, na.strings = "?")
    
    loaded <<- TRUE
  }
    
}

#Download the data file if it appares to be missing
DownLoadDataIfRequered <- function() {
  if (!file.exists("./UCI HAR Dataset")) {
    DownLoadData()
  }
}

#Download the data file from the internet and unzip it
DownLoadData <- function() {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./data.zip", method = "curl")
  unzip("./data.zip", overwrite = T, exdir = "./")
}


# merge the data with the subject and labels and tidy the data removing unwanted measuments and providing 
# better names for the variables. 
MergeAndClean <- function(subject, label, data){
  names(subject) = "subject"
  names(label) = "activity"
  
  features <- read.table("./UCI HAR Dataset/features.txt",  header = FALSE, na.strings = "?")
  
  names(data) = sapply(features$V2, CleanVariableName)
  data <- data.frame(subject, sapply(label, GetActivityLabel), FilterOnlyMeanAndStandardDeviation(data))
  data$subject <- as.factor(data$subject)
  data$activity <- as.factor(data$activity)
  data
}

# load the activity label names from a file. 
GetActivityLabel <- function(val) {
  if(!exists("activity")){
    activity <- read.table("./UCI HAR Dataset/activity_labels.txt",  header = FALSE, na.strings = "?")
  }
  activity$V2[val]
}


# Filter out any results that are not a mean or a standard deveation
FilterOnlyMeanAndStandardDeviation <- function(frame) {
  frame[,grepl("mean|standard.deviation", names(frame))]
}


# Convert the varable names to tidy variable names. 
# . used as word seperate to make the long and descriptive names easer to read
CleanVariableName <- function(name) {
  name <- gsub("Acc", "acceleration", name)
  name <- gsub("tBody", "time.body.", name)
  name <- gsub("fBody", "frequency.body.", name)
  
  
  name <- gsub("Mag", ".magnitude", name)
  name <- gsub("Jerk", ".jerk", name)
  name <- gsub("bandsEnergy", "bands.energy", name)
  name <- gsub("tGravity", "time.gravity.", name)
  name <- gsub("fGravity", "frequency.gravity.", name)
  name <- gsub("Gyro", "gyroscope", name)
  name <- gsub("sma[(][)]", "signal.magnitude.area", name)
  name <- gsub("mad[(][)]", "median.absolute.deviation", name)
  name <- gsub("iqr[(][)]", "interquartile.range", name)
  name <- gsub("std[(][)]", "standard.deviation", name) 
  name <- gsub("arCoeff", "auto.regresion.coefficient", name) 
  name <- gsub("Body", "body.", name)
  name <- gsub("meanFreq", "mean.freq", name)
  
  
  name <- gsub("[(][)]", "", name)
  name <- gsub("-X", ".x", name)
  name <- gsub("-Y", ".y", name)
  name <- gsub("-Z", ".z", name)
  name <- gsub(",", "", name)
  name
}

# reset the tracking state of if data has been loaded into memory
Init <- function (){
  inited <<- TRUE
  loaded <<- FALSE
}



