# CodeBook for course project

## Functions
read

Function to make data reading in easier. Take in filepath of target file in UCI HAR Dataset folder and optional argument to define column names.

## Variables
- folder: the folder that contains the dataset
- features: list of features as listed in "features.txt"
- activity_labels: activity labels as listed in "activity_labels.txt"
- data_merged: raw X test and train data sets combined
- is_std_or_mean: boolean vector of whether column name is a std() or mean() measurement
- data_filtered: data filtered to std and mean columns
- activity_id: activity labels (Y_train/Y_test) combined for test and train
- data_activities: data filtered to std and means with activity_id and label columns added
- subjects: subject ids for train and test data
- data_full: full data with activiity id and label, subject id
- data_means: final output dataset, summarized by activity and subject (aggregate is mean)