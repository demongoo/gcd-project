# Script creates tidy dataset from raw UCI HAR Dataset
# Assumption is that download.R has been run and data
# is present under data directory

DATA_DIR <- './data'
UCI_DIR <- paste(DATA_DIR, "UCI HAR Dataset", sep = "/")

# loads dataset and attaches activity lables and subject ids
load.dataset <- function(id) {
  dir <- paste(UCI_DIR, id, sep = "/")
  name.main <- paste("X_", id, ".txt", sep = "")
  name.subj <- paste("subject_", id, ".txt", sep = "")
  name.act <- paste("y_", id, ".txt", sep = "")
  ds.names <- gsub("-", ".", gsub("\\(\\)", "", read.table(paste(UCI_DIR, "features.txt", sep = "/"))[, 2]))
  
  # loading main dataset
  main <- read.table(
    paste(dir, name.main, sep = "/"),
    colClasses = rep("numeric", 561),
    col.names = ds.names
  )
  
  # extracting only means and stds to reduce futher memory usage and computation time
  ds <- main[, c(
    # 5 variables by X, Y, Z and mean, std
    as.vector(sapply(0:4, function(i) { i * 40 + 1:6 })),
    # 5 variables by mean, std
    as.vector(sapply(0:4, function(i) { 200 + i * 13 + 1:2 })),
    # 3 variables by X, Y, Z and mean. std
    as.vector(sapply(0:2, function(i) { 265 + i * 79 + 1:6 })),
    # 4 variables by mean, std
    as.vector(sapply(0:3, function(i) { 502 + i * 13 + 1:2 }))
  )]
  
  # free memory
  rm(main)
  
  # activity labels
  alabels <- read.table(paste(UCI_DIR, "activity_labels.txt", sep = "/"))[, 2]
  
  # attach subject and activity labels
  ds$activity <- sapply(
    read.table(paste(dir, name.act, sep = "/"), colClasses = c("integer"))[, 1],
    function(i) { alabels[i] }
  )
  ds$subject <- read.table(paste(dir, name.subj, sep = "/"), colClasses = c("integer"))[, 1]
  
  ds
}

# loads training and test datasets and merging
ds <- rbind(load.dataset("train"), load.dataset("test"))