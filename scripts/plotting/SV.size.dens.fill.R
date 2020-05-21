# load required packages
library(ggplot2)
library(dplyr)

# set path to bed file to be plotted
input.file = ""

# set titles, subtitles, axis, scales etc.
plot.title = "Inversion size distribution"
plot.subtitle = "Chr1:22+X"
x.axis.name = "Size (bp)"
y.axis.name = "Density"

# define colours for fill (if more than two datasets are to be plotted, add more colours accordingly)
dataset1.colour = "#CA8BAB"
dataset2.colour = "#00BA38"

# read SV callset into R data frame
SV.calls = read.table(file = input.file, header = FALSE, sep = "\t", quote = FALSE)
SV.calls.fill = read.table(file = input.file, header = FALSE, sep = "\t", quote = FALSE)

# plot inversions size density (one dataset)
SV.size.dens = ggplot(SV.calls, aes(x = V4)) + 
  labs(title = plot.title, subtitle = plot.subtitle, x = x.axis.name, y = y.axis.name) +
  geom_density(alpha = 0.7, color = "black", fill = dataset1.colour, dataset2.colour)

# plot inversion size density for more than one dataset (dataset defined in column 5 of input file)
SV.size.dens.fill = ggplot(SV.calls.fill, aes(x=V4, fill=V5)) +
  geom_density(alpha = 0.7, outline.type = "full", adjust = 3) +
  labs(title = plot.title, subtitle = plot.subtitle, x = x.axis.name, y = y.axis.name) +
  scale_fill_manual(values=c(dataset1.colour, dataset2.colour))