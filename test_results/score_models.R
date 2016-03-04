library('readr')
library('caret')
library('pander')

# load test values
load("test_response.Rds")

# list all csv files in directory
files <- list.files(pattern = "*.csv")

results_df <- data.frame(
  Model = as.character(),
  Accuracy = as.numeric(),
  Sensitivity = as.numeric(),
  Specificity = as.numeric()
)

# for each file
for(f in files) {
  message(paste("Calculating score for", f))
  
  # model name
  model_name <- unlist(strsplit(f, split = ".csv"))
  
  # load each file
  tempfile <- read_csv(f)
  pred_vals <- as.vector(unlist(tempfile[ ,2]))
  # compare to true values
  tt <- table(pred_vals, test_response)
  
  # confusion matrix
  cm <- confusionMatrix(tt)
  
  # report accuracy, sensitivity, specificity
  acc <- cm$overall["Accuracy"]
  sen <- cm$byClass["Sensitivity"]
  spe <- cm$byClass["Specificity"]
  
  # save to dataframe
  out <- data.frame(Model = model_name, Accuracy = acc, Sensitivity = sen, Specificity = spe)
  results_df <- rbind(results_df, out)
}



# order results and save as csv
results_df <- results_df[order(results_df$Accuracy), ]
write_csv(results_df, path = paste0("../statsathon_results_", Sys.Date(), ".csv"))

# format and save as md table
rownames(results_df) <- as.character(results_df[ , "Model"])
results_df <- results_df[ , -1]

# save as markdown table and csv
pout <- pandoc.table.return(results_df)
cat(pout, file = paste0("../statsathon_results_", Sys.Date(), ".md"))
