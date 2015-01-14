complete <- function(directory, id=1:332){
  files_list <- list.files(directory, full.names=TRUE)
  data <- data.frame()
  for (i in id){
    data <- rbind(data, read.csv(files_list[i]))
  }
  x <- 0
  y <- 1  
  while(y <= length(id)){
      x <- id[y]
      nobs[y] <- sum(complete.cases(data[which(data[,"ID"]==x),]))
    y<- y+1
    x <- id[y]
    }
  
    output<- data.frame(id= id, nobs=nobs)
  output
}
## this is working, but the loop overwrites the nobs file, causing it to only 

  