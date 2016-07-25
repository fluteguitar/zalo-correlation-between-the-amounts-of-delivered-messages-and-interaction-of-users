#This file analysis the data from file interaction_user_oa and output to file analysis_interaction_user_OA  
current_dir <- "D:/Work/Zalo projects/Relationship between no of sent messages vs User interaction/src/groupedOA_sample/"

file_inp <- paste(current_dir, "data_final.csv", sep ="")

tab <-  read.csv(file_inp)

tri_mean <-  function(myvec){
  res <- (2 * mean(myvec) + as.numeric(quantile(myvec)[2]) + as.numeric(quantile(myvec)[4])) / 4
  return(as.numeric(res))
}

first_q <- function(myvec) {
  return(as.numeric(quantile(myvec)[2]))
}

third_q <- function(myvec) {
  return(as.numeric(quantile(myvec)[4]))
}

header <- c("delivered", "no_of_users" , "seen_first_quartile", "seen_tri_mean", "seen_third_quartile", 
            "clicked_first_quartile", "clicked_tri_mean", "clicked_third_quartile", "percentage_seen", "percentage_clicked",
            "msg_first_quartile", "msg_tri_mean", "msg_third_quartile", "conv_first_quartile", "conv_tri_mean", "conv_third_quartile",
            "age_first_quartile", "age_tri_mean", "age_third_quartile")

write(header, file = paste(current_dir,"analysis_final.csv", sep = ""), sep = ",", ncolumns =  length(header))

for (val in min(tab$delivered):max(tab$delivered) ){

    temp <- tab[tab$delivered == val,]
    
    seen_tri_mean <- tri_mean(temp$seen)
    seen_third_quartile <- third_q(temp$seen)
    seen_first_quartile <- first_q(temp$seen)
    
    clicked_tri_mean <- tri_mean(temp$clicked)
    clicked_third_quartile <- third_q(temp$clicked)
    clicked_first_quartile <- first_q(temp$clicked)
    
    
    percentage_seen <- sum(temp$seen)/sum(temp$delivered) * 100
    percentage_clicked <- sum(temp$clicked)/sum(temp$delivered) * 100

    msg_tri_mean <- tri_mean(temp$msg)
    msg_first_quartile <- first_q(temp$msg)
    msg_third_quartile <- third_q(temp$msg)
    
    age_tri_mean <- tri_mean(temp$age)
    age_first_quartile <- first_q(temp$age)
    age_third_quartile <- third_q(temp$age)
    
    conv_tri_mean <- tri_mean(temp$conv)
    conv_first_quartile <- first_q(temp$conv)
    conv_third_quartile <- third_q(temp$conv)
    
    result <- c(val, length(temp$delivered), seen_first_quartile, seen_tri_mean, seen_third_quartile, 
                clicked_first_quartile, clicked_tri_mean, clicked_third_quartile, percentage_seen, percentage_clicked,
                msg_first_quartile, msg_tri_mean, msg_third_quartile, conv_first_quartile, conv_tri_mean, conv_third_quartile,
                 age_first_quartile, age_tri_mean, age_third_quartile)
 
    write(result, file = paste(current_dir,"analysis_final.csv", sep = ""), append =  TRUE, sep = ",", ncolumns =  length(result))
}