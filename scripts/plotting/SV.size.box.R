# load required package
library(ggplot2)
library(dplyr)

# set path to bed file to be plotted (for madditional callsets add more lines to match number of callsets)
input.file = "testdata/inv.calls.bed"

# set titles, subtitles, axis, scales etc.
plot.title = "Inversion size"
plot.subtitle = "HG0005.GRCh38"
y.axis.name = "Size (bp)"
callset.name = "Strand.seq.invertR"

# define colours for fill (if more than two datasets are to be plotted, add more colours accordingly)
dataset1.colour = "#CA8BAB"

# read SV callset into R data frame (skips first Header line)
SV.calls = read.table(file = input.file, header = FALSE, sep = "\t", skip = 1)

# add dataset variable to dataframe
namevector <- c("V5")
SV.calls[,namevector] <- callset.name

########################################################plotting########################################################

SV.size.box = ggplot(SV.calls, aes(V5, V4, fill = V5)) +
  geom_boxplot(alpha = 0.7, fill = dataset1.colour) +
  labs(title = plot.title, subtitle = plot.subtitle, x = "", y = y.axis.name) +
  theme(legend.position = "none") +
  geom_jitter(shape=1, position=position_jitter(0.3))