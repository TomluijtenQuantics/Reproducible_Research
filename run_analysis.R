# Download and unzip the dataset
filename <- "Dataset.zip"
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, filename)
unzip(filename) 
setwd("./UCI HAR Dataset")

# Load the required data (features, test- and trainingset, labels, activities, subjects)
Features <- read.table("features.txt")
Features[,2] <- as.character(Features[,2])
TrainingSet <- read.table("train/X_train.txt")
TestSet <- read.table("test/X_test.txt")
ActivityLabels <- read.table("activity_labels.txt")
TrainingActivities <- read.table("train/Y_train.txt")
TrainingSubjects <- read.table("train/subject_train.txt")
TestActivities <- read.table("test/Y_test.txt")
TestSubjects <- read.table("test/subject_test.txt")
 
# Extract the desired features (containing mean and std) 
DesiredFeaturesIndex <-grep(".*mean.*|.*std.*", Features[,2])
DesiredFeatures <- Features[DesiredFeaturesIndex,2]
TrainingSet <- TrainingSet[,DesiredFeaturesIndex]
TestSet <- TestSet[,DesiredFeaturesIndex]

# Create descriptive feature names
DesiredFeatures <- gsub("-mean","Mean", DesiredFeatures)
DesiredFeatures <- gsub("-std","Std", DesiredFeatures)
DesiredFeatures <- gsub("[()-]","", DesiredFeatures)

# Merge the training and test sets
TrainingData <- cbind(TestSubjects, TestActivities, TestSet)
TestData <- cbind(TrainingSubjects, TrainingActivities, TrainingSet)
Data <- rbind(TrainingData, TestData)
colnames(Data) <- c("Subject", "Activity", DesiredFeatures)

# Label the activities
Data$Activity <- factor(Data$Activity, levels = ActivityLabels[,1], labels = ActivityLabels[,2])
Data$Subject <- as.factor(Data$Subject)

# Create the 'average' data set
DataMelted <- melt(Data, id = c("Subject", "Activity"))
DataAverage <- dcast(DataMelted, Subject + Activity ~ variable, mean)

# Write the text file
write.table(DataAverage, "DataAverage.txt", row.names = FALSE, quote = FALSE)

