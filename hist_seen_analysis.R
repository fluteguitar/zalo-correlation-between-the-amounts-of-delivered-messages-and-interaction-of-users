current_dir <- "D:/Work/Zalo projects/Relationship between no of sent messages vs User interaction/src/groupedOA_sample/"

file_inp <- paste(current_dir, "data_final.csv", sep ="")

tab <-  read.csv(file_inp)

for (val in min(tab$delivered):max(tab$delivered) ){
  
  temp <- tab[tab$delivered == val,]
  h <- hist(temp$seen, breaks = seq(-1,val,1))
  h$density = h$density * 100
  plot(h, main = toString(val), ylab = "Percentage",
       col = "yellow", border = "green" , freq = FALSE)
  
  dev.copy2pdf(file=paste(current_dir, toString(val) , ".pdf"), width = 7, height = 5)
  
}