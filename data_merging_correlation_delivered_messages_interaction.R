#This program merges daily data of delivered messages to users and users responses as well as chat statistics
# and selects the most appropriate features, writing those features to data.csv

current_dir = "D:/Work/Zalo projects/Relationship between no of sent messages vs User interaction/src/groupedOA_sample/OA/"

file_list = c("2016-07-08","2016-07-09","2016-07-10","2016-07-11","2016-07-12","2016-07-13","2016-07-14")

file_inp = paste(current_dir, file_list[1], sep = "")
table <- read.delim(file = file_inp, header = TRUE, row.names = NULL, sep ="")
colnames(table) <- c("userid", "delivered", "seen", "msg", "conv", "clicked")

for (i in 2:length(file_list)) {
  file_inp = paste(current_dir, file_list[i], sep = "")
  current_table <- read.delim(file = file_inp, header = TRUE, row.names = NULL, sep ="")
  colnames(current_table) <- c("userid", "delivered1", "seen1", "msg1", "conv1", "clicked1")
  
  table <- merge(table, current_table, by =  c("userid"), all.x = TRUE, all.y = TRUE)
  table[is.na(table)] <- 0
  
  table$delivered <- table$delivered + table$delivered1
  table$seen <- table$seen + table$seen1
  table$msg <- table$msg + table$msg1
  table$conv <- table$conv + table$conv1
  table$clicked <- table$clicked + table$clicked1
  
  reduction_columns <- c("userid", "delivered", "seen", "clicked", "msg", "conv")  
  table <- table[c(reduction_columns)]
}
file_out = paste(current_dir, "correlation_delivered_interaction.csv", sep ="")
write.table(table, file_out, sep = ",", col.names = FALSE)