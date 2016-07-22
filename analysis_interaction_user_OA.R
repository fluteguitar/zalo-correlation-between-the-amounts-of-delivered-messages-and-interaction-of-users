#This file analysis the data from file interaction_user_oa and output to file analysis_interaction_user_OA  
current_dir <- "D:/Work/Zalo projects/Relationship between no of sent messages vs User interaction/"
file_inp <- paste(current_dir, "src/final_version_here.csv", sep ="")
tab <-  read.csv(file_inp)

tri_mean <-  function(myvec){
  res <- (2 * mean(myvec) + as.numeric(quantile(myvec)[2]) + as.numeric(quantile(myvec)[4])) / 4
  return(as.numeric(res))
}


header <- c("delivered", "no_of_elements", "seen", "clicked", "percentage_seen", "percentage_clicked", "percentage_clicked_vs_seen", 
            "msg_ms_nhon", "msg_ms_dung", "conv_ms_nhon", "conv_ms_dung", "action_download_sticker", "lbs", "age")

write(header, file = paste(current_dir,"output/analysis_final.csv", sep = ""), sep = ",", ncolumns =  length(header))

for (val in min(tab$delivered):max(tab$delivered) ){
    temp <- tab[tab$delivered == val,]
    seen <- mean(temp$seen)
    clicked <- mean(temp$clicked)
    percentage_seen <- sum(temp$seen)/sum(temp$delivered) * 100
    percentage_clicked <- sum(temp$clicked)/sum(temp$delivered) * 100
    percentage_clicked_vs_seen <- sum(temp$clicked)/sum(temp$seen) * 100
    msg_ms_nhon <- tri_mean(temp$msg.x)
    msg_ms_dung <- tri_mean(temp$msg.y)
    age <- tri_mean(temp$age)
    conv_ms_nhon <- tri_mean(temp$conv)
    conv_ms_dung <- tri_mean(temp$reply + temp$no.reply)
    action_download_sticker <- tri_mean(temp$action_download_sticker)
    lbs <- tri_mean(temp$lbs)
    
    result <- c(val, length(temp$lbs), seen, clicked, percentage_seen, percentage_clicked, percentage_clicked_vs_seen, 
              msg_ms_nhon, msg_ms_dung, conv_ms_nhon, conv_ms_dung, action_download_sticker, lbs, age)
    write(result, file = paste(current_dir,"output/analysis_final.csv", sep = ""), append =  TRUE, sep = ",", ncolumns =  length(result))
}