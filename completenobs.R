complete <- function(directory, id=1:332){
  files_list <- list.files(directory, full.names=TRUE)
  data <- data.frame()
  for (i in id){
    data <- rbind(data, read.csv(files_list[i]))
  }
  nob1 <- sum(complete.cases(data[which(data[,"ID"]==id[1]),]))
  nob2 <- sum(complete.cases(data[which(data[,"ID"]==id[2]),]))
  output<- data.frame(id= id, nobs=sum(complete.cases(data)))
  output
}