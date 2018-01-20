## read train data
X_train<-read.table("C:/Users/Klarissa/Documents/ACADEMICS/Data Science Track/Data/UCI HAR Dataset/train/X_train.txt")

Y_train<-read.table("C:/Users/Klarissa/Documents/ACADEMICS/Data Science Track/Data/UCI HAR Dataset/train/Y_train.txt")

sub_train<-read.table("C:/Users/Klarissa/Documents/ACADEMICS/Data Science Track/Data/UCI HAR Dataset/train/subject_train.txt")

## read test data

x_test<-read.table("C:/Users/Klarissa/Documents/ACADEMICS/Data Science Track/Data/UCI HAR Dataset/test/x_test.txt")
y_test<-read.table("C:/Users/Klarissa/Documents/ACADEMICS/Data Science Track/Data/UCI HAR Dataset/test/y_test.txt")
sub_test<-read.table("C:/Users/Klarissa/Documents/ACADEMICS/Data Science Track/Data/UCI HAR Dataset/test/subject_test.txt")

## data description
variable_names<-read.table("C:/Users/Klarissa/Documents/ACADEMICS/Data Science Track/Data/UCI HAR Dataset/features.txt")

## activity labels
activity_labels<-read.table("C:/Users/Klarissa/Documents/ACADEMICS/Data Science Track/Data/UCI HAR Dataset/activity_labels.txt")

## Merge test and train data

X_total <- rbind(X_train, x_test)
Y_total <- rbind(Y_train, y_test)
Sub_total <- rbind(sub_train, sub_test)


## Mean and SD
selected_var <- variable_names[grep("mean\\(\\)|std\\(\\)",variable_names[,2]),]
X_total <- X_total[,selected_var[,1]]

## Activity
colnames(Y_total) <- "activity"
Y_total$activitylabel <- factor(Y_total$activity, labels = as.character(activity_labels[,2]))
activitylabel <- Y_total[,-1]

## labels data
colnames(X_total) <- variable_names[selected_var[,1],2]

## Final
colnames(Sub_total) <- "subject"
total <- cbind(X_total, activitylabel, Sub_total)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_all(funs(mean))
write.table(total_mean, file = "C:/Users/Klarissa/Documents/ACADEMICS/Data Science Track/Data/UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)