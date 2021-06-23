library(tidyverse)
library(gganimate)
library(gifski)
library(png)
library(patchwork)
library(gapminder)
theme_set(theme_bw())

data <- read_csv("avocado.csv")

#data cleaning
clean_data <- data %>%
  mutate(Date = as.Date(Date)) %>%
  mutate(type = if_else(type == "conventional", "Conventional", "Organic")) %>% 
  subset(region != "WestTexNewMexico")

# animated graph
clean_graph <- clean_data %>%
  filter(region == "TotalUS") %>%
  ggplot(aes(Date, `Total Volume`/1000000, color = type))+
  geom_line()+
  transition_reveal(Date)+
  labs(title = "The Volume of Avocados Sold Over Time by Type of Fruit",
       subtitle = "The overall volume of avocados has significant fluctuations depending on the type of fruit",
       y = "Total Volume in Millions", color = "Type of Avocado")+
  view_follow(fixed_y = TRUE)

#not animated graph
clean_graph2 <- clean_data %>%
  filter(region == "TotalUS") %>%
  ggplot(aes(Date, `Total Volume`/1000000, color = type))+
  geom_line()+
  labs(title = "The Volume of Avocados Sold Over Time by Type of Fruit",
       subtitle = "The overall volume of avocados has significant fluctuations depending on the type of fruit",
       y = "Total Volume in Millions", color = "Type of Avocado") 
clean_graph2
  

write_rds(clean_graph, "volume_time_graph.rds")


