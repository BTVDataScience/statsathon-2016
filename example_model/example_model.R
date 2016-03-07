# R script to generate example model for BTV statsathon 

# load training and test data
ais_data_test30 <- read_csv("AIS_test30.csv")
ais_data_train70 <- read_csv("AIS_train70.csv")

# Simplest possible model --
# random binomial response

# frequency of 'died' in training data
freq_died <- length(which(ais_data_train70$died==1)) / length(ais_data_train70$died)

# random binomial response vector for length of test data
test1 <- rbinom(n = nrow(ais_data_test30), size = 1, prob = freq_died)

# convert to data.frame and save results to the 'model_evaluation' directory
test1_df <- data.frame(ais_data_test30$INC_KEY, pred = test1)

write_csv(test1_df, path = "../model_evaluation/example1.csv")
