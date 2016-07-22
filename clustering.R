# meta data 
root_directory = "D:/Work/Zalo projects/Relationship between no of sent messages vs User interaction/"
source_file = paste(root_directory,"src/test.csv", sep ="")
out_file = paste(root_directory, "output/cluster-size.csv",sep = "")
sort_out_file = paste(root_directory, "output/sort-cluster-size.csv",sep = "")
out_file_center = paste(root_directory, "output/cluster centers/cluster-center-", sep="")
print(out_file_center)
user_info_column = c(2) #c(1,2,3) #userid, gender and age
cluster_range <- 2:5

# initialization of golbal variables
feature <- read.csv(source_file, sep = ",", header = TRUE)
user_info = feature[user_info_column] #personal information for users
#feature <- feature[-user_info_column]


is_append <- FALSE

for (it in cluster_range){
  print(it)
  print(out_file)
  print(out_file_center)
  cluster <- kmeans(feature[-user_info_column], centers = it, iter.max = 100)
  sort_cluster_size <- sort(cluster$size, decreasing = TRUE)
  
  to_matrix <- as.matrix(t(sort_cluster_size))
  write.table(to_matrix, file = sort_out_file, append = is_append, col.names =  FALSE,
              row.names = FALSE, sep = ',')
  
  to_matrix <- as.matrix(t(cluster$size))
  write.table(to_matrix, file = out_file, append = is_append, col.names =  FALSE,
              row.names = FALSE, sep = ',')
  
  write.csv(cluster$centers, file = paste(out_file_center, 
                                          toString(it), ".csv", sep = ""))
  is_append = TRUE
}

