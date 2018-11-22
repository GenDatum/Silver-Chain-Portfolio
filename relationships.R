## Load up necessary libraries ## 
usePackage("ggplot2")
usePackage("plyr")
usePackage("scales")
usePackage("zoo")
usePackage("lubridate")
usePackage("dplyr")
usePackage("googleVis")
usePackage("htmlwidgets")
usePackage("RCurl")

usePackage("tidyverse")

usePackage("RXKCD")
usePackage("tm")
usePackage("wordcloud")
usePackage("RColorBrewer")
usePackage("RODBC")

usePackage("gridExtra")
usePackage("reshape")
usePackage("networkD3")
usePackage("tidyr")
usePackage("collapsibleTree")
usePackage("rmarkdown")

data.hath = temp.2[which(temp.2$svc_type == "HATH"),]

data.hath$ReferralDate = as.character(data.hath$ReferralDate)
data.hath$context.start= as.character(data.hath$context.start)
data.hath$context.end= as.character(data.hath$context.end)

data.hath$ref <- as.Date(data.hath$ReferralDate, format = "%d %b %y")
data.hath$context.start<- as.Date(data.hath$context.start, format = "%d %b %y")
data.hath$context.end<- as.Date(data.hath$context.end, format = "%d %b %y")

data.hath.sort = data.hath[with(data.hath, order(data.hath$Client.Id,data.hath$ref)),]
dim(data.hath.sort)

data.hath.sort.sub = data.hath.sort[,c(1,3,7:9,11,13,15,16,17,18,19,20,21,22)]
dim(data.hath.sort.sub)
names(data.hath.sort.sub)

data.hath.sort.sub$num <- sequence(rle(data.hath.sort.sub$Client.Id)$lengths)

table(data.hath.sort.sub$Referral.Source)

readin = read.csv("U:/Work/DOH_Reporting_Proof_of_Concept/Real/Data/hath_ref_source.csv")
readin = readin[,2:3]
readin = readin[which(duplicated(readin$Referral.Source) == FALSE),]

dim(data.hath.sort.sub)
data.hath.sort.sub.mani = merge(data.hath.sort.sub, readin, by.x="Referral.Source", by.y="Referral.Source")
dim(data.hath.sort.sub.mani)

relate = aggregate(count ~ Mapped_Ref +  Parent_Diagnosis_Category, data=data.hath.sort.sub.mani, sum)
dim(relate)
names(relate)

relate.v2 = aggregate(count ~ Parent_Diagnosis_Category + Outcome, data=data.hath.sort.sub.mani , sum)
dim(relate.v2)
names(relate.v2)

links.2 = relate.v2
names(links.2)[1] = "source"
names(links.2)[2] = "target"
names(links.2)[3] = "value"


links = relate
names(links)[1] = "source"
names(links)[2] = "target"
names(links)[3] = "value"

links = rbind(links.2, links)

nodes=data.frame(name=c(as.character(links$source), as.character(links$target)) %>% unique())

links$IDsource=match(links$source, nodes$name)-1 
links$IDtarget=match(links$target, nodes$name)-1
