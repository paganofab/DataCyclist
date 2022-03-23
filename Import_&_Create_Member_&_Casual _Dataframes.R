##author Fabio Pagano
## Import all CSVs into one data frame

filedir <- setwd("your path here")
file_names <- dir(filedir)
DataCyclistTrips <- do.call(rbind,lapply(file_names,read.csv))

#create & export casual dataframe
DataCyclistTrips_casual <- filter(DataCyclistTrips, member_casual =="casual")
write.csv(DataCyclistTrips_casual, "~/Desktop/Cyclist Trip Data/CSV/trips_casual.csv", row.names = TRUE )


#create & export member dataframe
DataCyclistTrips_member <- filter(DataCyclistTrips, member_casual =="member")
write.csv(DataCyclistTrips_member, "~/Desktop/Cyclist Trip Data/CSV/trips_member.csv", row.names = TRUE )