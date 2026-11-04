# R III: Simulation, Randomization, and Faster Code

## 1. Are most toads right-handed?

### 1.1 Classify each toad

I started with the null hypothesis that each toad was just as likely to use its right hand as its left. I simulated 100,000 sets of trials for each toad, with the same number of trials as in the real experiment. Then, I counted how many simulations gave a result at least as far from an even split as the real result. This proportion is the p-value.

toads <- read.delim("../../R/DataFiles/Toad_Handedness.tsv")
nExp <- 100000
p <- hand <- c()

for (j in 1:length(toads$Toad)) {
  right_ct <- c()
  for (i in 1:nExp) {
    experiment <- sample(c("R", "L"), toads$N_trials[j],
                         prob=c(0.5, 0.5), replace=T)
    right_ct[i] <- sum(experiment == "R")
  }
  p[j] <- sum(abs(right_ct - toads$N_trials[j]/2) >=
              abs(toads$N_rights[j] - toads$N_trials[j]/2)) / nExp

  if (p[j] < 0.05 && toads$N_rights[j] > toads$N_trials[j]/2) {
    hand[j] <- "Right"
  } else if (p[j] < 0.05 && toads$N_rights[j] < toads$N_trials[j]/2) {
    hand[j] <- "Left"
  } else {
    hand[j] <- "No clear preference"
  }
}
At a 0.05 cutoff, 11 toads were classified as right-handed, 3 as left-handed, and 4 had no clear handedness. 

| Toad | Trials | Right-hand choices | Simulated p-value | Result |
|---|---:|---:|---:|---|
| T1 | 16 | 14 | 0.00397 | Right-handed |
| T2 | 15 | 12 | 0.03511 | Right-handed |
| T3 | 17 | 3 | 0.01312 | Left-handed |
| T4 | 15 | 15 | 0.00010 | Right-handed |
| T5 | 16 | 12 | 0.07830 | No clear handedness |
| T6 | 16 | 16 | 0.00003 | Right-handed |
| T7 | 16 | 15 | 0.00054 | Right-handed |
| T8 | 16 | 15 | 0.00053 | Right-handed |
| T9 | 16 | 2 | 0.00402 | Left-handed |
| T10 | 16 | 15 | 0.00049 | Right-handed |
| T11 | 15 | 15 | 0.00008 | Right-handed |
| T12 | 17 | 12 | 0.14279 | No clear handedness |
| T13 | 18 | 16 | 0.00115 | Right-handed |
| T14 | 18 | 8 | 0.81694 | No clear handedness |
| T15 | 15 | 14 | 0.00099 | Right-handed |
| T16 | 16 | 15 | 0.00055 | Right-handed |
| T17 | 16 | 2 | 0.00427 | Left-handed |
| T18 | 16 | 9 | 0.80472 | No clear handedness |

### 1.2 Are clearly handed toads equally likely to be right- or left-handed?

nr <- sum(hand == "Right")
n <- nr + sum(hand == "Left")
right_ct <- c()
for (i in 1:nExp) {
  experiment <- sample(c("R", "L"), n, prob=c(0.5, 0.5), replace=T)
  right_ct[i] <- sum(experiment == "R")
}
sum(abs(right_ct - n/2) >= abs(nr - n/2)) / nExp

Among the 14 toads classified as handed, 11 were right-handed and 3 were left-handed. I simulated 100,000 sets of 14 choices under the null hypothesis that right and left handedness are equally likely. The p-value is approximately 0.057. At the 0.05 cutoff, this does not provide enough evidence to reject the null hypothesis. The sample has more right-handed toads, but this simulation does not show a statistically significant difference at that cutoff.

### 1.3 Are males and females equally likely to be right-handed?

right <- hand == "Right"
sex <- toads$Sex
observed_diff <- sum(right[sex == "M"])/sum(sex == "M") -
       sum(right[sex == "F"])/sum(sex == "F")
randomized_diff <- c()
for (i in 1:10000) {
  shuffled_sex <- sample(sex, length(sex), replace=F)
  randomized_diff[i] <- sum(right[shuffled_sex == "M"])/sum(shuffled_sex == "M") -
                        sum(right[shuffled_sex == "F"])/sum(shuffled_sex == "F")
}
sum(abs(randomized_diff) >= abs(observed_diff)) / 10000

I used the individual classifications from 1.1 and compared the male and female proportions classified as right-handed. I randomly reassigned the sex labels 10,000 times, keeping the number of males and females the same, and recalculated the difference in proportions each time.

The observed male-minus-female difference was about 0.11. The random p-value was about 1.00, so these data do not provide evidence that males and females differ in their probability of being right-handed.

## 2. Assortative mating in animals

For each taxon, the statistic means correlation value, `r`. For each taxon, I repeatedly sampled the same number of `r` values as that taxon's number of studies from the full dataset, then calculated the mean. The p-value is the proportion of 50,000 random means that were at least as high as the observed taxon mean. 

mating <- read.delim("../../R/DataFiles/Jiang2013_data.csv")

mean_r <- function(desired_taxon) {
  mean(mating$r[mating$Taxon == desired_taxon])
}

taxa <- c("Fish", "Amphibian", "Chelicerate", "Bird", "Crustacean", "Gastropod", "Reptile", "Insect", "Annelids", "Protist", "Mammal")
nPer <- 50000
mean_by_taxon <- c()
p_value <- c()
n_by_taxon <- c()

for (j in 1:length(taxa)) {
  observed_mean <- mean_r(taxa[j])
  nTaxon <- sum(mating$Taxon == taxa[j])
  random_means <- c()

  for (i in 1:nPer) {
    random_sample <- sample(mating$r, size=nTaxon, replace=F)
    random_means[i] <- mean(random_sample)
  }

  mean_by_taxon[j] <- observed_mean
  p_value[j] <- sum(random_means >= observed_mean) / nPer
  n_by_taxon[j] <- nTaxon
}

| Taxon | Number of studies | Mean `r` | Simulated p-value |
|---|---:|---:|---:|
| Fish | 37 | 0.3972 | 0.00326 |
| Amphibian | 143 | 0.1855 | 0.99996 |
| Chelicerate | 9 | 0.4911 | 0.01102 |
| Bird | 52 | 0.1318 | 0.99978 |
| Crustacean | 149 | 0.4030 | <0.00002 (0 of 50,000) |
| Gastropod | 10 | 0.4010 | 0.07986 |
| Reptile | 8 | 0.1175 | 0.92980 |
| Insect | 106 | 0.1966 | 0.99826 |
| Annelids | 1 | 0.2000 | 0.58758 |
| Protist | 5 | 0.6140 | 0.00358 |
| Mammal | 1 | 0.0090 | 0.84334 |

Fish have a positive mean `r` of about 0.397. Their mean is higher than expected from random samples of 37 values from the full dataset (p ≈ 0.00326), so the results support the idea that fish have an especially high mean `r`. Chelicerates and protists also have upper-tail p-values below 0.05 in these simulations. No simulated crustacean mean reached the observed mean; following the class rule of thumb, its estimated p-value is reported as less than 1/50,000.
