==================================================================
Project Assignment - Course: Getting and Cleaning Data:
Dataset was obtained from the here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

==================================================================
Here's a brief walk-through of how the script works and cleans the datasets
1. There are two functions in the code, the main workhorse of the script is the getMergedDataset() function.
2. The main function is called tidythedataset(), the tidythedataset function makes calls to the getMergedDataset() functions to get the 
tidy datasets for the test and train datasets.
3. The getMergedDataset() accepts two parameters 
	i.e. 
		1. A maindir and a datadir. The maindir is really the main dataset directory which is "UCI HAR Dataset"
		2. The second parameter is the name of folder that you want the tidy dataset from (test or train).
		
4. At first I check if the working directory contains the dataset folder which is "UCI HAR Dataset". If the folder does not exist the function exits with a message to the user. 
5. If the datset directory exists then its time to roll :) 
    1. I load the data from activitylabels.txt file and rename the columns to ActivityId and Activity.
	2. Next its time to load the data from the Y_*.txt (* indicates train or text).
	3. Now its time to join the data from the steps 1 and 2 to make a new dataset called ayt which is a Inner Join from the datasets from 1 and 2.
	4. At this point I have the data that contains all the Activities performed by the subjects. The dataset is called ayt (acronym for all the data from activitylabel and the Y file).
	4. I then combine the data read from the Subject_*.txt file and ayt dataset using cbind. It is obvious here that I have assumed the rows from the Y file correspond to each of the row in the subjects_*.txt file. 
	5. At this point I have the Activity Id, Activity Label and the Subject information in a dataset called tsayt.
	6. Its now time to read the data from the features.txt , read the data from X_*.txt file and then rename the column names from the X_*.txt file to that of the names from the features. I accomplish this using this code :
	
	xcolnames <- as.vector(select(features,FeatureName)[,1])
    xcolnames<-str_replace_all(xcolnames,"[()]","_")
    xcolnames<-str_replace_all(xcolnames,"[__-]","_")
    
    xData<- read.table(xfile)
    names(xData) <- xcolnames
	
	7. Next I subset the dataframe from the X_*.txt file to filter only the std and mean columns.
	8. Having done this the final step is to bind the Xdata with the Activity data.
	
6. The tidythedataset function calls the getMergedDataset method twice to get the dataset for train and test.
7. It then uses rbind to comine the dataset.
8. Finally the data is grouped by Subject,Activity and the mean is applied toall the columns.