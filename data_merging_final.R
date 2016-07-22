#This file merge the already-merged files into one single file for processings
current_dir = "D:/Work/Zalo projects/Relationship between no of sent messages vs User interaction/src/groupedOA_sample/"
file_correlation_delivered_interaction = paste(current_dir, "OA/correlation_delivered_interaction.csv", sep = "")
file_user_profile = paste(current_dir, "profile/user_profile_chat.csv", sep = "")

table_cor = read.delim(file = file_correlation_delivered_interaction, header = TRUE, row.names = NULL, sep = ",")
table_user_profile = read.delim(file = file_user_profile, header = TRUE, row.names = NULL, sep = ",")

table <- merge(table_user_profile,table_cor,  by = c("userid", "msg") )

table$age[table$age <= 10] <- mean(table$age)
table$age[table$age >= 60] <- mean(table$age)

file_out = paste(current_dir, "data_final.csv", sep ="")
write.table(table, file_out, sep = ",", row.names = FALSE)