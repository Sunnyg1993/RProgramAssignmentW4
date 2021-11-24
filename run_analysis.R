#You should create one R script called run_analysis.R that does the following. 
library(dplyr)
library(tidyr)

#load the files
#load the features
feats <- read.table("./UCI HAR Dataset/features.txt")

#load test dataset
test_X <- read.table("./UCI HAR Dataset/test/X_test.txt",header = F)
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt",header = F)

df_test <- cbind(test_y,test_X)
colnames(df_test) <- c("labels",feats$V2)
df_test$category <- c("test")


#load training dataset
train_X <- read.table("./UCI HAR Dataset/train/X_train.txt",header = F)
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt",header = F)

df_train <- cbind(train_y,train_X)
colnames(df_train) <- c("labels",feats$V2)
df_train$category <- c("training")

#1. Merges the training and the test sets to create one data set.

df <- rbind(df_train,df_test)

# save the df as csv,so it can keep the suffix automated add for the duplicated names,otherwise return a error when converting to tbl, and won't take the .name_repair as an argument to fix the duplicated name issue
write.csv(df,"df.csv", row.names = F)
df1 <- read.csv("df.csv")
dt <- tbl_df(df1)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 

dt1 <- dt %>%
  select(contains(c("labels","mean","std")))

#3. Uses descriptive activity names to name the activities in the data set
# load the activity label tables
labs <- read.csv("./UCI HAR Dataset/activity_labels.txt",header = F,sep = " ")

#the "label" function return the activity based on the input number
label <- function(x){
  for (i in 1:nrow(labs)){
    if (x == labs$V1[i]){
      lab <- labs$V2[i]
    }
  }
  return(lab)
}  

# the function is supposed to do vectorization, meaning do the same function for each single element, but here, instead, it takes the whole column dt$labels as input, and return warning that the input length > 1 so that it obly take the first element for the function, so actually, it is now all the number 5 STANDING..., if you know how to fix this problem, kindly let me know, thanks! 
dt2 <- dt %>%
  mutate(activities = label(labels))

#this loop works
dt3 <- df1
dt3$activities <- NA
for (i in 1:nrow(df1)){
  dt3$activities[i] = label(dt3$labels[i])
}


#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
dt4 <- tbl_df(dt3)
tidy_data <- dt4%>%
  select(contains(c("labels","activities","mean","std")))
write.table(tidy_data, file = "tidy_data.txt",row.name=FALSE)




