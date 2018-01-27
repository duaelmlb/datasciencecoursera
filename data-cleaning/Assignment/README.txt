==================================================================
title: "Assignment README file"
author: "Leaud Le Bacq"
date: "1/27/2018"
==================================================================

This assignment is the final project of the coursera course named "Getting and Cleaning Data".
Hereafter are the instructions of the assignments :

======================================
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1)Merges the training and the test sets to create one data set.

2)Extracts only the measurements on the mean and standard deviation for each measurement.

3)Uses descriptive activity names to name the activities in the data set

4)Appropriately labels the data set with descriptive variable names.

5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Good luck!
=========================================

The submitted work contains the following files :

- the present 'README.txt'

- 'final_output.txt': Final tidy data set produced by the script

- 'run_analysis.R' : R script that does all the actions required by the assignment and creates the final tidy data set.

- 'Assignment Codebook.Rmd' : Codebook that details all the variables that are in the columns of the final tidy data set

Notes: 
======

For question 2), I decided to use regular expressions in order to extract all the columns (variables) that were ending by "mean()" or "std()". For me those variables are calculated  by elementary operations on raw data. I decided not to take the variables containing "meanFreq" on purpose.

As it was easier to do so, I treated question 3) and 4) at the same time as question 1)