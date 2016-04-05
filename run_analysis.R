########################################################################
#####        GETTING AND CLEANING DATA - FINAL PROJECT            ######
#####                                                             ######
#####                    Author: Sarai Pouso                      ######     
########################################################################


##########################################################################
### 0. Load required libraries, data sets and set the working directory ##
##########################################################################

library(plyr)
setwd("C:/use/escritorio/Sarai Pouso/R_Curso/UCI HAR Dataset")

# Load raw data
features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt",  col.names = c("Activity", "ActivityDescription"))

#Load TEST data 
subject_test<-read.table("test/subject_test.txt", col.names="subject")
X_test<-read.table("test/X_test.txt")
Y_test<-read.table("test/y_test.txt", col.names="ActivityCode")

#Load TRAINING data 
subject_train<-read.table("train/subject_train.txt", col.names="subject")
X_train<-read.table("train/X_train.txt")
Y_train<-read.table("train/y_train.txt", col.names="ActivityCode")


##################################################################
# 1.Merges the training and the test sets to create one data set #
##################################################################

#merge the 3 TEST data sets
test_data<-cbind(cbind(X_test,subject_test), Y_test)

#merge the 3 TRAIN data sets
train_data<- cbind(cbind(X_train, subject_train), Y_train)

#merge TEST and TRAIN data
all_data<-rbind(test_data, train_data)

#change column names in all_data 
newrow=c(562, "subject")
newrow2=c(563, "ActivityCode")
labels<-rbind(rbind(features, newrow), newrow2)

names(all_data)<-labels$V2
colnames(all_data)[562]<-"subject" 
colnames(all_data)[563]<-"ActivityCode"


############################################################################################
# 2.Extracts only the measurements on the mean and standard deviation for each measurement #
############################################################################################

data_mean_std <- all_data[,grepl("mean|std|subject|ActivityCode", names(all_data))]


############################################################################
#3.Uses descriptive activity names to name the activities in the data set ##
############################################################################

#create a new column "activitynames" based on the categories of column "ActivityCode"
data_mean_std$activitynames<-0
 
idx <- c(1:length(data_mean_std$ActivityCode))[data_mean_std$ActivityCode =="1"]
data_mean_std$activitynames[idx] <- "WALKING"

idx <- c(1:length(data_mean_std$ActivityCode))[data_mean_std$ActivityCode =="2"]
data_mean_std$activitynames[idx] <- "WALKING_UPSTAIRS"

idx <- c(1:length(data_mean_std$ActivityCode))[data_mean_std$ActivityCode =="3"]
data_mean_std$activitynames[idx] <- "WALKING_DOWNSTAIRS"

idx <- c(1:length(data_mean_std$ActivityCode))[data_mean_std$ActivityCode =="4"]
data_mean_std$activitynames[idx] <- "SITTING"

idx <- c(1:length(data_mean_std$ActivityCode))[data_mean_std$ActivityCode =="5"]
data_mean_std$activitynames[idx] <- "STANDING"

idx <- c(1:length(data_mean_std$ActivityCode))[data_mean_std$ActivityCode =="6"]
data_mean_std$activitynames[idx] <- "LAYING"

table(data_mean_std$activitynames)


#######################################################################
#4.Appropriately labels the data set with descriptive variable names  #
#######################################################################

# Remove parentheses
names(data_mean_std) <- gsub('\\(|\\)',"",names(data_mean_std), perl = TRUE)

# Make syntactically valid names
names(data_mean_std) <- make.names(names(data_mean_std))

# Change column names
names(data_mean_std) <- gsub('\\.mean',".Mean",names(data_mean_std))
names(data_mean_std) <- gsub('\\.std',".StandardDeviation",names(data_mean_std))
names(data_mean_std) <- gsub('^t',"TimeDomain.",names(data_mean_std))
names(data_mean_std) <- gsub('Acc',"Acceleration",names(data_mean_std))
names(data_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(data_mean_std))
names(data_mean_std) <- gsub('Gyro',"AngularVelocity",names(data_mean_std))
names(data_mean_std) <- gsub('Mag',"Magnitude",names(data_mean_std))
names(data_mean_std) <- gsub('^f',"FrequencyDomain.",names(data_mean_std))
names(data_mean_std) <- gsub('Freq\\.',"Frequency.",names(data_mean_std))
names(data_mean_std) <- gsub('Freq$',"Frequency",names(data_mean_std))
names(data_mean_std)[names(data_mean_std)=="subject"] <- "Subject"
names(data_mean_std)[names(data_mean_std)=="activitynames"] <- "ActivityNames"

names(data_mean_std)


###############################################################################
# 5.From the data set in step 4, creates a second, independent tidy data set ##
#   with the average of each variable for each activity and each subject.    ##
###############################################################################

Average_by_Activity_Subject = ddply(data_mean_std, c("Subject","ActivityNames"), numcolwise(mean))
write.table(Average_by_Activity_Subject , file = "Average_by_Activity_Subject.txt", row.name=F)

