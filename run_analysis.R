#run_analysis.R
# Getting and Cleaning Data :: Course Project

setwd("H:/Users/Paul/Rfiles/GetandCleanData/gcdCourseProject")

library(dplyr)
library(data.table)

#####################################################

# some common code
# get features and load into vector
fn_features <- "./UCI HAR Dataset/features.txt"
features.tbl <- read.table(fn_features) 

cn <- c("subject_no", "activity")
cn2 <- c("subject_no", "Activity_name")
cn.full <- as.character(features.tbl[,2])
cn.full.d <- as.character(c(cn, cn.full)) # subj, activity, 561 descriptions


tb_mean_std_features <- dplyr::filter(features.tbl, grepl('-mean()|-std()', V2))    
tb_mean_std_feat <- dplyr::filter(tb_mean_std_features, !grepl('-meanFreq()', V2)) 
#get vector of column names to keep
data_cn <- as.character(tb_mean_std_feat[,2]) # 66 col names
col.names <- as.character(c(cn, data_cn))
col.names2 <- as.character(c(cn2, data_cn))

#these are activity labels (number, activity description)
fn_activity <- "./UCI HAR Dataset//activity_labels.txt"
activity.tb <- read.table(fn_activity)  

#prepare and cbind the activity, subjects, and data 
#seperately before merging the training and test data

# read data files for test and training data
# cbind subject, activity, data for test and training separately
# then rbind training and test data
# TEST DATA #############################################
fn_test_data <- "./UCI HAR Dataset/test/X_test.txt"
tb_test_data <- read.table(fn_test_data)  #header = TRUE
test.data <- data.table(tb_test_data)
setnames(test.data, cn.full) # rename columns, faster than colnames?

# test subjects
fn_test_subject <- "./UCI HAR Dataset/test/subject_test.txt"
 test.subject <- read.table(fn_test_subject)
setnames( test.subject, "subject_no") # rename column

# activity number for test data
fn_test_activity <- "./UCI HAR Dataset/test/y_test.txt"
 test.activity <- read.table(fn_test_activity)  
setnames( test.activity,"activity")

# bind activity, subject, and test data 
dt.test <- cbind( test.subject,  test.activity, test.data)

#cleanup
rm(test.data, test.subject, test.activity, tb_test_data) 

# TRAINING DATA #########################################
fn_train_data <- "./UCI HAR Dataset/train/X_train.txt"
tb_train_data <- read.table(fn_train_data)  
training.data <- data.table(tb_train_data)
setnames( training.data, cn.full) # rename columns

fn_train_subject <- "./UCI HAR Dataset/train/subject_train.txt"
 training.subject <- read.table(fn_train_subject)  
setnames( training.subject, "subject_no") # rename column

# # activity number for training data
fn_train_activity <- "./UCI HAR Dataset/train/y_train.txt"
training.activity <- read.table(fn_train_activity)  
setnames(training.activity,"activity")

# bind activity, subject, and test data 
dt.train <- cbind( training.subject, training.activity,  training.data)

#cleanup
rm(training.data, training.subject, training.activity, tb_train_data) 

#########################################################
# MERGE TRAINING & TEST DATA ############################
############################# merge test and train data

# may want to change?
#class(dt.train);class(dt.test) # both data.frame

dataset.full <- rbind(dt.train, dt.test) # test & training combined

dim(dataset.full) # 10299 x 563
dim(dt.test)     #  2947 x 563
dim(dt.train)    #  7352 x 563
colnames(dataset.full)
str(dataset.full) #data.frame
#cleanup
rm(dt.test, dt.train)


#convert df to dt?
dt.combined <- data.table(dataset.full)
colnames(dt.combined)


# select combined dataset columns to keep     
new.dt <- dplyr::select(dt.combined, one_of(col.names))


colnames(new.dt)
dim(new.dt) # 10299 x 68

head(new.dt)

# need to ...
# select subset of columns to keep 

# assign text to activity numbers in activity column
##########   last step in instructons
#add column, then drop numeric activity in next step
# this adds the column onto end
activity.vector <- as.vector(activity.tb[,2])
activity.vector

#populate new column with activity names, matches name to activity no in table
df.named.activity <-    mutate(new.dt,  Activity_name = activity.vector[new.dt$activity]) 

# activity no in col2 and activity text at end
colnames(df.named.activity)
head(df.named.activity)
tail(df.named.activity)

str(df.named.activity) #Classes 'data.table' and 'data.frame'

# removing columns
#data <- subset(data, select=-size)

#this removed column 
dt.testing <- df.named.activity
str(dt.testing)
dt.testing <- subset(dt.testing, select=-activity)

#reorder columns so activity name is 2nd column
setcolorder(dt.testing, col.names2)

head(dt.testing)
tail(dt.testing)

#cleanup
rm(dataset.full, dt.combined, new.dt)

#  name        num
# vegetables[vegetable_codes]

##### rename columns, manually enter meaningful names into vector to use.


#need to make tidy data set
# 30 volunteers, 6 activities, --> AVG(subject, activity, measurement)


dt.testing %>% dplyr::group_by(subject_no, activity) %>% dplyr::summarize


#this looks like it may have worked, but prob with activity name column
aggregate(ChickWeight$weight, list(time = ChickWeight$Time, diet = ChickWeight$Diet), 
          mean)




tidy.data.set <- aggregate(dt.testing, list(Subject = dt.testing$subject_no, Activity = dt.testing$Activity_name), FUN=mean)
tidy.data.set <- subset(tidy.data.set, select=-Activity_name)
tidy.data.set <- subset(tidy.data.set, select=-subject_no)


#tidy.data.set2 <- tidy.data.set %>% dplyr::group_by(Subject, Activity)

#this is it!!!!!!!!!!!!!!!!!!!!!!
tidy.data.set2 <- tidy.data.set %>% dplyr::arrange(Subject, Activity) 

head(tidy.data.set2)

head(tidy.data.set)
tail(tidy.data.set)
rm(tidy.data.set)

dim(tidy.data.set2) # 180 x 66

write.table(tidy.data.set2, row.name=FALSE, col.names=TRUE, file="tidy_data_set.txt")


##############################
Total.Baltimore.pm25.byType <- Balt.pm25 %>% dplyr::group_by(type, year)  %>% dplyr::select(Emissions)
%>% 
  
  bw <- dplyr::summarize( Total.Baltimore.pm25.byType,type, 
                          Emissions = sum(Emissions, na.rm = TRUE)
  )


#********************************
#You can run gsub with a regex on the data from features.txt.
#That can remove the numbers,space, etc. 
#************************************

# subject_no activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y
# 24        2         0.1922746       -0.03364257       -0.10594911       -0.3548408      -0.09250435
# 24        2         0.3101546       -0.05339125       -0.09910872       -0.2878663      -0.14058918
# 24        2         0.3633846       -0.03921402       -0.10591509       -0.3053880       0.02814774
# 24        2         0.3499661        0.03007744       -0.11578796       -0.3296381      -0.04214289
# 24        2         0.2375938        0.01846687       -0.09649893       -0.3231143      -0.22977539
# 24        2         0.1536272       -0.01843651       -0.13701846       -0.3300460      -0.19525335





######### end #################################
##########end
########  end



