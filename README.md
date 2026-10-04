# Course-Projects
# Hospital Readmissions Prediction Project
A machine learning project that predicts whether a diabetic patient will be readmitted to the hospital using several supervised learning models in R.

# Project Overview
This project analyzes hospital patient data to predict 30-day readmission risk (readmitted: yes/no). It applies preprocessing, train/test splitting, and four classification models, then evaluates them with confusion matrices.

# Data
- Source file: hospital_readmissions.csv (or the provided Excel version)
- Target variable: readmitted (binary: yes/no)

Features include:
- Demographics: age
- Utilization: time_in_hospital, n_lab_procedures, n_procedures, n_medications, n_outpatient, n_inpatient, n_emergency
- Clinical: medical_specialty, diag_1, diag_2, diag_3
- Lab/medication: glucose_test, A1Ctest, change, diabetes_med

# Models Implemented
- Logistic Regression (glm with binomial family)
- Decision Tree (rpart + visualization with rpart.plot)
- Neural Network (neuralnet with 5 hidden nodes)
- Random Forest (randomForest with 500 trees)

All models are trained on a 60% training set and evaluated on the held-out 40% test set using caret::confusionMatrix.

# Requirements
Rinstall.packages(c("caret", "tidyverse", "neuralnet", "randomForest", "rpart", "rpart.plot"))

# How to Run
- Place hospital_readmissions.csv in the working directory (or convert the Excel file to CSV).
- Open and source Hospital Readmissions Project.R.

The script will:
- Impute missing values (median), center, and scale the data
- Split into train/test (seed = 123)
- Fit the four models
- Print confusion matrices for each
- Plot the decision tree

# Notes / Known Issues in the Script
- Column name inconsistency: the data uses readmitted, but some model calls reference readmission. Align these before running.
- Neural net section converts the target to 0/1; ensure factor levels match when creating the final class predictions.
- The Excel file is large; convert it to CSV for faster loading with read.csv.
