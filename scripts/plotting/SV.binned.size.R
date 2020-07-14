# load required package
library(ggplot2)
library(dplyr)

# set path to bed file to be plotted (for madditional callsets add more lines to match number of callsets)
input.file = "testdata/inv.calls.bed"

# set titles, subtitles, axis, scales etc.
plot.title = "Inversion chromosome distribution"
plot.subtitle = "HG0005.GRCh38"
x.axis.name = ""
y.axis.name = "Count (n)"
callset.name = "Callset1"

# define colours for fill (if more than two datasets are to be plotted, add more colours accordingly)
dataset.colour = "#CA8BAB"

# read SV callset into R data frame (skips first Header line)
SV.calls = read.table(file = input.file, header = FALSE, sep = "\t", skip = 1)

# set up cut-off values 
breaks <- c(1, 50, 1000, 10000, 100000, 1000000, 5000000)

# specify interval/bin labels
tags <- c("1-50bp","50bp-1kb", "1kb-10kb", "10kb-100kb", "100kb-1Mb", "1Mb-5Mb")

# bucketing values into bins
SV_tags <- cut(SV.calls$V4, breaks=breaks, include.lowest=TRUE, right=FALSE, labels=tags)

########################################################plotting########################################################

SV.binned = ggplot(data = as_tibble(SV_tags), mapping = aes(x=value)) + 
  geom_bar(fill=dataset.colour, alpha=0.7) + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), axis.title.x = element_blank()) +
  labs(title = plot.title, subtitle = plot.subtitle, x = x.axis.name, y = y.axis.name, fill = "") 