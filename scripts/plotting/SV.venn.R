# loaad required packages
library(VennDiagram)
library(gridExtra)

# define parameters
callset.1.n = 167
callset.2.n = 79
callset.con = 50

# define colours
callset1.col = "#CA8BAB"
callset2.col = "#00BA38"

# define callset names
callset1.name = "Callset1"
callset2.name = "Callset2"

#make new page for plot
grid.newpage()

SV.venn = draw.pairwise.venn(area1 = callset.1.n,
                             area2 = callset.2.n,
                             cross.area = callset.con,
                             category = c(callset1.name, callset2.name),
                             fill = c(callset1.col, callset2.col),
                             col = c("black", "black"),
                             alpha = c(0.7, 0.7))
