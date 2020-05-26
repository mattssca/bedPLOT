# loadrequired packages
library(table1)

# set path to bed file to be plotted (for madditional callsets add more lines to match number of callsets)
input.file.1 = "testdata/inv.calls.bed"
input.file.2 = "testdata/inv.calls2.bed"
callset.name.1 = "HG0002.GRCh38.InvertR-b25-50"
callset.name.2 = "HG0002.GRCh38.VH"

# read bed file into r dataframe
SV.calls.1 = read.table(input.file.1, sep = "\t", skip = 1)
SV.calls.2 = read.table(input.file.2, sep = "\t", skip = 1)

# adding variable that holds call-set name, for more datasets, add more lines accordingly
namevector <- c("V5")
SV.calls.1[,namevector] <- callset.name.1
SV.calls.2[,namevector] <- callset.name.2

#rbind multiple dataframes
SV.calls.melted = rbind(SV.calls.1, SV.calls.2)

# renaming column names
table1::label(SV.calls.melted$V1) <- "Chromosome"
table1::label(SV.calls.melted$V2) <- "Strart"
table1::label(SV.calls.melted$V3) <- "End"
table1::label(SV.calls.melted$V4) <- "Size"
table1::label(SV.calls.melted$V5) <- "Callset"

# output summary table
table1::table1(~SV.calls.melted$V4 | SV.calls.melted$V5, data = SV.calls.melted)
