# Belt Casualty Analysis

This project explores the "Seatbelts" dataset provided by R. The analysis aims to gain insights into the number of deaths (casualties) with and without the implementation of a seatbelt law. In this project, we use several R packages (such as dplyr and ggplot2) to transform the data, compute summary statistics, and create visualizations.
Overview

The project performs the following tasks:
Data Preparation & Summary Statistics
Load the built-in Seatbelts dataset and convert it into a data frame.
Compute the total number of deaths (by summing the number of driver deaths and van deaths).
Calculate average casualties for cases with the seatbelt law (law == 1) and without the law (law == 0).
Generate a summary statistics table (mean and standard deviation) for numeric variables.
Export the cleaned dataset to a CSV file.
Visualization with ggplot2
Create a time series line chart (with a LOESS trend line) showing how the total casualties change over the years.
Create a bar chart of the computed mean values for the different numeric variables.
Create a bar chart comparing the average casualties based on whether the seatbelt law was in effect.
Scripts

Below are the key code snippets used in the project.
Data Preparation and Summary Statistics
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

stats <- data.frame(
  Mean = sapply(df, function(x) if(is.numeric(x)) round(mean(x, na.rm = TRUE), 2) else NA),
  SD   = sapply(df, function(x) if(is.numeric(x)) round(sd(x, na.rm = TRUE), 2) else NA)
)
print(stats)

## Export the cleaned dataset
write.csv(df, file = "cleaned_SeatBelts.csv", row.names = FALSE)

## Remove specific rows from the summary (e.g., "Year", "law", and "PetrolPrice")
stats <- stats[!rownames(stats) %in% c("Year", "law", "PetrolPrice"), ]
print(stats)

## Create a Year column (assuming the dataset spans from 1969 to 1984)
df$Year <- 1969:1984

## Check the number of observations for each group
df_with_belt <- df[df$law == 1, ]
nrow(df_with_belt)
df_without_belt <- df[df$law == 0, ]
nrow(df_without_belt)
Visualization with ggplot2
library(ggplot2)

## Time series plot of total casualties over the years
## Convert Year to Date format (using January 1st as the reference date)
df$Year <- as.Date(paste0(df$Year, "-01-01"))
ggplot(df, aes(x = Year, y = TotalKilled)) +
  geom_line(color = "blue", linewidth = 1) +
  geom_smooth(method = "loess", se = FALSE, color = "red") +
  labs(title = "Time Series Curve with Trend", x = "Year", y = "Total Killed") +
  theme_minimal()

## Bar chart of mean values for different numeric variables
## Convert rownames to a column for plotting
stats$variable <- rownames(stats)
ggplot(stats, aes(x = variable, y = Mean)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Mean Values for Different Variables", 
       x = "Variable",
       y = "Mean Value") +
  theme_minimal()

## Bar chart comparing average casualty based on seatbelt law
ggplot(comparasion, aes(x = belt_status, y = average_casualty)) +
  geom_bar(stat = "identity", fill = "yellow") +
  labs(title = "Average Casualty by Seatbelt Law Status", 
       x = "Belt Law Status",
       y = "Average Casualty") +
  theme_minimal()
How to Run

Clone the Repository
Use Git to clone the repository to your local machine:
git clone https://github.com/yourusername/your-repo-name.git
Open the Project in RStudio
Open the cloned project folder in RStudio. Ensure that you have R (>= 4.4.3) installed along with the necessary packages. You can install missing packages using:
install.packages(c("dplyr", "ggplot2"))
Run the Scripts
You can either run the scripts interactively in the RStudio console or source them:
source("your_script_name.R")
View Outputs
Check the console for printed outputs.
View the generated plots in the RStudio Plots pane.
The cleaned dataset (cleaned_SeatBelts.csv) will be saved in the project folder.
Project Insights

This analysis helps illustrate:
The overall trend in seatbelt-related casualties over time.
Differences in casualty averages with and without the seatbelt law.
Summary statistics for key variables in the dataset.
Feel free to modify or extend the analysis to suit your needs!
License

This project is licensed under the MIT License.
