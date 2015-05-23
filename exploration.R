#basic summary
summary(training)
#Are there NA's ---> 46094
sum(is.na(training))
#plot everything against everything --> too big
pairs(training[sample(1:nrow(training),1000),])

#removing data --> short version further down
colnames(training)

#[1] "id"                    "amount_tsh"            "date_recorded"         "funder"               
#[5] "gps_height"            "installer"             "longitude"             "latitude"             
#[9] "wpt_name"              "num_private"           "basin"                 "subvillage"           
#[13] "region"                "region_code"           "district_code"         "lga"                  
#[17] "ward"                  "population"            "public_meeting"        "recorded_by"          
#[21] "scheme_management"     "scheme_name"           "permit"                "construction_year"    
#[25] "extraction_type"       "extraction_type_group" "extraction_type_class" "management"           
#[29] "management_group"      "payment"               "payment_type"          "water_quality"        
#[33] "quality_group"         "quantity"              "quantity_group"        "source"               
#[37] "source_type"           "source_class"          "waterpoint_type"       "waterpoint_type_group"

#extraction_type*
extraction_type <- as.numeric(training$extraction_type)
extraction_type_group <- as.numeric(training$extraction_type_group)
extraction_type_class <- as.numeric(training$extraction_type_class)
ex <- data.frame(a = extraction_type, b = extraction_type_group, c = extraction_type_class)
plot(ex)
# --> The values always map completely, thus only one column will be needed
training <- training[,-26] #perform two times
testing <- testing[,-26] #perform two times

#source*
source <- as.numeric(training$source)
source_type <- as.numeric(training$source_type)
source_class <- as.numeric(training$source_class)
s <- data.frame(a = source, b = source_type, c = source_class)
plot(s) 
# --> The values always map completely, thus only one column will be needed (first will be kept, but it may be considered to keep another one, since they contain less information)
training <- training[,-35] #perform two times
testing <- testing[,-35] #perform two times

#waterpoint*
waterpoint_type <- as.numeric(training$waterpoint_type)
waterpoint_type_group <- as.numeric(training$waterpoint_type_group)
w <- data.frame(a = waterpoint_type, b = waterpoint_type_group)
plot(w)
# --> The values always map completely, thus only one column will be needed (first will be kept, but it may be considered to keep another one, since they contain less information)
training <- training[,-36] 
testing <- testing[,-36] 

#recorded_by has only one value
levels(training$recorded_by)
training <- training[,-20] 
testing <- testing[,-20] 

#management*
management <- as.numeric(training$management)
management_group <- as.numeric(training$management_group)
m <- data.frame(a = management, b = management_group)
plot(m)
# --> The values always map completely, thus only one column will be needed (first will be kept, but it may be considered to keep another one, since they contain less information)
training <- training[,-26] 
testing <- testing[,-26] 

#payment*
payment <- as.numeric(training$payment)
payment_type <- as.numeric(training$payment_type)
p <- data.frame(a = payment, b = payment_type)
plot(p)
# --> The values always map completely, thus only one column will be needed (first will be kept, but it may be considered to keep another one, since they contain less information)
training <- training[,-27] 
testing <- testing[,-27]

#quantity*
quantity <- as.numeric(training$quantity)
quantity_group <- as.numeric(training$quantity_group)
q <- data.frame(a = quantity, b = quantity_group)
plot(q)
# --> The values always map completely, thus only one column will be needed (first will be kept, but it may be considered to keep another one, since they contain less information)
training <- training[,-30] 
testing <- testing[,-30] 


lvls <- sapply(sapply(training, levels), length)
lvls[which(lvls > 0)]


#removing data
require(caret)
training_withLabels <- merge(training, labels, by.y = 'id')
training_withLabels$row.names <- NULL
training_withLabels$id <- NULL
training_withLabels$recorded_by <- NULL
training_withLabels$extraction_type_group <- NULL
training_withLabels$extraction_type_class <- NULL
training_withLabels$management_group <- NULL
training_withLabels$payment_type <- NULL
training_withLabels$quantity_group <- NULL
training_withLabels$quality_group <- NULL
training_withLabels$source_type <- NULL
training_withLabels$source_class <- NULL
training_withLabels$waterpoint_type_group <- NULL
train <- createDataPartition(training_withLabels$status_group, p = 0.6, list = F)
trainingSet <- training_withLabels[train,]
validationSet <- training_withLabels[-train,]
