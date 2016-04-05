############################################
# Getting-and-Cleaning-Data-Course-Project #
############################################
I create one R script called run_analysis.r that does the following:

	- Merges the training and the test sets to create one data set.
	- Extracts only the measurements on the mean and standard deviation for each measurement. 
	- Uses descriptive activity names to name the activities in the data set
	- Appropriately labels the data set with descriptive variable names. 
	- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The name of this tidy data set is: Average_by_Activity_Subject.txt

# Data 

Data comes from experiments carried out with a group of 30 volunteers who performed six different activities wearing a smartphone. The smartphone had an accelerometer and a gyroscope, which permited to capture 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50 Hz. The obtained dataset was partitiuoned into two sets, the training data (70% of the volunteers) and the test data (30% of the volunteers).

The data used can be dowloaded from: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Reference: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

# Objective of the project
The objective of this project was to obtain a unique data set that includes data from the two data sets, test data and training data. The resulting data set includes only Mean and Standard Deviation data, summarized by subject and activity. 

# R analysis and Script explanation
I developed a R script (run_analysis.r) that transforms the original data sets to obtain a single data set (Average_by_Activity_Subject.txt). The script is divided into 6 steps: 

	- Set the working directory and load data. 
		Load all the raw data for TEST DATA (subject_tets.txt, X_test.txt and y_test.txt), TRAINING DATA (subject_train.txt, X_test.train and y_train.txt) and the features list (features.txt) and the activity labels (activity_labels.txt).
	
	- Merge the training and the test sets to create one data set. 
		Using cbind() and rbind() functions, test and training data were merged. 
	
	- Extract the measurements on the mean and standard deviation for each measurement. 
		Using grepl() function, columns that contained only "mean" and "std" were selected. Columns containing subject and activity information.

	- Change activity labels to descriptive activity names
		I create a new column named "activitynames". The content of this column is related with the content in column "ActivityCode".

	- Label the data set with descriptive variable names
		Using gsub() function, short descriptions were replaced by descriptive names.

	- Creates an independent tidy data set with the average of each variable for each activity and each subject
		Using ddply() function, I obtained the means of each variable grouped by Subject and Activity.
		As the resulting data set has to be independent, I used the function write.table() to save the new data set. 





