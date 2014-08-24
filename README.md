This repo contains the following:
This file (README.md)
run_analysis.R the R script that generates the final tidy data set
CodeBook.md describes the data and its transformations.

It is necessary to have the data unzipped in the directory that the R script above is resident.
Output of an ls shows:
CodeBook.md
getdata%2Fprojectfiles%2FUCI HAR Dataset.zip
Human+Activity+Recognition+Using+Smartphones
README.md
run_analysis.R
UCI_HAR_Dataset
UCI_HAR_Dataset-cleaned.txt

The data is sourced from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

R is started in this directory and the R file is sourced and the file UCI_HAR_Dataset-cleaned.txt is created.
The script prints progress messages as it works:

% R

R version 3.1.1 (2014-07-10) -- "Sock it to Me"
Copyright (C) 2014 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Previously saved workspace restored]

> source("run_analysis.R")
[1] "Data cleaning of UCI_HAR_Dataset"
[1] "reading the headings for summary data"
[1] "Reading derived data sets for train and test"
[1] "Reading the activity types for train and test"
[1] "Selecting the columns to use from data set"
[1] "creating the final data frame containing the subject, activity and measurements"
[1] "Reading subject key files (train and test)"
[1] "Writing out the data fils"
[1] "Finished"
> 




