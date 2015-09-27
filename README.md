# Getting and Cleaning Data Course Project
My R-scripts in CourseProject.R file in this repo.
"collect" is main function. This functions read data from rootDir, do calculations and save results to outputFileName.

For example, collect("C:\\R_projects\\!readData\\task\\UCI HAR Dataset", "output.txt")

This file also have additional functions: "readData", "selectFeatures". First reads train or test data. Second selects mean and std features.
