
######## OUTPUT REF of a list of coordinates based on their chr and pos  
######## You may check it by UCSC browser ############################## 

## INSTALL bioconductor, it will be a long time
## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite()

## INSTALL two packages, it will be a long time
biocLite(c("Rsamtools", "BSgenome"))


## From here to finish, several minutes on my PC with a 2000-coordinate list. 

library(Rsamtools)
library(BSgenome)

## Read the list 
data <- read.csv("list.csv", header = TRUE)

## You must have a combined hg19 reference genome.
fasta_file <- FaFile(file='hg19.fasta')

loc <- GRanges(data$chr, IRanges(start=as.numeric(data$pos), end=as.numeric(data$pos)))

refbase <- getSeq(fasta_file, loc)

refbase <- as.data.frame(refbase)$x

data$REF <- refbase

## Write the new list with REF
write.csv(data, file = "Newlist_withREF.csv", row.names = F)
 