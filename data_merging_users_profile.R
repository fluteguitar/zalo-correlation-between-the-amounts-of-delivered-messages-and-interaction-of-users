#This program merges daily data of users profile and chat
# and selects the most appropriate features, writing those features to data.csv

current_dir = "D:/Work/Zalo projects/Relationship between no of sent messages vs User interaction/src/groupedOA_sample/profile/"

file_list = c("2016-07-08","2016-07-09","2016-07-10","2016-07-11","2016-07-12","2016-07-13","2016-07-14")

file_inp = paste(current_dir, file_list[1], sep = "")
table <- read.delim(file = file_inp, header = TRUE, row.names = NULL, sep ="")
colnames(table) <- c("userid",	"reply",	"no_reply",	"msg",	"daychat",	"gender",	"age")
reduction_columns <- c("userid", "gender", "age", "reply", "no_reply", "msg")
table <- table[reduction_columns]

for (i in 2:length(file_list)) {
  
  file_inp = paste(current_dir, file_list[i], sep = "")
  current_table <- read.delim(file = file_inp, header = TRUE, row.names = NULL, sep ="")
  colnames(current_table) <- c("userid",	"reply1",	"no_reply1",	"msg1",	"daychat",	"gender",	"age")
  reduction_columns <- c("userid", "gender", "age", "reply1", "no_reply1", "msg1")
  current_table <- current_table[reduction_columns]
  
  table <- merge(table, current_table, by =  c("userid", "gender", "age"), all.x = TRUE, all.y = TRUE)
  table[is.na(table)] <- 0#test
  
  
  table$no_reply <- table$no_reply + table$no_reply1
  table$reply <- table$reply + table$reply1
  table$msg <- table$msg + table$msg1
  
  reduction_columns <- c("userid", "gender", "age", "reply", "no_reply", "msg")
  table <- table[c(reduction_columns)]
}
file_out = paste(current_dir, "user_profile_chat.csv", sep ="")
write.table(table, file_out, sep = ",", row.names = FALSE)