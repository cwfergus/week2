corr <- function(directory, threshold=0){
  files_list <- list.files(directory, full.names=TRUE)
  data <- data.frame()
  for (i in 1:threshold){
    data <- rbind(data, read.csv(files_list[i]))
  }
  data_comp <- data[complete.cases(data),]
  cr <- cor(data_comp[,"nitrate"], data_comp[,"sulfate"])
  cr
}

## this isn't giving me what I want, because it is calling the first 150 files
## should be the first 150 complete cases makes the threshold!
corr <- function(directory, threshold=0){
  files_list <- list.files(directory, full.names=TRUE)
  data <- data.frame()
  for (i in 1:threshold){
    data <- rbind(data, read.csv(files_list[i]))
  }
  data_comp <- data[complete.cases(data),]
  thres_data <- data_comp[1:150,]
  cr <- cor(thres_data[,"nitrate"], thres_data[,"sulfate"])
  cr
}
## still not working because: It has to test the MONITORS
## ie monitors must have above the threshold number of complete cases, to be included in the correlation

## here is how to just get one of them:
files_list <- list.files(directory, full.names=TRUE)
data <- data.frame()
data <- rbind(data, read.csv(files_list[2]))
data_comp <- data[complete.cases(data),] ## this line will be taken care of when doing multiple I think
cr <- cor(thres_data[,"nitrate"], thres_data[,"sulfate"])

## so here is what we need to do:
## 1) Evaluate each file for meeting the threshold of complete cases( use complete.R for this)
## 2) Take the above threshold files and get the cor value for all of them, idividually
## 3) put each of these values into an object, using the subset with a loop i think
## 3) get it to return those values, enabling a vector with multiple entries

corr <- function(directory, threshold=0){
  comp_list <- complete(directory, 1:332)
  for (i in 1:332) {
    if (comp_list[i,"nobs"]>= threshold){ ## something is wrong in this if statement
      abv_thres <- read.csv(files_list[i])
      corr_values[i] <- cor(abv_thres[,"sulfate"], abv_thres[,"nitrate"])
      }
    }
}
