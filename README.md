# BTV Statsathon 2016

## What

A [Kaggle-esque](https://en.wikipedia.org/wiki/Kaggle) competition for members of the BTV Data Science meetup group. An opportunity to develop your analytical skills, and earn some bragging rights. 

The data consists of 250,000 records, each representing a traumatically injured patient who survived long enough to reach a hospital. Each observation has 1,000 binary predictors prefixed *ais* representing individual possible injuries (0=injury not present, 1=injury present) and a single binary outcome *died*, that is, patients who went on to die before discharge from the hospital (0=survived, 1=died).  

The training and test data are available as a tar.gz archive [here](http://johnstantongeddes.org/assets/statsathon_data.tar.gz). Once you extract the archive, you'll have a `statsathon` directory containing the training (AIS_train70.csv) and test (AIS_test30.csv) data. 

## Where

Details of the event are available on the [Meetup page](http://www.meetup.com/Burlington-Data-Scientists/events/229214918/). 

Feel free to participate by yourself, or form a team.

## Rules

Analyze the data using whatever methods you want. To qualify for the Grand Prize of a free [BTV Data Science sticker](http://www.stickermule.com/artworks/680631?token=e65ab17ade8c0c86), you must use open-source software (e.g. R, Python) and make your code available, preferably in this GitHub repository. 

**Entries must be made by 9pm on Tuesday March 22nd.** The preferred format for submission is by submitting a Pull Request to this respository (details below), with your predictions as a comma-delimited (.csv) file placed the *model_evaluation* directory, given your team's name. The first column of the csv file should be the `ais_data_test30.INC_KEY` in the test data, and the second column is your prediction of `died`, like this:

```
ais_data_test30.INC_KEY,pred
13000000,0
13000005,0
13000013,1
13000026,1
13000045,0
....
```

A complete example file, `example1.csv`, is in the *model_evaluation* directory. Alternately, you can email your results to [btvdatascience@gmail.com]. 

All entries will be be scored against the test set, and submissions ranked by their [accuracy, sensitivity, and specificity](http://topepo.github.io/caret/other.html). 

Please follow this [Guide to using Pull Requests](https://help.github.com/articles/using-pull-requests/) to submit your results and contribute your analysis. We're relying on the honor system that you don't look at any code that is submitted early :)

General outline:

1. Fork this repository to your personal account
2. Create a new branch with your group name (e.g. BTVawesome)
3. Create a new directory within the project using your group name (e.g. *BTVAwesome_analysis*)
4. Analyze data!
5. Include your scripts for analysis in your directory and commit code to your branch
6. Place final predictions as a csv (described above) with your team name (e.g. `BTVawesome_pred.csv`) in the *model_evaluation* directory
7. Submit a Pull Request to the BTVDataScience/statsathon-2016 repository




