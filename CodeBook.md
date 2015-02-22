---
title: "Codebook" 
date: "Sunday, February 22, 2015"
output: html_document
---

# List of column names from the tidy dataset

1. SubjectId
2. ActivityId
3. tBodyAcc_mean_X
4. tBodyAcc_mean_Y
5. tBodyAcc_mean_Z
6. tBodyAcc_std_X
7. tBodyAcc_std_Y
8. tBodyAcc_std_Z
9. tGravityAcc_mean_X
10. tGravityAcc_mean_Y
11. tGravityAcc_mean_Z
12. tGravityAcc_std_X
13. tGravityAcc_std_Y
14. tGravityAcc_std_Z
15. tBodyAccJerk_mean_X
16. tBodyAccJerk_mean_Y
17. tBodyAccJerk_mean_Z
18. tBodyAccJerk_std_X
19. tBodyAccJerk_std_Y
20. tBodyAccJerk_std_Z
21. tBodyGyro_mean_X
22. tBodyGyro_mean_Y
23. tBodyGyro_mean_Z
24. tBodyGyro_std_X
25. tBodyGyro_std_Y
26. tBodyGyro_std_Z
27. tBodyGyroJerk_mean_X
28. tBodyGyroJerk_mean_Y
29. tBodyGyroJerk_mean_Z
30. tBodyGyroJerk_std_X
31. tBodyGyroJerk_std_Y
32. tBodyGyroJerk_std_Z
33. tBodyAccMag_mean
34. tBodyAccMag_std
35. tGravityAccMag_std
36. tBodyAccJerkMag_mean
37. tBodyAccJerkMag_std
38. tBodyGyroMag_std
39. tBodyGyroJerkMag_mean
40. tBodyGyroJerkMag_std
41. fBodyAcc_mean_X
42. fBodyAcc_mean_Y
43. fBodyAcc_mean_Z
44. fBodyAcc_std_X
45. fBodyAcc_std_Y
46. fBodyAcc_std_Z
47. fBodyAccJerk_mean_X
48. fBodyAccJerk_mean_Y
49. fBodyAccJerk_mean_Z
50. fBodyAccJerk_std_X
51. fBodyAccJerk_std_Y
52. fBodyAccJerk_std_Z
53. fBodyGyro_mean_X
54. fBodyGyro_mean_Y
55. fBodyGyro_mean_Z
56. fBodyGyro_std_X
57. fBodyGyro_std_Y
58. fBodyGyro_std_Z
59. fBodyAccMag_mean
60. fBodyAccMag_std
61. fBodyBodyAccJerkMag_mean
62. fBodyBodyAccJerkMag_std
63. fBodyBodyGyroMag_mean
64. fBodyBodyGyroMag_std
65. angle_tBodyAccMean_gravity_
66. angle_tBodyAccJerkMeangravityMean_
67. angle_tBodyGyroMean_gravityMean_
68. angle_tBodyGyroJerkMean_gravityMean_
69. angle_X_gravityMean_
70. angle_Y_gravityMean_
71. angle_Z_gravityMean_

# Code Explanation

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
    
    '''{r}
    xcolnames <- as.vector(select(features,FeatureName)[,1])
    xcolnames<-str_replace_all(xcolnames,"[()]","_")
    xcolnames<-str_replace_all(xcolnames,"[__-]","_")
        
    xData<- read.table(xfile)
    names(xData) <- xcolnames
    '''
7. Next I subset the dataframe from the X_*.txt file to filter only the std and mean columns.
    8. Having done this the final step is to bind the Xdata with the Activity data.
	
6. The tidythedataset function calls the getMergedDataset method twice to get the dataset for train and test.
7. It then uses rbind to comine the dataset.
8. Finally the data is grouped by Subject,Activity and the mean is applied toall the columns.