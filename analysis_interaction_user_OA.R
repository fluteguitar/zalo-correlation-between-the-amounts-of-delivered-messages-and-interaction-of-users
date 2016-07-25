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
  return(as.numeric(quantile(myvec)[2]))
}

header <- c("delivered", "no_of_users" , "seen_min", "seen_tri_mean", "seen_max", 
            "clicked_min", "clicked_tri_mean", "clicked_max", "percentage_seen", "percentage_clicked",
            "msg_min", "msg_tri_mean", "msg_max", "conv_min", "conv_tri_mean", "conv_max",
            "age_min", "age_tri_mean", "age_max")

write(header, file = paste(current_dir,"analysis_final.csv", sep = ""), sep = ",", ncolumns =  length(header))

for (val in min(tab$delivered):max(tab$delivered) ){

    temp <- tab[tab$delivered == val,]
    
    seen_tri_mean <- tri_mean(temp$seen)
    seen_max <- max(temp$seen)
    seen_min <- min(temp$seen)
    
    clicked_tri_mean <- tri_mean(temp$clicked)
    clicked_max <- max(temp$clicked)
    clicked_min <- min(temp$clicked)
    
    
    percentage_seen <- sum(temp$seen)/sum(temp$delivered) * 100
    percentage_clicked <- sum(temp$clicked)/sum(temp$delivered) * 100

    msg_tri_mean <- tri_mean(temp$msg)
    msg_min <- min(temp$msg)
    msg_max <- max(temp$msg)
    
    age_tri_mean <- tri_mean(temp$age)
    age_min <- min(temp$age)
    age_max <- max(temp$age)
    
    conv_tri_mean <- tri_mean(temp$conv)
    conv_min <- min(temp$conv)
    conv_max <- max(temp$conv)
    
    result <- c(val, length(temp$delivered), seen_min, seen_tri_mean, seen_max, 
                clicked_min, clicked_tri_mean, clicked_max, percentage_seen, percentage_clicked,
                msg_min, msg_tri_mean, msg_max, conv_min, conv_tri_mean, conv_max,
                 age_min, age_tri_mean, age_max)
 
       write(result, file = paste(current_dir,"analysis_final.csv", sep = ""), append =  TRUE, sep = ",", ncolumns =  length(result))
}