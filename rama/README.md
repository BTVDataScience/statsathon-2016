# BTV Statsathon 2016 Entry

## Rama Kocherlakota

## Technologies Used: MySQL and perl

## Methods

The most naive approach would be just, for each row in the test set, to find all the rows in the training set that have the same predictors and estimate the probability of dying among them as died / total.  Unfortunately, this doesn't work because there aren't enough entries in the training set: many of the entries in the test set actually have no corresponding training-set entries.

### Uncertainty and Entropy

We can get around this problem by selecting a smaller collection of predictors that we will try to match between the test and training sets.  The question then becomes: which predictors do we use?  I chose to use the [information-theoretic notion of entropy](https://en.wikipedia.org/wiki/Entropy_(information_theory)) to help select good predictors.  If you have a random variable X then the entropy of X is defined to be:

```
H(X) = - Sum_x p(x) log p(x)
     = E(-log p(x))
```

Intuitively, H(X) is a measure of the uncertainty involved in guessing the value of X.  If you take the logs to base 2, then H(X) has natural units of "bits".

If we apply this to the training set, we can see that the entropy of the "died" random variable is just about 0.247 bits.  Can we reduce this uncertainty by adding in data about the values of some of the predictors?  It turns out that if they are all independent from died, then no, adding in the predictors won't help us (which is what you'd expect) but since some of the predictors are in fact not independent from died we can use their values to reduce the uncertainty.

In particular, corresponding to entropy, there is the [conditional entropy](https://en.wikipedia.org/wiki/Conditional_entropy) of one random variable given another:

```
H(X|Y) = Sum_x p(x) H(Y|X=x)
```

Intuitively, it represents the uncertainty involved in predicting the value of X, given that you know the value of Y.  If X and Y are independent, then H(X|Y) = H(X), as you might expect.

### Applying Entropy

We can apply entropy to our classification/prediction problem by just selecting a subset S of predictors that minimizes the conditional entropy H(died | S) in our training set and using that to do our died/total computation.  We can't find S directly by iterating over all the subsets - there are > 2^1200 of them and we only had a week for this.  We can use a greedy algorithm:

1. Choose the predictor p1 such that H(died | p1) is minimal.
2. Given p1, find the predictor p2 such that H(died | p1, p2) is minimal.
2. Given p1 and p2 find the predictor p3 such that H(died | p1, p2, p3) is minimal.
3. Repeat until your computer screams for mercy.

The computations are straightforward; I loaded the dataset into MySQL and wrote some simple perl scripts to munge the data.  The reason we can't keep doing this forever is that the sets of possible values of the pn's gets very large pretty fast - my computer maxed out after a set of fourteen predictors.


<table border>
<tr><th>Predictor</th><th>Conditional Entropy</th></tr>
<tr><th>AIS140656</th><td align=right>0.244</td></tr>
<tr><th>AIS140202</th><td align=right>0.241</td></tr>
<tr><th>AIS160214</th><td align=right>0.238</td></tr>
<tr><th>AIS140684</th><td align=right>0.236</td></tr>
<tr><th>AIS140678</th><td align=right>0.234</td></tr>
<tr><th>AIS140666</th><td align=right>0.232</td></tr>
<tr><th>AIS140650</th><td align=right>0.231</td></tr>
<tr><th>AIS442202</th><td align=right>0.230</td></tr>
<tr><th>AIS150206</th><td align=right>0.230</td></tr>
<tr><th>AIS140690</th><td align=right>0.229</td></tr>
<tr><th>AIS140629</th><td align=right>0.228</td></tr>
<tr><th>AIS140210</th><td align=right>0.228</td></tr>
<tr><th>AIS150200</th><td align=right>0.227</td></tr>
<tr><th>AIS140648</th><td align=right>0.226</td></tr>
</table>
(Actually, these were computed not on the whole training set but on a randomly chosen subset of 80% of the training set so I had something left over for cross validation.)

So adding these fourteen predictors reduces our entropy from an initial value of 0.248 (for our subset of the training set) to 0.226 bits.  (More or less.  There are some subtleties that arise because even using just fourteen of the predictors you still run into entries in the test dataset whose predictors don't have any corresponding entries in the training set.  We can finesse this problem by taking a smaller subset of our predictor set for those entries, a little ad hoc and messy but so it goes in the real world of data.)

Of course, we can't really be sure that these fourteen predictor are the best we can do.  Maybe that first predictor AIS140656 biased the rest of our choices - I don't know.  There's probably some theory that helps us decide how well our greedy algorithm really does and it would be fun to work it out but again, we only had a week.

I did try one experiment - iterating over all pairs from the predictor set and seeing if the best pair corresponded to our top two AIS140656 and AIS140202.  And yes, it does.  So that's encouraging.

Anyway, if we apply the "guess based on the frequency in the training set for these predictors" method to the cross-validation subset I reserved, it looks like this:

<table>
<tr><th>Sensitivity</th><td align=right>0.102</td></tr>
<tr><th>Specificity</th><td align=right>0.961</td></tr>
<tr><th>Accuracy</th><td align=right>0.927</td></tr>
</table>

This compares favorably with a naive guessing strategy that pays no attention to any features (as we might hope!)

<table>
<tr><th>Sensitivity</th><td align=right>0.034</td></tr>
<tr><th>Specificity</th><td align=right>0.958</td></tr>
<tr><th>Accuracy</th><td align=right>0.921</td></tr>
</table>
