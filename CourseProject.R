# Read data set (train or test)
readData <- function(dataDir, dataType, features)
{
        # read subject data
        subjectData <- read.table(file.path(dataDir,dataType,
                paste("subject_", dataType, ".txt", sep="")))
        
        # read activity data
        activityData <- read.table(file.path(dataDir,dataType,
                paste("y_", dataType, ".txt", sep="")))
        
        # read features with using some optimizations
        if (dataType=="test") {
                rowsNum <- 2947
        } else { 
                rowsNum <- 7352
        }
        featuresData <- read.table(file.path(dataDir,dataType,
                paste("x_", dataType, ".txt", sep="")), colClasses = "numeric", comment.char = "",
                header = FALSE, nrows = rowsNum)

        # build result data set
        result <- featuresData
        result$activity <- activityData
        result$subject <- subjectData
        
        # rename colomns return result
        result <- as.data.frame.list(result)
        
        goodColNames <- c(as.character(features[,2]), c("activity", "subject"))        
        colnames(result) <- goodColNames
        
        result
}

# Select mean and std features
selectFeatures <- function(features)
{
        meanIndexes <- grep("-mean()", features[,2], fixed = T)
        stdIndexes <- grep("-std()", features[,2], fixed = T)
        
        sort(union(meanIndexes, stdIndexes))
}

# Main function
collect <- function(rootDir, outputFileName) 
{
        # read activity labels
        activityTypes <- read.table(file.path(rootDir, "activity_labels.txt"))
        
        # read and select features
        features <- read.table(file.path(rootDir, "features.txt"), 
                colClasses=c("numeric", "character"))
        goodFeatures <- selectFeatures(features)
        
        # read train data set
        trainData <- readData(rootDir, "train", features)
        
        # generate unique row names
        rowCount <- dim(trainData)[1]
        rowNames <- as.character(seq(10000, 10000 + rowCount - 1))
        row.names(trainData) <- rowNames
        
        # read test data set
        testData <- readData(rootDir, "test", features)
        
        # union train and test
        dataSet <- rbind(trainData, testData)
        
        # select only needed features + add activity and subject colomns
        featuresList <- union(goodFeatures, c(dim(dataSet)[2] - 1, dim(dataSet)[2]))
        dataSet <- dataSet[,featuresList]

        # convert activity to descriptive representation
        activityData <- as.numeric(dataSet$activity)
        activityData <- activityTypes[activityData,2]
        dataSet$activity <- activityData
        
        # build result table
        resultColNames <- colnames(dataSet)[1:(dim(dataSet)[2] - 2)]
        
        library(dplyr)
        result <- dataSet %>% group_by(activity, subject) %>% summarise_each(funs(mean))
        write.table(result, file=outputFileName, row.names = FALSE)
}

# Run with my local path
#collect("C:\\R_projects\\!readData\\task\\UCI HAR Dataset", "output.txt")
