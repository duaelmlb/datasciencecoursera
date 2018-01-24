## This script provides all the operations required by the final assignment of the Coursera course:
## Getting and Cleaning Data

# Package for making the data set tidy
library(plyr)
# Package for handling regular expressions
library(rebus)

## Precondition : Downloading and unzipping the .zip containing the raw data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
              "AssignmentData.zip", 
              "curl")
unzip("./AssignmentData.zip",exdir=".")

## 1. Merge the training and the test sets to create one data set
# 1.1 Merging X data between test and train
featuresXtest <- read.table(file = "./UCI\ HAR\ Dataset/test/X_test.txt")
featuresXtrain <- read.table(file = "./UCI\ HAR\ Dataset/train/X_train.txt")
mergedXdata <- rbind(featuresXtest, featuresXtrain)
featureNames <- read.table("./UCI\ HAR\ Dataset/features.txt")
featureNamesList <- featureNames$V2
colnames(mergedXdata) <- featureNamesList

# 1.2 Merging y and activity labels between test and train
activitylabelsytest <- read.table(file = "./UCI\ HAR\ Dataset/test/y_test.txt")
activitylabelsytrain <- read.table(file = "./UCI\ HAR\ Dataset/train/y_train.txt")
mergedydata <- rbind(activitylabelsytest, activitylabelsytrain)
labelsy <- read.table(file = "./UCI\ HAR\ Dataset/activity_labels.txt")
mergedywithlabels <- merge(mergedydata, labelsy)
colnames(mergedywithlabels)[2] <- "activitylabel"

# 1.3 Merging subject data between test and train
subjecttrain <- read.table(file = "./UCI\ HAR\ Dataset/train/subject_train.txt")
subjecttest <- read.table(file = "./UCI\ HAR\ Dataset/test/subject_test.txt")
mergedsubjectdata <- rbind(subjecttest, subjecttrain)
colnames(mergedsubjectdata) <- "subject"

# 1.4 Merging 3 datasets: features, activity label and subject
mergeddata <- cbind(mergedXdata, mergedywithlabels[2], mergedsubjectdata)

## 2. Selecting only the column that deal with mean or standard deviation  + column that we previously added
indexmeanorstd <- grep("std" %R% OPEN_PAREN %R% CLOSE_PAREN %R%         #looking for std()
                         "|mean" %R% OPEN_PAREN %R% CLOSE_PAREN %R%     #looking for mean()
                         "|activitylabel|subject",                      #to keep the columns we binded
                       names(mergeddata))
mergeddataMeanStd <- mergeddata[,indexmeanorstd]

## 5. Create a tidy data set with the average of each variable (columns) for each activity (rows) and each subject (rows)
finaloutput <- ddply(mergeddataMeanStd,
      c("activitylabel", "subject"),
      function(x) colSums(
        select(x, -(activitylabel:subject))
        )
      )

# Export the final data set as "final_output.txt" in the working directory
write.table(finaloutput, file = "final_output.txt", row.names = FALSE)


# ## The following code lines shouldn't be considered for marking.
# ## I just wanted to go a little further and make the data set even tidier than it already is
# ## I gather and then split the features into "domain" "feature" and "operator"

# # Make a true seperation between the feature and the operator applied to it : mean() or std()
# colnames(mergeddataMeanStd) <- sub("-mean()-X", "_X-mean()", colnames(mergeddataMeanStd), fixed = TRUE)
# colnames(mergeddataMeanStd) <- sub("-mean()-Y", "_Y-mean()", colnames(mergeddataMeanStd), fixed = TRUE)
# colnames(mergeddataMeanStd) <- sub("-mean()-Z", "_Z-mean()", colnames(mergeddataMeanStd), fixed = TRUE)
# colnames(mergeddataMeanStd) <- sub("-std()-X", "_X-std()", colnames(mergeddataMeanStd), fixed = TRUE)
# colnames(mergeddataMeanStd) <- sub("-std()-Y", "_Y-std()", colnames(mergeddataMeanStd), fixed = TRUE)
# colnames(mergeddataMeanStd) <- sub("-std()-Z", "_Z-std()", colnames(mergeddataMeanStd), fixed = TRUE)
# 
# # Gather the data and create two columns : "feature" and "value"
# gathered_data <- gather(data = mergeddataMeanStd, "feature", "value", 1:66)
# 
# # Seperate on "-" for the "feature" column
# data_w_separated_operator <- separate(data = gathered_data, col = "feature", into = c("feature", "operator"), sep = "-")
# 
# # Make a true seperation between the feature and the operator applied to it : mean() or std()
# data_w_separated_operator$feature <- sub("tBody", "time-Body", data_w_separated_operator$feature, fixed = TRUE)
# data_w_separated_operator$feature <- sub("fBody", "frequency-Body", data_w_separated_operator$feature, fixed = TRUE)
# data_w_separated_operator$feature <- sub("tGravity", "time-Gravity", data_w_separated_operator$feature, fixed = TRUE)
# 
# # Seperate on "-" for the "feature" column
# data_w_separated_operator_domain <- separate(data = data_w_separated_operator, col = "feature", into = c("domain", "feature"), sep = "-")