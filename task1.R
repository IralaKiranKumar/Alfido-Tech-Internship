install.packages(c("ggplot2", "dplyr", "plotly", "tidyverse"))
library(ggplot2)
library(dplyr)
library(plotly)
library(tidyverse)
library(readxl)
library(readxl)
zomato <- read_excel("D:/zomato.xlsx")
print(head(zomato))
print(tail(zomato))
str(zomato)
summary(zomato)
#Barplot
ggplot(zomato %>% count(name, sort = TRUE) %>% head(10),
       aes(x = reorder(name, -n), y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Top 10 Cities with Most Restaurants", x = "name", y = "Count") +
  theme_minimal()

# Histogram
library(ggplot2)
ggplot(zomato,aes(x=votes))+geom_histogram(binwidth = 2,fill="blue",color="red",alpha=0.8)+labs(title="rate percent",x="rate",y="name")
zomato$votes <- as.numeric(as.character(zomato$votes))

#piechart
file_path <- "D:/zomato.xlsx"
zomato_data <- read_excel(file_path, sheet = "zomato")
top_rest_types <- zomato_data %>%
  count(rest_type, sort = TRUE) %>%
  top_n(6, n)
ggplot(top_rest_types, aes(x = "", y = n, fill = rest_type)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  labs(title = "Top 6 Restaurant Types in Dataset", fill = "Restaurant Type") +
  theme_void()

#scatterplot
ggplot(zomato, aes(x = votes, y = rate)) +
  geom_point(alpha = 0.5, color = "red") +
  labs(title = "Scatter Plot: Cost vs Rating",
       x = "Average Cost for Two",
       y = "Aggregate Rating") +
  theme_minimal()
colnames(zomato)
#missing values
colSums(is.na(zomato))

#structure
dim(zomato)
names(zomato)

#filter data
subset(zomato,rate>4)
zomato[,c("name","rate")]

#sorting
zomato[order(zomato$rate,decreasing = TRUE),]

#plot
library(ggplot2)
ggplot(zomato,aes(x=votes))+geom_histogram(binwidth=0.5,fill="steelblue",color="black")
