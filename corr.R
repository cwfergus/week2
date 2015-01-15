corr <- function(directory, threshold=0){
  comp_list <- complete(directory, 1:332)
  files_list <- list.files(directory, full.names=TRUE)
  corr_values_NA<- vector(mode="numeric")
  abv_thres <- data.frame(date=NA, sulfate=NA, nitrate=NA, ID=NA)## what if I make this the exact same as a potentail file
  for (i in 1:332) {
    if (comp_list[i,"nobs"]> threshold){ ## oh oh I just removed the <= sign...!! 
      abv_thres <- read.csv(files_list[i])
      if (is.na(abv_thres[1,4]) != TRUE) { 
        corr_values_NA[i] <- cor(abv_thres[,"sulfate"], abv_thres[,"nitrate"], use="complete.obs")
      }
    }
  }
  corr_values <- corr_values_NA[which(is.na(corr_values_NA) != TRUE)]
  corr_values
} 

## it works it works halelua!

