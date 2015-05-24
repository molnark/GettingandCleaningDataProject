#Intro

The R script: `run_analysis.R`was constructed with the 5 steps described in the Getting and Cleaning Data Project
* The data was obtained from obtained from (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) 
* After unzipping the data is in two folders, test and training. There are three chunks of data in both these folders:Activities obtained from `y_test.txt`& `y_train.txt`, Subjects from `subject_test.txt` & `subject_train.txt` and the Raw observations from `x_test.txt` & `x_train.txt`. 
* In the first step,data is read in by R, then the chunks of data from the test and training folders are merged into  mAct,mSubject,mData using rbind() 
* Then, we cull the columns  to only those that measure mean and standard deviation. Also we name the remaining columns. 
* After that, I added activity names and IDs from `activity_labels.txt` and use text functions to clean up the label names.
* Then i merged the three chunks of data with the proper descriptive activity names.
* Lastly, I made a tidy dataset with all the mean measures for each subject and activity type The file is called `tidymerge.txt`, and i uploaded that to coursera site.

# Variables

* `testData`, `trainData`, `testAct`, `trainAct`, `testSubject` and `trainSubject` contain the data from the files test and train folders
* `mData`, `mAct` and `mSubject` merge the respective previous datasets.
* `features` holds the names for the `mData` dataset. `meanStdPos` determines the position in 'features' of the mean & std measurements, and then is used to subset them out.
* `actLabels` holds the activity file after being read into R, `activities` holds the properly formated names. 
* `cData` merges `mData`, `mAct` and `mSubject` into the big dataset.
* Lastly, `final` contains the data which will later by used to create a .txt file with write.table
