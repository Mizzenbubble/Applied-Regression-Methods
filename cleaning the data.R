all_data <- read.csv("cancer_reg.csv")
names(all_data)
dim(all_data)
head(all_data)

summary(all_data)
str(all_data)

colSums(is.na(all_data)) 
#152 NA responses in PctEmployed16_Over (employed over 16)
#609 NA responses in PctPrivateCoverageAlone (private coverage alone)
#2285 NA responses in PctSomeCol18_24 (some college)

sum(duplicated(all_data)) #check no accidental perfect duplicated rows

