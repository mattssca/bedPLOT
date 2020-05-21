# load packages
library(dplyr)
library(data.table)

# set path to bed file to be plotted (for madditional callsets add more lines to match number of callsets)
input.file1 = "testdata/inv.calls.bed"
input.file2 = "testdata/inv.calls2.bed"

# set output path for melted data frame
export.melted = "testdata/inv.calls.melted.txt"

# define callsets
callset1 = "strand.seq.invertR.b25"
callset2 = "strand.seq.scTRIP"

# read multiple callsets into R, add lines to match desired number of callsets
SV.calls1 = read.table(file = input.file1, header = FALSE, sep = "\t", skip = 1)
SV.calls2 = read.table(file = input.file2, header = FALSE, sep = "\t", skip = 1)

# adding callset variables
namevector <- c("V5")
SV.calls1[,namevector] <- callset1
SV.calls2[,namevector] <- callset2

# melt multiple callsets
SV.calls.melted = rbind(SV.calls1, SV.calls2)

# export melted data frame as table
write.table(x = SV.calls.melted, file = export.melted, quote = FALSE, sep = "\t")
