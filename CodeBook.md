#Getting and Cleaning Data Course project
About CourseProject.R:
* I read all data (subjects, activities, features etc) using read.table functions. 
It works a bit slow for x_test.txt, x_train.txt files, so i used several optimizations.
* I have some troubles with rbind(trainData, testData). So i changed row names for trainData.
