# Load Libraries
library(tidyverse)
library(caret)
library(fastDummies)
library(glmnet)
library(rpart)
library(randomForest)
library(neuralnet)
library(arules)
library(cluster)

# Load Data
data <- read.csv("hospital_readmissions.csv")

# Preprocessing
data <- data[!is.na(data$readmitted), ]  # Remove rows with missing target

# Handle missing data
for (col in colnames(data)) {
  if (is.numeric(data[[col]])) {
    data[[col]][is.na(data[[col]])] <- median(data[[col]], na.rm = TRUE)
  } else {
    data[[col]][is.na(data[[col]])] <- names(sort(table(data[[col]]), decreasing = TRUE))[1]
  }
}

# Convert target to binary
data$readmitted <- ifelse(data$readmitted == "yes", 1, 0)

# Transform categorical to dummy variables
data <- dummy_cols(data, remove_selected_columns = TRUE)

# Normalize numerical data
normalize <- function(x) {(x - min(x)) / (max(x) - min(x))}
data <- as.data.frame(lapply(data, function(col) if (is.numeric(col)) normalize(col) else col))

# Partition data
set.seed(123)
index <- createDataPartition(data$readmitted, p = 0.6, list = FALSE)
train <- data[index, ]
valid <- data[-index, ]

# Logistic Regression
logit_model <- glm(readmitted ~ ., data = train, family = "binomial")
logit_pred <- predict(logit_model, valid, type = "response")
logit_class <- ifelse(logit_pred > 0.5, 1, 0)
confusionMatrix(as.factor(logit_class), as.factor(valid$readmitted))

# Lasso Regression
x <- model.matrix(readmitted ~ ., train)[,-1]
y <- train$readmitted
lasso_model <- cv.glmnet(x, y, alpha = 1, family = "binomial")
x_valid <- model.matrix(readmitted ~ ., valid)[,-1]
lasso_pred <- predict(lasso_model, newx = x_valid, s = "lambda.min", type = "response")
lasso_class <- ifelse(lasso_pred > 0.5, 1, 0)
confusionMatrix(as.factor(lasso_class), as.factor(valid$readmitted))

# Decision Tree
tree_model <- rpart(readmitted ~ ., data = train, method = "class")
tree_pred <- predict(tree_model, valid, type = "class")
confusionMatrix(tree_pred, as.factor(valid$readmitted))
rpart.plot::rpart.plot(tree_model)

# Random Forest
rf_model <- randomForest(as.factor(readmitted) ~ ., data = train, ntree = 100)
rf_pred <- predict(rf_model, valid)
confusionMatrix(rf_pred, as.factor(valid$readmitted), positive = "1")

# Neural Network
train$readmitted <- as.numeric(train$readmitted)
valid$readmitted <- as.numeric(valid$readmitted)
nn_model <- neuralnet(readmitted ~ ., data = train, hidden = 5, linear.output = FALSE)
nn_pred <- compute(nn_model, valid[, -which(names(valid) == "readmitted")])$net.result
nn_class <- ifelse(nn_pred > 0.5, 1, 0)
confusionMatrix(as.factor(nn_class), as.factor(valid$readmitted))

# Clustering
kmeans_model <- kmeans(scale(data[, -which(names(data) == "readmitted")]), centers = 3)
table(kmeans_model$cluster)

# Association Rules (discretize for arules)
data_discrete <- as(data.frame(lapply(data, as.factor)), "transactions")
rules <- apriori(data_discrete, parameter = list(supp = 0.01, conf = 0.8))
inspect(head(rules, by = "lift"))