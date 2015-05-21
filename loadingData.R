training <- read.csv('./Data/training_set.csv', stringsAsFactors = F)
labels <- read.csv('./Data/training_labels.csv', stringsAsFactors = F) 
testing <- read.csv('./Data/test_set.csv', stringsAsFactors = F)
save.image("./Data/data_all.RData")

