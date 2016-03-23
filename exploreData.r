length(dat3 <- readLines("AIS_train70.csv"))
dat3[1] # looks like headers
Headers <- dat3[1]
length(Headers <- unlist(strsplit(dat3[1], split = ",")))
head(Headers) # key, outcome, independent variables
tail(Headers)
identical(grep("AIS", Headers), 3:length(Headers)) # 1230 predictors, all prefixed AIS
dat3[2] # data
dat3[174672] # data in the last line

dim(dat4 <- read.csv("AIS_train70.csv"))

foo <- names(dat4)
foo[1:2]
bar <- as.numeric(sub("AIS", "", foo[3:1232]))
range(bar); diff(range(bar))
identical(order(bar), 1:1230) # their names are ordered but incomplete

save(dat4, file = "AIS_train70.RData")
