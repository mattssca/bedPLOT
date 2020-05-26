# load required package
library(ggplot2)
library(dplyr)

# set path to bed file to be plotted (for madditional callsets add more lines to match number of callsets)
input.file.1 = "testdata/inv.calls.bed"
input.file.2 = "testdata/inv.calls2.bed"

# set titles, subtitles, axis, scales etc.
plot.title = "Inversion chromosome distribution"
plot.subtitle = "HG0005.GRCh38"
x.axis.name = ""
y.axis.name = "Count (n)"
callset.name.1 = "Callset1"
callset.name.2 = "Callset2"

# define colours for fill (if more than two datasets are to be plotted, add more colours accordingly)
dataset1.colour = "#CA8BAB"
dataset2.colour = "#00BA38"

# read SV callset into R data frame (skips first Header line)
SV.calls.1 = read.table(file = input.file.1, header = FALSE, sep = "\t", skip = 1)
SV.calls.2 = read.table(file = input.file.2, header = FALSE, sep = "\t", skip = 1)

# add chr count variable
SV.calls.1 = SV.calls.1 %>% add_count(V1)
SV.calls.2 = SV.calls.2 %>% add_count(V1)

# subset dataframes to only include chr and count (n)
SV.calls.1 = select(SV.calls.1, V1, n)
SV.calls.2 = select(SV.calls.2, V1, n)

# adding dataset variable
namevector <- c("V3")
SV.calls.1[,namevector] <- callset.name.1
SV.calls.2[,namevector] <- callset.name.2

# remove duplicate chr rows
SV.calls.1 = distinct(SV.calls.1, V1, .keep_all = TRUE)
SV.calls.2 = distinct(SV.calls.2, V1, .keep_all = TRUE)

# melt dataframes into one
SV.calls.melted.count = rbind(SV.calls.1, SV.calls.2)

# set max limmits for y scale
ymax = max(SV.calls.melted.count$n)

########################################################plotting########################################################

SV.chrdist.box = ggplot(SV.calls.melted.count, aes(x = SV.calls.melted.count$V1, y = SV.calls.melted.count$n, fill = SV.calls.melted.count$V3)) +
  labs(title = plot.title, subtitle = plot.subtitle, x = x.axis.name, y = y.axis.name, fill = "") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 20), axis.text.y = element_text(size = 20), axis.title.x = element_text(size = 20), axis.title.y = element_text(size = 20), plot.title = element_text(size = 30), plot.subtitle = element_text(size = 20), legend.title = element_text(size = 20), legend.text = element_text(size = 20), legend.position = "top") +
  scale_x_discrete(limits=c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6", "chr7", "chr8", "chr9", "chr10", "chr11", "chr12", "chr13", "chr14", "chr15", "chr16", "chr17", "chr18", "chr19", "chr20", "chr21", "chr22", "chrX")) +
  geom_bar(position = position_dodge(), stat = "identity", alpha = 0.7, color = "grey3") +
  scale_y_continuous(limits = c(0, ymax), breaks = c(0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24)) +
  scale_fill_manual(values=c("#CA8BAB", "#00BA38"))

# export plot as png
ggsave("SV.chrdist.box.R.png", 
       SV.chrdist.box,
       path = "example_figures/",
       limitsize = FALSE,
       width = 20,
       height = 11, 
       units = c("in"),
       scale = 1, 
       dpi = 300)