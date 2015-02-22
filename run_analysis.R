##You should create one R script called run_analysis.R that does the following. 
##Merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation for each measurement. 
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names. 
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidythedataset<- function(){
    
    library(stringr)
    
    workingdirectory <- getwd()
    fullfilepath <- paste(workingdirectory,"UCI HAR Dataset",sep="\\")
    
    if(file.exists(fullfilepath))
    {
        testdata <- getMergedDataset(fullfilepath,"test")
        traindata <- getMergedDataset(fullfilepath,"train")
        
        data <- rbind(testdata,traindata)
        library(plyr)
        avedata <- ddply(data,.(SubjectId,ActivityId),numcolwise(mean)) 
        
        
        anames <- names(avedata)
        anames <- str_replace(anames,"___","-")
        anames <- str_replace_all(anames,"[___]","-")
        anames <- str_replace_all(anames,"[-]","_")
        anames <- str_replace_all(anames,"[,]","_")
        anames <- str_replace(anames,"__","")
        names(avedata)<-anames    
        avedata
    }
    else{
        print(paste("The dataset directory does not exist in the working directory:",fullfilepath,sep=" "))
    }
    
}

getMergedDataset<- function(mainDir ="C:\\_R\\3 -Getting and Cleaning data\\Assignment\\UCI HAR Dataset",dataDir="test"){
    
    library(dplyr)
    library(stringr)
    
    test <- "test"
    train <- "train"
    xfile<-""
    yfile<-""
    subjectFile<-""
    
    dataFolder <- paste(mainDir ,"\\",dataDir,sep="")
    
    switch(dataDir,
           test={
               xfile<-paste(dataFolder,"\\X_test.txt",sep="")
               yfile<-paste(dataFolder,"\\y_test.txt",sep="")
               subjectFile <- paste(dataFolder,"\\subject_test.txt",sep="")
           },
           train={
               xfile<-paste(dataFolder,"\\X_train.txt",sep="")
               yfile<-paste(dataFolder,"\\y_train.txt",sep="")
               subjectFile <- paste(dataFolder,"\\subject_train.txt",sep="")
               
           }
           )
    
    dataDir <- paste(mainDir ,"\\","test",sep="")
    #trainDir <-paste(mainDir , "\\train",sep="")
    
        
        
    #load the activity levels into a data frame
    activitylevels <- read.table(paste(mainDir,"\\activity_labels.txt",sep=""))
    activitylevels <- dplyr::rename(activitylevels,ActivityId=V1,Activity=V2)
    
    yData<- read.table(yfile)
    names(yData)<- "ActivityId"
    
    #merge the activity levels with the activity file i.e. Y_test.tx
    ayt <- inner_join(yData,activitylevels)
    
    subjectData <- read.table(subjectFile)
    subjectData <- dplyr::rename(subjectData,SubjectId=V1)
    tsayt <- cbind(subjectData,ayt) # tsayt <- Test Subjects Activities
    
    
    features <- read.table(paste(mainDir,"\\features.txt",sep="")) 
    features <- dplyr::rename(features,FeatureId=V1,FeatureName=V2)
    
    xcolnames <- as.vector(select(features,FeatureName)[,1])
    xcolnames<-str_replace_all(xcolnames,"[()]","_")
    xcolnames<-str_replace_all(xcolnames,"[__-]","_")
    
    xData<- read.table(xfile)
    names(xData) <- xcolnames
    xdata <- xData[,c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,215,227,228,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,555,556,557,558,559,560,561)]
    mdata  <- cbind(tsayt,xdata) #merged test data
    mdata
}