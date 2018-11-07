
library(reshape2)

# reading files in
# for pathways to work in Windows, substitute "/" to "\"
dataFolder<-("UCI_HAR_Dataset/")
dataTrainFolder<-paste0(dataFolder, "train/")
dataTestFolder<-paste0(dataFolder, "test/")


activity_labels<-read.delim(file=paste0(dataFolder,"activity_labels.txt"), sep = " ", header = FALSE, col.names = c("label", "activity"))

features<-read.delim(file = paste0(dataFolder, "features.txt"), sep =" ", header = FALSE, col.names = c("number", "feature"))

subject_test<-read.table(paste0(dataTestFolder, "subject_test.txt"), col.names = "subjects")
subject_train<-read.table(paste0(dataTrainFolder, "subject_train.txt"), col.names = "subjects")

subjects<-rbind(subject_train, subject_test)


X_train<-read.table(file=paste0(dataTrainFolder, "X_train.txt"))
X_test<-read.table(file=paste0(dataTestFolder, "X_test.txt"))

y_train<-read.table(file=paste0(dataTrainFolder, "y_train.txt"))
y_test<-read.table(file=paste0(dataTestFolder, "y_test.txt"))


activity_type<-rbind(y_train, y_test)

activity_type<-replace(activity_type, activity_type == 1, "WALKING")
activity_type<-replace(activity_type, activity_type == 2, "WALKING_UPSTAIRS")
activity_type<-replace(activity_type, activity_type == 3, "WALKING_DOWNSTAIRS")
activity_type<-replace(activity_type, activity_type == 4, "SITTING")
activity_type<-replace(activity_type, activity_type == 5, "STANDING")
activity_type<-replace(activity_type, activity_type == 6, "LAYING")

names(activity_type)<-"activity"
X_data<-rbind(X_train, X_test)
names(X_data)<-features$feature

neededFeatures<- grepl( 'mean|std', features$feature)
X_data<- X_data[, neededFeatures]

DataSet<-cbind(subjects, activity_type, X_data)

melt_data <-melt(DataSet, id = c("subjects", "activity" ))

write.csv(melt_data, "LongDataSet.csv", quote = FALSE)

#### rewrite this
# Apply mean function to dataset using dcast function
NewDataSet  = dcast(melt_data, subjects + activity ~ variable, mean)

write.csv(NewDataSet, file = "NewDataSet.csv", quote = FALSE)



