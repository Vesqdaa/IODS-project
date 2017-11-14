# Vesa Huotelin 4.11.2017 - Creating learning2014 dataset.

# Load dplyr library for nice'n'easy functions for data wrangling.
library(dplyr)

# Import the data
d <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = TRUE)

# Print the structure and dimensions of the data
str(d)
dim(d)

# For the starters, let us just copy-paste the code (with a little edit) from what already has been done at DataCamp.

# ==========================================
# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(d, one_of(deep_questions))
d$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(d, one_of(surface_questions))
d$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(d, one_of(strategic_questions))
d$stra <- rowMeans(strategic_columns)

# let's also take mean from Attitude vars:
d$attitude <- d$Attitude/10
# ================================

# Create an analysis dataset: 1. select right variables, 2. filter rows that has
a <- d %>% 
  select(gender, Age, attitude, deep, stra, surf, Points) %>% 
  filter(Points != 0)

# Fix the column names to be all lowercase
names(a) <- tolower(names(a))
  
#

# Set the working directory to
setwd("/Users/Vesq/Documents/Opiskelu/IODS/IODS-project")

# Save data 'a' as .csv to folder 'data'.
write.table(a, "data/a.csv", col.names = T, row.names = F, sep = ",", dec = ".")

# Let's test if we can import the data back again.
test <- read.table("data/a.csv", header = T, sep = ",", dec = ".")
dim(test)
head(test)


