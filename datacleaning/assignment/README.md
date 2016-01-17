To create the tidy summirised data set run the following commands. 


sources the run_analysis.R file. 

```R 
source('./run_analysis.R')
```

Run the process function. This function returns a data.frame contain the summarised data described in CodeBook.md

```R 
summarisedData <- Process()
```

Output summarised file to disk and print out the date. 

```R
write.table(summarisedData, file = "data.txt", row.name=FALSE)
dateDownloaded <- date()
dateDownloaded
```

Options

The Process() function will check for the requered data set in the "UCI HAR Dataset" directory in the current working directory. If it is not found it will be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. To force the data to be download even if the "UCI HAR Dataset" directory is present use the DownLoadData() function. 

```R 
DownLoadData()
```

The Process() function will only load the file if its not already loaded in memory to force the data to be reloaded from the file the init() function can be called before the Process() function. 

```R 
Init()
Process()
```

see CodeBook.md for description of summarised data outputed by the Process(). function.



## Original Data
Downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* Human Activity Recognition Using Smartphones Dataset
* Version 1.0

* Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
* Smartlab - Non Linear Complex Systems Laboratory
* DITEN - Universit� degli Studi di Genova.
* Via Opera Pia 11A, I-16145, Genoa, Italy.
* activityrecognition@smartlab.ws
* www.smartlab.ws




