---
title: "Transformation Process"
author: "Ernest Jum"
date: "11/12/2016"
output: html_document
---

# Data Processing Steps
The R script, run_analysis.R, does the following:

1. Download the dataset if it does not already exist in the working directory
2. Load the activity and feature info
3. Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
4. Loads the activity and subject data for each dataset, and merges those columns with the dataset
6. Merges the two datasets
7. Converts the activity and subject columns into factors
8. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
The end result is shown in the file cleanDataSet.txt.

# How run_analysis.R executes the above transformations

## Required LIbraries
The libraries used in the R Script are data.table and dplyr and the library is loaded at the commencement of the script
## Loading of Supporting Metadata

The metadata is loaded into variables feature_data and activity_data and are referenced later in the script to update the data labels

## Reading Training and Test Data

The data for the training and test sets are split up into three specific sections being subject, activity and features. Each of these are in different folders and files.
The data is then loaded into files for each of the sections based on Training and Test and then this is merged into a single data file for each section.
In the merged file the columns are named using the meta data that was previously loaded 

## Extract measurement for Means and Standard Deviation

The use of the grep command is used to filter columns that contain Mean or Std. 

## Assigning Descriptive Names

Through the use of the gsub command to replace assigned names with more descriptive and friendly names to make the data set easy to use and in preparation for exporting as a tidy data set.

## Export data to new Data Set

A variable is created called finaDataSet as a data set with average for each activity and subject. Then the entries are ordered and then written out as data file cleanDataSet.txt that contains the processed data.



