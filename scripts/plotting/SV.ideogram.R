# load required packages
library(karyoploteR)

# set path to bed file to be plotted (for madditional callsets add more lines to match number of callsets)
input.file = "testdata/inv.calls.bed"

# define colours for fill (if more than two datasets are to be plotted, add more colours accordingly)
dataset1.colour = "#CA8BAB"

########################################################plotting########################################################

# convert bed file to Granges object
SV.calls.Gr = toGRanges(input.file)

kp <- plotKaryotype(genome = "hg19")

kpPlotRegions(kp, data = SV.calls.Gr, r0 = 0, r1 = 0.5, col = dataset1.colour)