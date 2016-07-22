current_dir = "D:/Work/Zalo projects/Relationship between no of sent messages vs User interaction/src/"
file_user_statistics = paste(current_dir, "user_statistics", sep = "")
file_user_oa_interaction = paste(current_dir, "user_oa_interaction", sep = "")

table_stat = read.delim(file = file_user_statistics, header = TRUE, row.names = NULL, sep = "")
table_inter = read.delim(file = file_user_oa_interaction, header = TRUE, row.names = NULL, sep = "")

table <- merge(table_inter,table_stat,  by = c("userid") )
table$age = table$age/7
table$gender = table$gender/7

table$age[table$age <= 10] <- mean(table$age)
table$age[table$age >= 60] <- mean(table$age)

