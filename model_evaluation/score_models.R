library('readr')
library('caret')

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
  cm <- confusionMatrix(tt, positive = "1")
  
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

# custom formatting for github markdown
cat(paste0("|", "    &nbsp;    ", "|  ", colnames(results_df)[1], "  |  ", colnames(results_df)[2], "  |  ", colnames(results_df)[3], "  |  \n",
    "| ------------ | ---------- | ------------- | ------------- | \n"), file = "README.md", append = FALSE)

for(row in 1:nrow(results_df)) {
  # append to table
  cat(paste0("| ", "**", rownames(results_df)[row], "** |   ",
             round(results_df[row, "Accuracy"], 4), "   |    ",
             round(results_df[row, "Sensitivity"], 4), "     |      ",
             round(results_df[row, "Specificity"], 4), "   | \n"),
      file = "README.md", append = TRUE)
}
