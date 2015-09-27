#Getting and Cleaning Data Course project
About CourseProject.R:
* I read all data (subjects, activities, features etc) using read.table functions. 
It works a bit slow for x_test.txt, x_train.txt files, so I used several optimizations.
* I have some troubles with rbind(trainData, testData). So I changed row names for trainData.
* In readData function, I read features, subjects, activities and merge them into one table. activity and subject are last colomns in data. Also in readData i give colomns a readable names.
* In selectFeatures function i select mean and std features. I used grep-function for select features. And union+sort for get results.

"collect" function steps:
* Read all data. 
* Merge train and test using rbind. 
* Select needed subset of features.
* Tranform activity data to readable format.
* And finally get result using dplyr package. I used group_by function for create data set groups. And summarise_each with mean function. I save this result to output file.
