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
