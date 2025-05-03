install.packages(c("caret", "e1071", "randomForest", "caTools"))
library(dplyr)
library(ggplot2)
library(caret)
library(e1071)
library(randomForest)
library(caTools)
loandata <- read_excel("D:/loan_prediction.csv.xlsx")
str(loandata)
summary(loandata)
#missing values
colSums(is.na(loandata))
print(head(loandata))
print(tail(loandata))
str(loandata)
summary(loandata)

#structure
dim(loandata)
names(loandata)

#filter data
subset(loandata,Education>4)
loandata[,c("Gender","Education")]

#sorting
loandata[order(loandata$Loan_ID,decreasing = TRUE),]

#plot
library(ggplot2)
ggplot(loandata,aes(x=Loan_Amount_Term))+geom_histogram(binwidth=0.5,fill="steelblue",color="black")


# Loan approval count
ggplot(loandata, aes(Loan_Status)) +
  geom_bar(fill = "steelblue") +
  labs(title = "Loan Status Distribution")

# Loan approval by gender
ggplot(loandata, aes(Gender, fill = Loan_Status)) +
  geom_bar(position = "fill") +
  labs(title = "Loan Approval by Gender", y = "Proportion")

# Loan amount by education
ggplot(loandata, aes(Education, LoanAmount)) +
  geom_boxplot(fill = "orange") +
  labs(title = "Loan Amount by Education")

# Load dataset
loandata <- read.csv("D:/loan_prediction.csv", stringsAsFactors = FALSE)

# Check missing values
colSums(is.na(loandata))

# Function to calculate mode
fill_mode <- function(x) {
  ux <- unique(x[!is.na(x)])
  ux[which.max(tabulate(match(x, ux)))]
}

# Fill NAs with mode for categorical columns
loandata$Gender[is.na(loandata$Gender)] <- fill_mode(loandata$Gender)
loandata$Married[is.na(loandata$Married)] <- fill_mode(loandata$Married)
loandata$Dependents[is.na(loandata$Dependents)] <- fill_mode(loandata$Dependents)
loandata$Self_Employed[is.na(loandata$Self_Employed)] <- fill_mode(loandata$Self_Employed)
loandata$Credit_History[is.na(loandata$Credit_History)] <- fill_mode(loandata$Credit_History)

# Fill NAs with median for numeric columns
loandata$LoanAmount[is.na(loandata$LoanAmount)] <- median(loandata$LoanAmount, na.rm = TRUE)
loandata$Loan_Amount_Term[is.na(loandata$Loan_Amount_Term)] <- median(loandata$Loan_Amount_Term, na.rm = TRUE)

# View summary after cleaning
summary(loandata)

# Drop Loan_ID (not needed)
loandata <- loandata[, -1]

# Convert Loan_Status to binary factor (1 = Y, 0 = N)
loandata$Loan_Status <- ifelse(loandata$Loan_Status == "Y", 1, 0)
loandata$Loan_Status <- as.factor(loandata$Loan_Status)
print(loandata$Loan_Status)


set.seed(123)
split <- sample.split(loandata$Loan_Status, SplitRatio = 0.7)
train <- subset(loandata, split == TRUE)
test <- subset(loandata, split == FALSE)
str(train)

colSums(is.na(train))
train<-na.omit(train)
test<-na.omit(test)
train[] <- lapply(train, function(x) if(is.character(x)) as.factor(x) else x)
test[] <- lapply(test, function(x) if(is.character(x)) as.factor(x) else x)
train$Loan_Status <- as.factor(train$Loan_Status)
test$Loan_Status <- as.factor(test$Loan_Status)
library(randomForest)
# Load necessary libraries
install.packages("caret")
library(caret)

# Create a synthetic dataset with two classes
set.seed(42)
loandata <- twoClassSim(1000)  # 1000 samples, 2 classes

# Split the dataset into training and testing sets (80-20 split)
trainIndex <- createDataPartition(loandata$Class, p = .8, list = FALSE)
train <- loandata[trainIndex, ]
test <- loandata[-trainIndex, ]

# Train a classification model using Random Forest
model <- train(Class ~ ., data= train, method = "rf")

# Make predictions on the test set
predictions <- predict(model, test)

# Evaluate the model's accuracy
confusionMatrix(predictions, test$Class)
