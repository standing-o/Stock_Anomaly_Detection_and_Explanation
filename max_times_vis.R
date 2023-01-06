# Packages
library(Hmisc)
library(vegan)
library(clue)
library(tidyverse)
library(readxl)
library(stats)
library(igraph)
library(affy)
library(estrogen)
library(vsn)
library(genefilter)
library(demography)
library(latex2exp)
library(writexl)
library(ggplot2)
library(R.devices)
library(dplyr)

# Load dataset
setwd("D:/Google 드라이브/Paper/Writing/Deep learning approach of the US stock market analysis and its explanation using correlation networks/code/")

stock_id = c('MMM', 'AXP', 'AAPL', 'BA', 'CAT', 'CVX', 'CSCO', 'KO',
                        'DIS', 'XOM', 'GS', 'HD', 'IBM', 'INTC', 'JNJ', 'JPM', 'MCD', 'MRK', 'MSFT', 'NKE', 'PFE',
                        'PG', 'TRV', 'UNH', 'VZ', 'V', 'WMT', 'WBA', 'RTX')
#coords = read.csv("coords.csv", header=TRUE)

modif_data <- read.csv('return_zscore/all_zscore.csv', header = TRUE) # return -> z score normalization
# names(modif_data) <- stock_id

datetime = modif_data['Date']

sector = c('MATERIALS', 'FINANCIALS', 'TECHNOLOGY', 'INDUSTRIALS', 'INDUSTRIALS', 'OIL', 'COMMUNICATION', 'CONSUMERGOODS',
           'CONSUMERGOODS', 'OIL', 'FINANCIALS', 'CONSUMERGOODS', 'TECHNOLOGY', 'TECHNOLOGY', 'HEALTHCARE', 'FINANCIALS', 'CONSUMERGOODS', 'HEALTHCARE', 'TECHNOLOGY', 'CONSUMERGOODS', 'HEALTHCARE',
           'CONSUMERGOODS', 'FINANCIALS', 'HEALTHCARE', 'COMMUNICATION', 'FINANCIALS', 'CONSUMERGOODS', 'HEALTHCARE', 'TECHNOLOGY')

# MST
start = 1
end = 68
step = 68

n = 29
set.seed(7)

# palette
my_color <- c("lightgray", rev(heat.colors(28))[seq(11,28,1)])       #    RGB values 

num_anomalies = matrix(0, 29, 4)


for (i in 1:4){   ##4
  print(paste('from', datetime[start,], 'to', datetime[end,], sep=' '))
  
  coef.corr <- rcorr(as.matrix(modif_data[start:end,][stock_id]), type = "pearson")  ## create the correlation coefficients
  coef.d <- sqrt(2*(1-coef.corr$r)) # compute distance  
  
  links<-as.data.frame(as.table(coef.d)) # creates a table of three columns for each correlation among two variables   
  colnames(links)[3]="weight"  #Rename the third columns as "weight"

  nodes <-stock_id  
  g <- graph_from_data_frame(d=links, vertices=nodes, directed=F)
  mst <- mst(g, algorithm="prim")
  
  MST <- as_data_frame(mst)
  
  if (i==1){
    coords <- layout_(mst, with_lgl())  # as_tree, with_lgl
  }
  
  for (s in 1:29){
    anomaly = read.csv(paste('anomalies2/anomalies_',stock_id[s],'.csv', sep=''), header = TRUE)
    a = table(anomaly[start:end,]$anomaly)['True']
      
    if (is.na(a)){
      num_anomalies[s, i] = 0
  
    } else{
      num_anomalies[s, i] = a
    }
     
  }
  
  
  V(mst)[stock_id]$color = as.character(my_color[num_anomalies[, i]+1])
  
  # coords (as.matrix(coords[1:n,])
  png(file = paste('from_', datetime[start,], '_to_', datetime[end,],'.png', sep=''), width=800, height=800)
  plot(mst, layout = coords, vertex.label.font = 2, edge.width = 2,   
       edge.color = 'black',
       vertex.size=20, vertex.color = V(mst)$color, vertex.label.cex = 1.5, 
       vertex.label.color = 'black', cex.main=1.5, 
       #mark.groups = split(V(mst)$name, sector),
       #mark.col = NA
       )
  
  dev.off()
  
  
  start = start + step
  end = end + step
  
}





