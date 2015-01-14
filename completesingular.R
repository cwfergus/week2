complete <- function(directory, id=1:332){
  files_list <- list.files(directory, full.names=TRUE)
  data <- data.frame()
  for (i in id){
    data <- rbind(data, read.csv(files_list[i]))
  }
  output<- data.frame(id= id, nobs=sum(complete.cases(data)))
  output
}
