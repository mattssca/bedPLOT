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

#convert variable from numeric to factor
SV.calls$V5 = as.factor(SV.calls$V5)
SV.calls$V1 = as.factor(SV.calls$V1)

########################################################plotting########################################################

SV.size.violine = ggplot(SV.calls, aes(x = V5, y = V4, fill = V5)) + 
  stat_summary(fun = mean, geom = "point", shape = 20, size = 3) +
  labs(title = plot.title, subtitle = plot.subtitle, x = "", y = y.axis.name, fill = "Data" ) +
  theme(legend.position = "none") +
  geom_violin(trim = FALSE, scale = "width", draw_quantiles = c(0.25, 0.5, 0.75), alpha = 0.7, fill = dataset1.colour)