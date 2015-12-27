#1. Merges the training and the test sets to create one data set.
install.packages("lme4")
require(lme4)
#setwd("~/Desktop")
subtest <- read.table("~/Desktop/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
xtest <- read.table("~/Desktop/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
ytest <- read.table("~/Desktop/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
subtrain <- read.table("~/Desktop/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
xtrain <- read.table("~/Desktop/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
ytrain <- read.table("~/Desktop/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")

Xtesttrain <- rbind(xtest, xtrain)

#2. Extracts only the measurements on the mean and standard deviation for each measurment.
#3. Uses descriptie activity names to name the activities in the data set.
#The column numbers that include mean or std are 
#1:6, 41:46, 81:86, 121:126, 161:166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 
#266:271, 345:350, 424:429, 503, 504, 529, 530
meanstdcol <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266:271, 345:350, 424:429, 503, 504, 529, 530)
Xmeanstd_test_train <- Xtesttrain[, meanstdcol]

#4. Appropriately labels the data set with descriptive variable names
featuretxt <- read.table("~/Desktop/UCI HAR Dataset/features.txt", quote="\"", comment.char="")
featuremeanstd <- t(featuretxt)[, meanstdcol]
Xmeanstdlabel <- rbind(featuremeanstd[2, ], Xmeanstd_test_train)
colnames(Xmeanstdlabel) = Xmeanstdlabel[1, ]
cleaned <- Xmeanstdlabel[-1, ]

#5. Creates a second independent tidy data set with the average of each variable for each activity and each subject.
subjects <- rbind(subtest, subtrain)
colnames(subjects) = "Subject"

initialdata <- cbind(subjects, cleaned)
ordered_by_sub <- initialdata[order(initialdata$Subject),]
table(oerdered_by_sub$Subject)
#There are 62 variables and 30 subjects.
averages <- function(dataset, n=62){
        results <- matrix(NA, 30, n+1, 
                          dimnames=list(c(), colnames(dataset)))
        results[, 1]=c(1:30)
        number_of_obs <- as.data.frame(table(dataset$Subject))[, 2]
        for(l in 2:(n+1)){
                startsubset <- 1
        for(i in 1:30){
                endsubset <- startsubset+(number_of_obs[i]-1)
                results[i, l] <- mean(as.numeric(dataset[startsubset:endsubset, l]))
                startsubset <- endsubset+1
        }
                }
        finalresult <- data.frame(results)
        finalresult
}

tidydata <- averages(ordered_by_sub)
write.table(tidydata, file="projectdata", row.names=FALSE)


