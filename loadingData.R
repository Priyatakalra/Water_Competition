training <- read.csv('./Data/training_set.csv', na.strings = c("NA",""))
labels <- read.csv('./Data/training_labels.csv', na.strings = c("NA","")) 
testing <- read.csv('./Data/test_set.csv', na.strings = c("NA",""))


training$date_recorded <- as.Date(training$date_recorded)
training$public_meeting <- as.logical(training$public_meeting)
training$permit <- as.logical(training$permit)


testing$date_recorded <- as.Date(testing$date_recorded)
testing$public_meeting <- as.logical(testing$public_meeting)
testing$permit <- as.logical(testing$permit)

save.image("./Data/data_all.RData")