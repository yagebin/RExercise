library(dplyr)
data(Seatbelts)
summary(Seatbelts)
any(is.na(Seatbelts))
df <- as.data.frame(Seatbelts)
df$TotalKilled <- df$DriversKilled + df$VanKilled
avr_withbelt <- mean(df$TotalKilled[df$law == 1])
avr_nobelt <- mean(df$TotalKilled[df$law == 0])

comparasion <- data.frame(
  belt_status = c("avr_withbelt", "avr_nobelt"),
  average_casualty = c(avr_withbelt, avr_nobelt)
)
print(comparasion)
stats <- data.fdata_frame()stats <- data.frame(
  Mean = sapply(df, function(x) if(is.numeric(x)) round(mean(x, na.rm = TRUE), 2) else NA),
  SD = sapply(df, function(x) if(is.numeric(x)) round(sd(x, na.rm = TRUE),2) else NA)
)



print(stats)
write.csv(df, file = "cleaned_SeatBelts.csv", row.names = FALSE)
stats  <- stats[!rownames(stats) %in% c("Year","law", "PetrolPrice"), ]
print(stats)
df$Year <- 1969:1984

df_with_belt <- df[df$law==1,]
nrow(df_with_belt)
df_without_belt <- df[df$law == 0,]
nrow(df_without_belt)
