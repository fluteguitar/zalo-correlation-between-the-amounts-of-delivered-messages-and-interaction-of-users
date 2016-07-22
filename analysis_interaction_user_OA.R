#This file analysis the data from file interaction_user_oa and output to file analysis_interaction_user_OA  
current_dir <- "D:/Work/Zalo projects/Relationship between no of sent messages vs User interaction/src/groupedOA_sample/"

file_inp <- paste(current_dir, "data_final.csv", sep ="")

tab <-  read.csv(file_inp)

tri_mean <-  function(myvec){
  res <- (2 * mean(myvec) + as.numeric(quantile(myvec)[2]) + as.numeric(quantile(myvec)[4])) / 4
  return(as.numeric(res))
}


header <- c("delivered", "no_of_users", "sum_seen", "mean_seen", "mean_clicked", "percentage_seen", "percentage_clicked", "percentage_clicked_vs_seen", 
            "msg", "conv", "reply", "no_reply", "age")

write(header, file = paste(current_dir,"analysis_final.csv", sep = ""), sep = ",", ncolumns =  length(header))

for (val in min(tab$delivered):max(tab$delivered) ){

    temp <- tab[tab$delivered == val,]
    sum_seen <- sum(temp$seen)
    mean_seen <- tri_mean(temp$seen)
    mean_clicked <- tri_mean(temp$clicked)
    percentage_seen <- sum(temp$seen)/sum(temp$delivered) * 100
    percentage_clicked <- sum(temp$clicked)/sum(temp$delivered) * 100
    percentage_clicked_vs_seen <- sum(temp$clicked)/sum(temp$seen) * 100
    msg <- tri_mean(temp$msg)
    age <- tri_mean(temp$age)
    conv <- tri_mean(temp$conv)
    reply <- tri_mean(temp$reply)
    no_reply <- tri_mean(temp$no_reply)
    
    result <- c(val, length(temp$delivered), sum_seen, mean_seen, mean_clicked, percentage_seen, percentage_clicked, percentage_clicked_vs_seen, 
              msg, conv, reply, no_reply, age)
    write(result, file = paste(current_dir,"analysis_final.csv", sep = ""), append =  TRUE, sep = ",", ncolumns =  length(result))
}