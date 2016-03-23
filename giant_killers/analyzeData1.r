library(MASS)

rm(list = ls())
load("AIS_train70.RData")

## ## are there any predictors that never occur?
## names(dat4)[sapply(dat4, function(f) all(f == 0))]
## no need to keep those!
dat4 <- dat4[,sapply(dat4, function(f) !all(f == 0))]

candidatePredictors <- names(dat4)[3:ncol(dat4)]

## system.time(unitaryModels <- lapply(dat4[,candidatePredictors], function(f){
##     return(glm(dat4$died ~ f, family = "binomial")$deviance)}))
##save(unitaryModels, file = "unitaryModels.RData")
load("unitaryModels.RData")

qqnorm(unlist(unitaryModels))

## to get something quality in the books, let-s grab those top 4, possibly with interaction
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
