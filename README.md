# Getting And Cleaning Data 
##Course project 
## Paul H

## Steps performed by the script run_analysis.R

###Getting data
The zip file was unloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
and unzipped in the working directory.

The activity labels and features files were each read into dataframes. Character vectors were created from the features for renaming the data columns. One of the vectors was filtered so that only attribute names containing 'mean' or 'std' were retained. This vector was again filtered to remove attribute names containing 'meanFreq', leaving the 66 attributes retained for the tidy dataset.  

The data, subject, and activty files for the training and test subjects were read into dataframes then converted to datatables. Column names were changed for these tables using the above mentioned vectors and the 'setnames' command.


###Combining subject, activity, and data 

The subject, activty, and data were combined using 'cbind'. This was done separately for the training and test data before merging the training and test data. Coming from an Oracle database background, I am uneasy when files and tables do not have 'keys,' but rather rely on order. Therefore, getting the subject and activity keys attached to the data was a first priority. The subject, activity, and data tables were then removed from memory.

### Merging Data and Filtering Columns

The training and test datasets resulting from the combine step were then merged using the 'rbind' command. 'dplyr select' was used to select the attributes (66) to be retained from the orignal 561. At this stage the activities are still identified by numbers. 'dplyr mutate' was used to add a new column containing the activity name corresponding to the activty number and subset was used to remove the activity number column. The activity name column was added as the last column so setcolorder was used to reorder the columns in the order: Subject, Actity, attributes(66 columns).

###Creating the Tidy Data Set

The mean values for each attribute was calculated using 'aggregate' over the subject-activty pairs and the data ordered by subject/activity using the arrange command.  This is the 180 x 68 column dataset of averages. Write.table was used to create the file 'tidy_data_set.txt'.


