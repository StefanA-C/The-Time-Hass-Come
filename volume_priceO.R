#removed TotalUS
library(tidyverse)
library(gganimate)
library(gifski)
library(png)
library(patchwork)
library(gapminder)
library(lubridate)
theme_set(theme_bw())

data <- read_csv("avocado.csv")
data

clean_data <- data %>%
  mutate(Date = as.Date(Date)) %>%
  mutate(type = if_else(type == "conventional", "Conventional", "Organic")) %>% 
  subset(region != "WestTexNewMexico")

gplot_o <- clean_data %>%
  filter(region != "TotalUS") %>%
  filter(type == "Organic") %>%
  select(-year) %>% 
  ggplot(aes(y = `Total Volume`/1000, x=AveragePrice, color = region)) +
  geom_point(show.legend = F, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  labs(title = "Price Volume Graph of the Sale of Organic Avocados Across All US States",
       y = "Total Volume in Thousands", x = "Average Price") 

best <- gplot_o + transition_time(Date) +
  labs(subtitle = "Date: {frame_time}")

write_rds(best, "price_volume_graphO.rds")
