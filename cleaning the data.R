all_data <- read.csv("cancer_reg.csv")
names(all_data)
dim(all_data)
head(all_data)

summary(all_data)
str(all_data)

#Issue with the entry of Dona Ana County, fixing the entry
all_data$Geography[167] <- "Dona Ana County, New Mexico"



colSums(is.na(all_data)) 
#152 NA responses in PctEmployed16_Over (employed over 16)
#609 NA responses in PctPrivateCoverageAlone (private coverage alone)
#2285 NA responses in PctSomeCol18_24 (some college)

data <- all_data[, -18]
data <- data[, -21]
data <- data[, -23]
summary(data)

sum(duplicated(all_data)) #check no accidental perfect duplicated rows


#Make it so that each data point is labeled based on its geographic name
rownames(data) <- data$Geography
data <- data[, -13] # remove the geographic name from the df

#confirm that data point 167 is fixed from incorrect name entry
data[167, ]




#need to change binnedInc to be categorical
# 1. Check the exact spelling/order of the 10 unique bins in your data
unique(data$binnedInc)

# 2. Pass the ENTIRE column (df$binnedInc) as the first argument
data$binnedInc <- factor(
  data$binnedInc, 
  levels = c(
    "[22640, 34218.1]", "(34218.1, 37413.8]", "(37413.8, 40362.7]", 
    "(40362.7, 42724.4]", "(42724.4, 45201]", "(45201, 48021.6]", 
    "(48021.6, 51046.4]", "(51046.4, 54545.6]", "(54545.6, 61494.5]", 
    "(61494.5, 125635]"
  ),
  labels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), # Or custom names like "Decile 1", etc.
  ordered = TRUE
)

View(data)


library(car)
all_data <- read.csv("/Users/sadmanahmed/Desktop/Homework/Regression/cancer_reg.csv")
all_data$Geography[167] <- "Dona Ana County, New Mexico"
names(all_data)

#summary(all_data)
#str(all_data)

# avganncount: Average number of cancer cases diagnosed annually.
# 
# avgdeathsperyear: Average number of deaths per year for any reason.
# 
# target_deathrate: Target death rate due to cancer.
# 
# incidencerate: Incidence rate of cancer.
# 
# medincome: Median income in the region.
# 
# popest2015: Estimated population in 2015.
# 
# povertypercent: Percentage of population below the poverty line.
# 
# studypercap: Per capita number of cancer-related clinical trials conducted.
# 
# binnedinc: Binned median income.
# 
# medianage: Median age in the region.
# 
# pctprivatecoveragealone: Percentage of population covered by private health insurance alone.
# 
# pctempprivcoverage: Percentage of population covered
#by employee-provided private health insurance.
# 
# pctpubliccoverage: Percentage of population covered by public health insurance.
# 
# pctpubliccoveragealone: Percentage of population covered by public health insurance only.
# 
# pctwhite: Percentage of White population.
# 
# pctblack: Percentage of Black population.
# 
# pctasian: Percentage of Asian population.
# 
# pctotherrace: Percentage of population belonging to other races.
# 
# pctmarriedhouseholds: Percentage of married households.
# birthrate: Birth rate in the region.

plot(TARGET_deathRate ~ avgDeathsPerYear, data = all_data)

rownames(all_data) <- all_data$Geography
all_data <- all_data[,-c(13,18,22,25)]


full_model <- lm(TARGET_deathRate ~ ., data = all_data)
summary(full_model)
vif(full_model)

# Select only numeric columns
num_vars <- all_data[, sapply(all_data, is.numeric)]

# Compute correlation matrix and print pairs with |r| > 0.7
cor_mat <- cor(num_vars, use = "complete.obs")
which(abs(cor_mat) > 0.7 & abs(cor_mat) < 1, arr.ind = TRUE)

# Or view the exact values rounded to 2 decimal places
round(cor_mat, 2)

# avgAnnCount highly correlated with avgDeathsPerYear and popEst2015. The latter two are
# highly correlated among themselves. We keep avgAnnCount.

# povertyPercent and medIncome has R= -.79. We keep on medIncome. Also remove "BinnedIncome".

# Remove PctPrivateCoverageAlone (had missing values as well), 
#PctPublicCoverageAlone because they are part of PctPrivCoverage
# and PctPublicCoverage. We keep the latter two.

# Remove PctMarriedHouseholds, keep PercentMarried.

# Remove MedianAgeMale and Female. Only keep MedianAge

# to avoid collinearity between races, we only keep PctBlack. (Could have kept any other)


names(all_data)

all_data <- all_data[,-c(2,6,7,9,24,29,11,12,25,27,28)]

full_model <- lm(TARGET_deathRate ~ ., data = all_data)
summary(full_model)
vif(full_model)


#PctEmpPrivCoverage remove. Keep PctPrivateCoverage.

all_data <- all_data[,-16]

pairs(all_data)
