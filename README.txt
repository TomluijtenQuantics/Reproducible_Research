In order to fulfill the course Getting and Cleaning Data, the R script run_analysis.R has been made. This R script does the following:
- Download and unzip the dataset
- Load the required data 
- Extract the desired features (those that contain mean and std) and filter the corresponding columns in the data
- Create descriptive feature names
- Merge the training and test sets
- Label the activities and convert activities and subjects into factors
- Create the 'average' data set which is tidy
- Save the data set into the file DataAverage.txt