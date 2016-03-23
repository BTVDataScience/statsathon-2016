library('readr')
library('Matrix')
library('dplyr')
library('caret')
library('glmnet')

# load data
train_dat <- read_csv("AIS_train70.csv")
train_dat$INC_KEY <- as.character(train_dat$INC_KEY)
test_dat <- read_csv("AIS_test30.csv")

# remove invariant columns
col_sums <- colSums(train_dat)
zero_cols <- which(col_sums == 0)
train_dat <- train_dat[ ,-zero_cols]

# drop key
train_dat <- select(train_dat, -INC_KEY)

# create data partition
trainIndex <- createDataPartition(train_dat$died, p = 0.8, list = FALSE,
                                       times = 1)
train_partition <- train_dat[trainIndex, ]
test_partition <- train_dat[-trainIndex, ]

# logistic regression using [GLMnet](http://web.stanford.edu/~hastie/glmnet/glmnet_alpha.html#log)

train_x <- train_partition[ , 2:ncol(train_partition)]
train_y <- train_partition$died

test_x <- test_partition[ , 2:ncol(test_partition)]
test_y <- test_partition$died

glmnet1 <- glmnet(x = as.matrix(train_x), y = as.factor(train_y), family = "binomial")
print(glmnet1)
plot(glmnet1)

# examine coefs at different lambdas
coef(glmnet1, s = 9.432e-03) # df = 10
coef(glmnet1, s = 2.564e-03) # df = 112
coef(glmnet1, s = 5.273e-04) # df = 525
coef(glmnet1, s = 9.003e-05) # df = 1016

# cross-validation
# http://stackoverflow.com/questions/8457624/r-glmnet-list-object-cannot-be-coerced-to-type-double
#cvfit <- glmnet::cv.glmnet(X, y)
#coef(cvfit, s = "lambda.1se")

# predict
glmnet1_pred <- predict(glmnet1, newx = as.matrix(test_x), 
                        type = "class", 
                        s = c(9.432e-03, 2.564e-03, 5.273e-04,
                              9.003e-05))

# how many 'died' for each lambda?
apply(glmnet1_pred, 2, function(x) sum(as.numeric(x)))

# compare to truth
t1 <- table(glmnet1_pred[ , 1], test_y)
confusionMatrix(t1, positive = "1")

t2 <- table(glmnet1_pred[ , 2], test_y)
confusionMatrix(t2, positive = "1")

t3 <- table(glmnet1_pred[ , 3], test_y)
confusionMatrix(t3, positive = "1")

t4 <- table(glmnet1_pred[ , 4], test_y)
confusionMatrix(t4, positive = "1")


### caret train
eGrid <- expand.grid(.alpha = (1:10) * 0.1, 
                     .lambda = (1:10) * 0.1)

Control <- trainControl(method = "repeatedcv", repeats = 3, verboseIter =TRUE)

netFit <- train(x = as.matrix(train_x), 
                y = as.factor(train_y),
                method = "glmnet",
                family = "binomial",
                tuneGrid = eGrid,
                trControl = Control)


## Finding lambda.min following 
## http://web.stanford.edu/~hastie/glmnet/glmnet_alpha.html#log

cvfit <- cv.glmnet(as.matrix(train_x), as.factor(train_y), family = "binomial", 
                   type.measure = "class")

plot(cvfit)
cvfit$lambda.min
coef(cvfit, s = "lambda.min")
cvfit_pred <- predict(cvfit, newx = as.matrix(test_x), s = "lambda.min", type = "class")

sum(as.numeric(cvfit_pred))

## predictions for test set
test_pred <- predict(cvfit, newx = as.matrix(test_dat[,2:1231]), s = "lambda.min", type = "class")
## save test set predictions
pred_out <- data.frame(INC_KEY = test_dat[,"INC_KEY"],
                       pred = as.numeric(test_pred))

write_csv(pred_out, path = "glmnet_preds.csv", col_names = TRUE)
                       
                       
