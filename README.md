Coursera: Getting and Cleaning Data course project
--------------------------------------------------

Repository contains two scripts:

* `download.R` - downloads and unpacks raw dataset into `data` directory (if you have dataset already, analysis script
  expects to find raw data under `working directory/data/UCI HAR Dataset` directory)
* `run_analysis.R` - merges test and training datasets, subsets measurements to mean and std attributes, calculates
  average measurement for each `activity ~ subject` pair. Saves tidy data into `data/dataset-tidy.txt`.