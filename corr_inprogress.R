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
  comp_list <- complete(directory, 1:10)
  files_list <- list.files(directory, full.names=TRUE)
  corr_values<- vector(mode="numeric")
  for (i in 1:10) {
    if (comp_list[i,"nobs"]>= threshold){ ## something is wrong in this if statement
      abv_thres <- read.csv(files_list[i])
      corr_values[i] <- cor(abv_thres[,"sulfate"], abv_thres[,"nitrate"], use="complete.obs")
      } else {
        print("that didn't work")
      }
    }
  corr_values
}

## seems like my if statmetn isn't working. I'm going to try to just run a simple *if*
## to test my ability to write *if* statements

if (comp_list[1,"nobs"]>= threshold){
  print("I should use this file")
} else {
  print("this file is shit")
}

if (comp_list[i,"nobs"] >= threshold) {
  abv_thres <- read.csv(files_list[i])
  corr_values[i] <- cor(abv_thres[,"sulfate"], abv_thres[,"nitrate"])
} else
  
  ## okay the corr function appears to work except for one flaw: it returns NA's
  ## for values that don't match. This occurs because it reads in within the if,
  ## what if I take the cor out of the original for and do another loop, using just
  ## the correct ID numbers.
  
  corr <- function(directory, threshold=0){
    comp_list <- complete(directory, 1:10)
    files_list <- list.files(directory, full.names=TRUE)
    corr_values<- vector(mode="numeric")
    abv_thres <- data.frame(mode="numeric")
    for (i in 1:10) {
      if (comp_list[i,"nobs"]>= threshold){ ## something is wrong in this if statement
        abv_thres[i] <- read.csv(files_list[i])
        if (abv_thres[i]!= NA) {
          i <- i-1
          corr_values[i] <- cor(abv_thres[,"sulfate"], abv_thres[,"nitrate"], use="complete.obs")
          i <- i+1
        }
      } else {
        print("that didn't work")
      }
    }
    for (i in 1:10)
    corr_values
  }

## It seems I have hit a road block. I think perhaps I need to do the inital loop differntly
## so I am going to try to first, determine which ID's are above threshold
## take those that are now above threshold, and read into a new list of ID's
## that the new list and read into abv_thres hold file
## make the corr values with the new abv_thres file

## hold on trying something else first... What if I don't subset abv_thres. I don't
## care if is overwritten because it gets used immediatly.
corr <- function(directory, threshold=0){
  comp_list <- complete(directory, 1:10)
  files_list <- list.files(directory, full.names=TRUE)
  corr_values<- vector(mode="numeric")
  abv_thres <- data.frame(date=NA, sulfate=NA, nitrate=NA, ID=NA)## what if I make this the exact same as a potentail file
  for (i in 1:10) {
    if (comp_list[i,"nobs"]>= threshold){
      abv_thres <- read.csv(files_list[i])
      if (abv_thres[i]!= NA) { ## AHA! this expression can't work
        i <- i-1
        corr_values[i] <- cor(abv_thres[,"sulfate"], abv_thres[,"nitrate"], use="complete.obs")
        i <- i+1
      }
    } else {
      print("that didn't work")
    }
  }
  for (i in 1:10)
    corr_values
}

## lets fix that if expression

corr <- function(directory, threshold=0){
  comp_list <- complete(directory, 1:332)
  files_list <- list.files(directory, full.names=TRUE)
  corr_values<- vector(mode="numeric")
  abv_thres <- data.frame(date=NA, sulfate=NA, nitrate=NA, ID=NA)## what if I make this the exact same as a potentail file
  for (i in 1:332) {
    if (comp_list[i,"nobs"]>= threshold){
      abv_thres <- read.csv(files_list[i])
      if (is.na(abv_thres[1,4]) != TRUE) { ## AHA! this expression can't work
        i <- i-1
        corr_values[i] <- cor(abv_thres[,"sulfate"], abv_thres[,"nitrate"], use="complete.obs")
        i <- i+1
      }
    } else {
      print("that didn't work")
    }
  }
    corr_values
}

## the above works, but places NA's at IDs that don't pass threshold
## so this is going to have to be rewritten, although it works in theory


corr_values[i] <- cor(abv_thres[,"sulfate"], abv_thres[,"nitrate"], use="complete.obs")