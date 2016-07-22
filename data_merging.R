#This program merges traffic statistics and chat statistics (user_oa_chat_profile & user_oa_traffic)
# and selects the most appropriate features, writing those features to data.csv

current_dir = "D:/Work/Zalo projects/Relationship between no of sent messages vs User interaction/src/"

file_chat = paste(current_dir, "user_oa_chat_profile", sep = "")
file_traffic = paste(current_dir, "user_oa_traffic", sep = "")

table_chat <- read.delim(file = file_chat, header = TRUE, row.names = NULL, sep ="")
table_traffic <- read.delim(file = file_traffic, header = TRUE, row.names = NULL, sep= "")

table <- merge(table_chat, table_traffic, by = c("Date", "Userid"))
reduced_table <- table[c("Date", "Userid", "gender", "age", "reply", "no.reply", "Msg", "action_download_sticker", "lbs" )]
write.table(reduced_table, "data.csv", sep = ",")