#
print("Data cleaning of UCI_HAR_Dataset")

readvec <- function(filename) {
	f <- read.table(filename, header=F)
}

mergeIS <- function () {
	basemeasure <- c("body_acc", "body_gyro", "total_acc")
	axis <- c("x", "y", "z")
	for (a in seq_along(axis)) {
   		for (b in seq_along(basemeasure)) {
       			ftest <- sprintf("UCI_HAR_Dataset/%s/Inertial\ Signals/%s_%s_%s.txt", "test", basemeasure[b], axis[a], "test", "test")
#			print(ftest)
			ftestread <- readvec(ftest)
       			ftrain <- sprintf("UCI_HAR_Dataset/%s/Inertial\ Signals/%s_%s_%s.txt", "train", basemeasure[b], axis[a], "train", "train")
#			print(ftrain)
			ftrainread <- readvec(ftrain)
			fall <- rbind(ftrainread, ftestread)
			fout <- sprintf("%s_%s.txt", basemeasure[b], axis[a])
			write.table(fall, file=fout)
   		}
	}
}

lookupActivity <- function(inj) {
	activityvec[inj]
}

# Reading subject key files (train and test)
getSubjects <- function() {
	print("Reading subject key files (train and test)")
# read the subject key files
	subject1 <- readvec("UCI_HAR_Dataset/train/subject_train.txt")
	subject2 <- readvec("UCI_HAR_Dataset/test/subject_test.txt")
# merger them train then test list (this order must be observed for all merges
	subject <- rbind(subject1, subject2)
# give the column a title
	names(subject) <- "subjectId"
	subject
}

getParams <- function() {
	print("Reading derived data sets for train and test")
	params1 <- readvec("UCI_HAR_Dataset/train/X_train.txt")
	params2 <- readvec("UCI_HAR_Dataset/test/X_test.txt")
	params <- rbind(params1, params2)
	params
}

getActivity <- function() {
	# now do the action list train then test
	print("Reading the activity types for train and test")
	yset1 <- readvec("UCI_HAR_Dataset/train/y_train.txt")
	yset2 <- readvec("UCI_HAR_Dataset/test/y_test.txt")
	yset <- rbind(yset1, yset2)
	names(yset) <- "activityCode"
	yset
}

getActivityVec <- function() {
	print("Reading the activity codes to name mapping files")
#	read the file containing the activities code to name mappings
	activity <- read.csv("UCI_HAR_Dataset/activity_labels.txt", sep=" ", stringsAsFactors=F, header=F)
#	there is an index to position mapping so can use dat as index into vector.
	activityvec <- activity[[2]]
	activityvec
}

	print("reading the headings for summary data")

#	read the column names for the X_(test,train) data sets
	fset <- read.csv("UCI_HAR_Dataset/features.txt", sep=" ", stringsAsFactors=F, header=F)

#	create a vector of the rows which name the folumns is th params file
	fsetname <- fset[[2]]
	fsetname

params <- getParams()
yset <- getActivity()
# assign these names
names(params) <- fsetname

print("Selecting the columns to use from data set")
# find the column number/name pairs that represent the columns names with mean( or std( in their name
fset1 <- fset[grepl('mean[(]|std[(]',fset$V2),]

# create 2 vectors fsetname1a is a vector of columns numbers/indices
#                  fsetname1b is a vector of columns strings
fsetname1a <- fset1[[1]]
fsetname1b <- fset1[[2]]

params1 <- params[,fsetname1a]

print("creating the final data frame containing the subject, activity and measurements")
subject <- getSubjects()
mergedparams <- cbind(subject, yset, params1)
mergedparams$activityCode <- mapply(function(x) activityvec[x], mergedparams$activityCode)

newmerged <- mergedparams[order(mergedparams$subjectId,mergedparams$activityCode),]


#print("merging original data sets")
#mergeIS()
library(plyr)
cleaned <-  ddply(newmerged,c("subjectId","activityCode"), function(df) colMeans(df[,(3:68)]))
print("Writing out the data fils")
write.table(cleaned, file="UCI_HAR_Dataset-cleaned.txt", row.name=FALSE)
print("Finished")
