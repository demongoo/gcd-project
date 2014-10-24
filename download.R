# Script downloads course project dataset UCI HAR Dataset, look article for details:
# http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/

# creating directory for data
if (!file.exists("./data")) {
  dir.create("./data")
}

# downloading zip archive
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./data/UCI HAR Dataset") & !file.exists("./data/data.zip")) {
  download.file(URL, destfile = "./data/data.zip", mode = "wb")
  unzip("./data/data.zip", exdir = './data')
  file.remove("./data/data.zip")
}