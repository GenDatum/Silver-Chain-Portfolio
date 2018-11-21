## Load up necessary libraries ## 
usePackage("ggplot2")
usePackage("plyr")
usePackage("scales")
usePackage("zoo")
usePackage("lubridate")
usePackage("tidyverse")

## Read in the Data ##
df <- read.csv("U:/Work/R/Data/data_20180807_tender.csv",quote="",na.strings="")
df = df[,c(24,6)]

# Create dataset
df$count = 1
df.new = aggregate( . ~ Parent_Diagnosis_Category_Code + Service_Type_Code ,sum,data=df)

df.new$Service_Type_Code = as.character(df.new$Service_Type_Code)

df.new$individual = as.factor(as.character(df.new$Parent_Diagnosis_Category_Code))
df.new$group = as.factor(as.character(df.new$Service_Type_Code))
df.new$value = as.integer(df.new$count)
df.new = df.new[,c(4,5,6)]
data =df.new

# Set a number of 'empty bar' to add at the end of each group
empty_bar=3
to_add = data.frame( matrix(NA, empty_bar*nlevels(data$group), ncol(data)) )
colnames(to_add) = colnames(data)
to_add$group=rep(levels(data$group), each=empty_bar)
data=rbind(data, to_add)
data=data[which(!is.na(data$value)),]
data=data %>% arrange(group)
data$id=seq(1, nrow(data))

# Get the name and the y position of each label
label_data=data
number_of_bar=nrow(label_data)
angle= 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
label_data$hjust<-ifelse( angle < -90, 1, 0)
label_data$angle<-ifelse(angle < -90, angle+180, angle)

# prepare a data frame for base lines
base_data=data %>% 
  group_by(group) %>% 
  summarize(start=min(id), end=max(id) - empty_bar) %>% 
  rowwise() %>% 
  mutate(title=mean(c(start, end)))

# prepare a data frame for grid (scales)
grid_data = base_data
grid_data$end = grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
grid_data$start = grid_data$start - 1
grid_data=grid_data[-1,]


