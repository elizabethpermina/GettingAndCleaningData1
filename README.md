# GettingAndCleaningData1
assignment directory for Getting And Cleaning Data course

run_analysis.R extracts required data (mean and strandard deviation values) from UCI_HAR dataset, merges train and test data, substitutes activity code with activity name ("WALKING", "SITTING" etc) melts data into long format and creates a creates a second, independent tidy data set with the average of each variable for each activity and each subject NewDataSet.csv is a comma-separated file with the second, independent dataset. The first dataset in the long format is in the file "LongDataSet.csv"
