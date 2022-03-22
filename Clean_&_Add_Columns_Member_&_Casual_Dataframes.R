#Packages Needed
install.packages("geosphere")
install.packages("dplyr")

library("geosphere")
library("dplyr")
library("tidyr")

#create casual riders dataframe
DataCyclistTrips_Casual <- read.csv("trips_casual.csv")

#replace empty rows with Missing Data
DataCyclistTrips_Casual[DataCyclistTrips_Casual ==""] <- 'missing data'

#create new column with Time Difference
time_diff_casual <- difftime(DataCyclistTrips_Casual$ended_at, DataCyclistTrips_Casual$started_at, units = "mins")
DataCyclistTrips_Casual$time_diff <-time_diff_casual

#create new column with distance in meters
DataCyclistTrips_Casual <- mutate(DataCyclistTrips_Casual, 
       distance = distHaversine(cbind(start_lng, start_lat),
                                cbind(end_lng, end_lat), r=6378137))

#create new column with weekday that ride started
DataCyclistTrips_Casual$weekday <- weekdays(as.Date(DataCyclistTrips_Casual$started_at))

#drop columns that are unnecessary to analysis to reduce df size
DataCyclistTrips_Casual = subset(DataCyclistTrips_Casual, select = -c(X,start_station_id,end_station_id,member_casual))

#remove rows with negative time difference and zero distance traveled
DataCyclistTrips_Casual <- DataCyclistTrips_Casual %>% filter(!distance == 0)
DataCyclistTrips_Casual <- DataCyclistTrips_Casual %>% filter(time_diff > 0)

#export casual df to csv
write.csv(DataCyclistTrips_Casual, "~/Desktop/Cyclist Trip Data/CSV/data_casual_complete_clean.csv", row.names = TRUE )

#create member riders dataframe
DataCyclistTrips_Member <- read.csv("trips_member.csv")

#replace empty rows with Missing Data
DataCyclistTrips_Member[DataCyclistTrips_Member ==""] <- 'missing data'

#create new column with Time Difference
time_diff_member <- difftime(DataCyclistTrips_Member$ended_at, DataCyclistTrips_Member$started_at, units = "mins")
DataCyclistTrips_Member$time_diff <-time_diff_member

#create new column with distance in meters
DataCyclistTrips_Member <- mutate(DataCyclistTrips_Member, 
                                  distance = distHaversine(cbind(start_lng, start_lat),
                                                           cbind(end_lng, end_lat), r=6378137))
#create new column with weekday that ride started
DataCyclistTrips_Member$weekday <- weekdays(as.Date(DataCyclistTrips_Member$started_at))

#drop columns that are unnecessary to analysis to reduce df size
DataCyclistTrips_Member = subset(DataCyclistTrips_Member, select = -c(X,start_station_id,end_station_id,member_casual))


#remove rows with negative time difference and zero distance traveled
DataCyclistTrips_Member <- DataCyclistTrips_Member %>% filter(!distance == 0)
DataCyclistTrips_Member <- DataCyclistTrips_Member %>% filter(time_diff > 0)

#export member df to csv
write.csv(DataCyclistTrips_Member, "~/Desktop/Cyclist Trip Data/CSV/data_member_complete_clean.csv", row.names = TRUE )
