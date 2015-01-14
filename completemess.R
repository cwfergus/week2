complete <- function(directory, id=1:332){
  files_list <- list.files(directory, full.names=TRUE)
  data <- data.frame()
  
  for (i in id){
    data <- rbind(data, read.csv(files_list[i]))
  }
  comp1 <- sum(complete.cases(which(data[,"ID"]==1)))
  output<- data.frame(id= id, nobs=comp1)
  output
}


comp_subset <- data[which(data[,"ID"]==2),]