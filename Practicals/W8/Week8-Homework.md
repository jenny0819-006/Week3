# Week 8

## Disease Risks

### 1.Total Sample

geno <- read.table("H938_Euro_chr6.geno", sep=" ", h=T)

total <- geno$nA1A1 + geno$nA1A2 + geno$nA2A2
max(total)

The total number of samples is 124.

### 2.rowSums()

max(rowSums(geno[,5:7]))

The total number of samples is 124.

### 3.R/DataFiles/SNP_risks.csv

risk <- read.csv("R/DataFiles/SNP_risks.csv", h=T)

geno_six <- geno[,2:7]
geno_risk$Risk <- SNP_risks[,3]

### 4.heterozygous

mean(geno_risk$nA1A2[geno_risk$DiseaseRisk == "Risk"])
mean(geno_risk$nA1A2[geno_risk$DiseaseRisk == "Non-Risk"])

There are 37.31,296 people in the position associated with disease risk. There are 36.96,878 people in the position unrelated to the risk of disease.

## Data cleanup

### 1.Number of species

mammals <- read.table("R/DataFiles/Smith2003_data.txt", sep="\t")
nrow(mammals)

There are 5731 lines in the data sheet.

### 2.writes a file with the "clean" data

mammals <- read.table("R/DataFiles/Smith2003_data.txt", sep="\t")

mammals[,7][mammals[,7] == -999] <- NA
mammals[,8][mammals[,8] == -999] <- NA

write.table(mammals, file="Smith2003_clean_data_.txt", sep="\t", row.names=F, col.names=T)
