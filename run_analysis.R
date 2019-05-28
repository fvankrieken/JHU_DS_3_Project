library(dplyr)

# parent folder for data
folder <- "./UCI HAR Dataset/"

# list of feature names
features <- read.table(paste0(folder, "features.txt"), stringsAsFactors = F)$V2

#function to speed up reading in data
read <- function(x, cn = NA) {
  if (is.na(cn)) {
    read.table(paste0(folder, x, ".txt"))
  } else {
    read.table(paste0(folder, x, ".txt"), col.names = cn)
  }
}

# activity labels
activity_labels <- read("activity_labels", c("activity_id", "activity_label"))

# measurement data
data_merged <- rbind(read("train/X_train", features),read("test/X_test", features))

# to filter measurements
is_std_or_mean <- grepl("-mean\\(\\)|-std\\(\\)", features)

# measurements for stds and means
data_filtered <- data_merged[is_std_or_mean]

# activity info
activity_id <- rbind(read("train/Y_train"), read("test/Y_test"))

data_activities <- data_filtered
data_activities$activity_id <- activity_id$V1
data_activities <- data_activities %>% left_join(activity_labels)

# subject info
subjects <- rbind(read("train/subject_train"), read("test/subject_test"))

data_full <- data_activities
data_full$subject_id <- subjects$V1

# summarize by activity, subject
data_means <- data_full %>%
  group_by(activity_id, activity_label, subject_id) %>%
  summarize_all(funs(mean))

write.table(data_means, "tidy_data.txt", row.names = F)
