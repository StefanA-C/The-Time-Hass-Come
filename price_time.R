library(tidyverse)
library(gganimate)
library(gifski)
library(png)
library(patchwork)
library(gapminder)
theme_set(theme_bw())

data <- read_csv("avocado.csv")


clean_data <- data %>%
  mutate(Date = as.Date(Date)) %>%
  mutate(type = if_else(type == "conventional", "Conventional", "Organic")) %>% 
  subset(region != "WestTexNewMexico")

clean_graph <- clean_data %>%
  filter(region == "TotalUS") %>%
  ggplot(aes(Date, AveragePrice, color = type))+
  geom_line()+
  transition_reveal(Date)+
  labs(title = "The Price of Avocados Over Time by Type of Fruit",
       subtitle = "The overall difference in price between type of avocado\nhas remained constant through fluctations",
       y = "Average Price", color = "Type of Avocado")+
  scale_y_continuous()+
  view_follow(fixed_y = TRUE)

 clean_data %>%
  filter(region == "TotalUS") %>%
  ggplot(aes(Date, AveragePrice, color = type))+
  geom_line()+
  labs(title = "The Price of Avocados Over Time by Type of Fruit",
       subtitle = "The overall difference in price between type of avocado\nhas remained constant through fluctations",
       y = "Average Price", color = "Type of Avocado")+
  scale_y_continuous()


write_rds(clean_graph, "price_time_graph.rds")

