# RProgramAssignmentW4
##
## The "run_analysis.R" should load the raw data and clean up following instructions, and get a tidy dataset
##
### preparations1: load packages
### preparations2: load the data by read.csv(), includig training and test data sets, features for colnames, and activity_labels
### preparations3: union data sets by rbind the y and X, and name column by colnames()
###
### 1. combine the training and test data sets by cbind() and save to a tbl by tbl_df
#### Note: tbl_df returns an error about the duplicated names issue. ".name_repair" argument suggested by the error message does not work, cannot be taken as a argument, don't know why for now. Here I save the dataframe (df) as a CSV and reload to save the automated suffixed df. Alternately, rename the duplicated ones (features:without proper XYZ ending) by a self-writen function first.
### 2. select measurements on the mean and standard deviation for each measurement by select()
### 3. Uses descriptive activity names to name the activities in the data set
#### 3.1 write a function to pick the activities for the label number based on activity_labels.txt
#### 3.2 creat a new column contains the descriptive activity names by mutate
#### Note that here I use a for loop instead a mutate using a function. The problem in mutate is that it does not do vectorization but take the whole column as an input. Don't why either for now.
### 4. Appropriately labels the data set with descriptive variable names. done in step 1
### 5. save the tidy dataset by write.table()
## The "codebook.md" contains the code for variables in the tidy dataset

