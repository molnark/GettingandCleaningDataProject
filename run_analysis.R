#Step 1 Merge Test and Train Datasets 

#read the text files into R
testData <- read.table("test/X_test.txt", quote="\"")
trainData <- read.table("train/X_train.txt", quote="\"")
testAct<- read.table("test/Y_test.txt", quote="\"")
trainAct<-read.table("train/Y_train.txt", quote="\"")
testSubject<- read.table("test/subject_test.txt", quote="\"")
trainSubject<- read.table("train/subject_train.txt", quote="\"")

#merge test & train
mData<-rbind(testData,trainData)
mAct<-rbind(testAct,trainAct)
mSubject<-rbind(testSubject,trainSubject)

#Step 2 Cut data set down to only mean()+ std() measurements

features<-read.table("features.txt", quote="\"")
#cull the variables(columns) to mean()&std()
meanStdPos<- grep("mean\\(\\)|std\\(\\)", features[,2])
mData<-mData[,meanStdPos]
names(mData)<-features[meanStdPos,2]

#create variable names,clean up the variable names
names(mData) <- gsub("\\(\\)", "", features[meanStdPos, 2])
names(mData)<-gsub("-", "", names(mData))
names(mData) <- gsub("mean", "Mean", names(mData)) 
names(mData) <- gsub("std", "Std", names(mData)) 

#Step 3 Use descriptive activity names to name the activities in the data set

actLabels <- read.table("activity_labels.txt")
#add activities to dataset and clean/style names
actLabels[, 2] <- tolower(gsub("_", "", actLabels[, 2]))
substr(actLabels[2, 2], 8, 8) <- toupper(substr(actLabels[2, 2], 8, 8))
substr(actLabels[3, 2], 8, 8) <- toupper(substr(actLabels[3, 2], 8, 8))
activities <- actLabels[mAct[, 1], 2]
mAct[, 1] <- activities
names(mAct) <- "activity"


# Step4. Appropriately labels the data set with descriptive activity 
# names.
#add subject data, final merge
names(mSubject) <- "subject"
cData <- cbind(mSubject, mAct, mData )

write.table(cData, "firstmerge.txt", row.name=FALSE)

# Step5. Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 
subLen <- length(table(mSubject)) 
actLen <- dim(actLabels)[1] 
colLen <- dim(cData)[2]
final <- matrix(NA, nrow=subLen*actLen, ncol=colLen) 
final <- as.data.frame(final)
colnames(final) <- colnames(cData)
row <- 1
#summerize,average and sort data
for(i in 1:subLen) {
  for(j in 1:actLen) {
    final[row, 1] <- sort(unique(mSubject)[, 1])[i]
    final[row, 2] <- actLabels[j, 2]
    bool1 <- i == cData$subject
    bool2 <- actLabels[j, 2] == cData$activity
    final[row, 3:colLen] <- colMeans(cData[bool1&bool2, 3:colLen])
    row <- row + 1
  }
}

write.table(final, "tidymerge.txt", row.name=FALSE) 

