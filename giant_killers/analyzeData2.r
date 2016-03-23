library(MASS)

rm(list = ls())

## length(dat3 <- readLines("AIS_train70.csv"))
## dat3[1] # looks like headers
## Headers <- dat3[1]
## length(Headers <- unlist(strsplit(dat3[1], split = ",")))
## head(Headers) # key, outcome, independent variables
## tail(Headers)
## identical(grep("AIS", Headers), 3:length(Headers)) # 1230 predictors, all prefixed AIS
## dat3[2] # data
## dat3[174672] # data in the last line

## dim(dat4 <- read.csv("AIS_train70.csv"))

## save(dat4, file = "AIS_train70.RData")
load("AIS_train70.RData")

foo <- names(dat4)
foo[1:2]
bar <- as.numeric(sub("AIS", "", foo[3:length(foo)]))
range(bar); diff(range(bar))
identical(order(bar), 1:length(bar)) # their names are ordered but incomplete

## are there any predictors that never occur?
names(dat4)[sapply(dat4, function(f) all(f == 0))]
## no need to keep those!
dat4 <- dat4[,sapply(dat4, function(f) !all(f == 0))]

candidatePredictors <- names(dat4)[3:ncol(dat4)]

## system.time(unitaryModels <- lapply(dat4[,candidatePredictors], function(f){
##     return(glm(dat4$died ~ f, family = "binomial")$deviance)}))
##save(unitaryModels, file = "unitaryModels.RData")
load("unitaryModels.RData")

qqnorm(unlist(unitaryModels))

## grab top 4, possibly with interaction
(top4 <- head(sort(unlist(unitaryModels)), n = 4))
dat4b <- dat4[,c("INC_KEY", "died", names(top4))]
fm1 <- glm(died ~ AIS140656, dat4b, family = "binomial")
## system.time(
##     fm1a <- stepAIC(fm1,
##                     scope = list(upper = ~ AIS140656*AIS140202*AIS160214*AIS140684,
##                                  lower = ~ 1),
##                     trace = TRUE)
## )
## save(fm1a, file = "fm1a.RData")
load("fm1a.RData")
summary(fm1a)

## just to get a sense of where I am
plot(x = predict(fm1), y = jitter(dat4$died), xlim = range(c(predict(fm1), predict(fm1a))))
lines(x = sort(predict(fm1)), y = fitted(fm1)[order(predict(fm1))])
points(x = predict(fm1a), y = jitter(dat4$died), col = "blue")
lines(x = sort(predict(fm1a)), y = fitted(fm1a)[order(predict(fm1a))], col = "blue")
## lots of individuals die who were not flagged by this combination of variables

## add a second factor - will it be AIS140656 + AIS140202?
## system.time(twoFactorFms <-
##                 lapply(dat4[,setdiff(candidatePredictors, "AIS140656")], function(f){
##                     return(glm(dat4$died ~ dat4$AIS140656 + f, family = "binomial")$deviance)}))

## save(twoFactorFms, file = "twoFactorFms.RData")
load("twoFactorFms.RData")

qqnorm(unlist(twoFactorFms))

top4
(top3 <-  head(sort(unlist(twoFactorFms)), n = 3))

## concensus top10?
(top10 <- head(sort(unlist(unitaryModels)), n = 10))
identical(names(top10[2:10]),
          names(head(sort(unlist(twoFactorFms)), n = 9)))

## let it run on top 10 overnight
## dat4c <- dat4[,c("INC_KEY", "died", names(top10))]
## fm1 <- glm(died ~ AIS140656 + AIS140202 + AIS160214 + AIS140684 +
##                AIS140656:AIS140684 + AIS140202:AIS140684,
##            dat4c, family = "binomial")
## system.time(
##     fm1b <- stepAIC(fm1,
##                     scope = list(upper = ~
##                                      AIS140656*AIS140202*AIS160214*AIS140684*AIS140678*AIS140666*AIS140650*AIS150206*AIS161000*AIS140210,
##                                  lower = ~ 1),
##                     trace = TRUE)
## )
## save(fm1b, file = "fm1b.RData")
load("fm1b.RData")
summary(fm1b)

## a sense of where I am again
plot(x = predict(fm1a), y = jitter(dat4$died), xlim = range(c(predict(fm1a), predict(fm1b))))
lines(x = sort(predict(fm1a)), y = fitted(fm1a)[order(predict(fm1a))])
points(x = predict(fm1b), y = jitter(dat4$died), col = "blue")
lines(x = sort(predict(fm1b)), y = fitted(fm1b)[order(predict(fm1b))], col = "blue")

## make it top 25 (or so) overnight
par(mfrow = c(1, 2))
topX <- 27
qqnorm(sort(unlist(unitaryModels))[1:topX])
qqnorm(sort(unlist(unitaryModels))[1:length(unitaryModels)])
## I tried 27, 20, 17, 14, 10 ... fourteen didn't break memory, all got used

## dat4d <- dat4[,c("INC_KEY", "died",
##                  "AIS140656",
##                  "AIS140202",
##                  "AIS160214",
##                  "AIS140684",
##                  "AIS140678",
##                  "AIS140666",
##                  "AIS140650",
##                  "AIS150206",
##                  "AIS161000",
##                  "AIS140210",
##                  "AIS140648",
##                  "AIS140660",
##                  "AIS140629",
##                  "AIS140690")]
## fm1b.2 <- glm(died ~ AIS140656 + AIS140202 + AIS160214 + AIS140684 + AIS140678 +
##                   AIS140666 + AIS140650 + AIS150206 + AIS140210 + AIS161000 +
##                   AIS140684:AIS140678 + AIS140656:AIS150206 + AIS140684:AIS140650 + 
##                   AIS140684:AIS140666 + AIS140656:AIS140684 + AIS140650:AIS150206 + 
##                   AIS140202:AIS140210 + AIS140202:AIS140684 + AIS140656:AIS140678 + 
##                   AIS140684:AIS140210,
##               dat4d, family = "binomial")
## system.time(
##     fm1c <- stepAIC(fm1b.2,
##                     scope = list(upper = ~ AIS140656*AIS140202*AIS160214*AIS140684*AIS140678*AIS140666*AIS140650*AIS150206*AIS161000*AIS140210*AIS140648*AIS140660*AIS140629*AIS140690,
##                                  lower = ~ 1))
## )
## save(fm1c, file = "fm1c.RData")
load("fm1c.RData")

## a sense of where I am one more time
par(mfrow=c(1, 1))
plot(x = predict(fm1b), y = jitter(dat4$died), xlim = range(c(predict(fm1b), predict(fm1c))))
lines(x = sort(predict(fm1b)), y = fitted(fm1b)[order(predict(fm1b))])
points(x = predict(fm1c), y = jitter(dat4$died), col = "blue")
lines(x = sort(predict(fm1c)), y = fitted(fm1c)[order(predict(fm1c))], col = "blue")

## I suspect fm1c is overfitted
BIC(fm1b)
BIC(fm1c)

## all right ... that's what I'll use
dat4$predFm1c <- predict(fm1c)
summary(dat4$predFm1c)
dat4$preDied <- ifelse(dat4$predFm1c >= 0, 1, 0)

table(dat4$preDied) ## underpredicting death!
table(dat4$died)
xtabs(~ preDied + died, dat4)

plot(x = dat4$predFm1c, y = jitter(dat4$died))
abline(v = 0)
abline(h = 0.5)
lines(x = dat4$predFm1c[order(dat4$predFm1c)],
      y = plogis(dat4$predFm1c)[order(dat4$predFm1c)],
      col = "blue")

length(unique(dat4$predFm1c))

bar <- data.frame(X = sort(unique(dat4$predFm1c)))
bar$x <- plogis(bar$X)
bar$p <- bar$died <- bar$n <- NA
for(i in 1:nrow(bar)){
    datFocal <- dat4$died[dat4$predFm1c == bar$X[i]]
    bar$n[i] <- length(datFocal)
    bar$died[i] <- sum(datFocal)
    bar$p[i] <- sum(datFocal)/length(datFocal)}
sum(bar$n) == nrow(dat4)
bar

baz <- data.frame(x = seq(0, 0.95, 0.05))
baz$X <- log(baz$x/(1-baz$x))
(baz <- baz[,c("X", "x")])
baz$p <- baz$died <- baz$n <- NA
for(i in 1:(nrow(baz)-1)){
    datFocal <- dat4$died[dat4$predFm1c > baz$X[i] &
                          dat4$predFm1c <= baz$X[i+1]]
    baz$n[i] <- length(datFocal)
    baz$died[i] <- sum(datFocal)
    baz$p[i] <- sum(datFocal)/length(datFocal)}
for(i in nrow(baz)){
    datFocal <- dat4$died[dat4$predFm1c > baz$X[i]]
    baz$n[i] <- length(datFocal)
    baz$died[i] <- sum(datFocal)
    baz$p[i] <- sum(datFocal)/length(datFocal)}
sum(baz$n) == nrow(dat4)
baz

plot(x = dat4$predFm1c, y = jitter(dat4$died))
abline(v = baz$X, col = "gray")
abline(v = 0)
abline(h = 0.5)
lines(x = dat4$predFm1c[order(dat4$predFm1c)],
      y = plogis(dat4$predFm1c)[order(dat4$predFm1c)],
      col = "blue")
lines(x = bar$X, y = bar$p, col = "green")
lines(x = baz$X, y = baz$p, col = "orange")

## load the test data set
dat5 <- read.csv("AIS_test30.csv")
setdiff(names(dat4), names(dat5))
## dat5$predFm1c <- predict(fm1c, newdata = dat5)
## summary(dat5$predFm1c)
dat5$pred <- ifelse(predict(fm1c, newdata = dat5) >= 0, 1, 0)
table(dat5$pred)
dat5 <- dat5[,c(names(dat5)[1], "pred", names(dat5)[2:(ncol(dat5)-1)])]
save(dat5, file = "model_evaluation/giantKillers_pred.csv")
