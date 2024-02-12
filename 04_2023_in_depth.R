library(tidyverse)
library(dplyr)
library(stringr)
library(readr)
library(ggExtra)

co2_data_countries <- read_csv("data/co2_data_selected_columns_countries_only.csv")

co2_data_full <- read_csv("data/visualizing_global_co2_data.csv")

co2_data < - read_csv("data/co2_data_selected_columns.csv")


# co2 and population ------------------------------------------------------

co2_pop_2021 <- co2_data_countries |>
  filter(year == 2021) |>
  ggplot(
    aes(x = population, y = co2)
  ) +
  geom_point() +
  geom_point(data = co2_data_countries
             |> filter(country %in% c('India', 'United States', 'China'))
             |> filter(year == 2021),
             pch = 21,
             size = 5,
             color = 'red') +
  geom_text(x=1.3e+09, y=1.1e+04, label='China') +
  geom_text(x=1.3e+09, y=2e+03, label='India') +
  geom_text(x=3e+08, y=4e+03, label='United States')

co2_pop_2021_dens <-ggMarginal(co2_pop_2021, type='histogram')
co2_pop_2021_dens

# co2_data_countries |>
#   filter(country == 'India') |>
#   filter(year == 2021) |>
#   select(c('co2', 'population'))

co2_pop_2021 <- co2_pop_2021 +
  coord_cartesian(xlim = c(0, 3e+08),
                  ylim = c(0, 2e+03)) +
  geom_smooth(method = lm, level = 0.99)

co2_pop_2021_dens <-ggMarginal(co2_pop_2021, type='boxplot')
co2_pop_2021_dens


# co2 and gdp -------------------------------------------------------------

co2_gdp_2018 <- co2_data_countries |>
  filter(year == 2018) |>
  ggplot(
    aes(x = gdp, y = co2)
  ) +
  geom_point() +
  coord_cartesian(xlim = c(0, 5e+12),
                ylim = c(0, 2e+03)) +
  geom_smooth(method = lm, level = 0.99)

co2_gdp_2018

co2_gdp_2018_dens <-ggMarginal(co2_gdp_2018, type='histogram')
co2_gdp_2018_dens


# checking for nulls ------------------------------------------------------

colSums(is.na(co2_data_countries))

co2_data_countries |>
  filter(!is.na(gdp)) |>
  select(year) |>
  unique() |>
  arrange(desc(year))

View(co2_data_full)  


# pop_gdp -----------------------------------------------------------------



pop_gdp_2018 <- co2_data_countries |>
  filter(year == 2018) |>
  ggplot(
    aes(x = population, y = gdp)
  ) +
  geom_point() +
  coord_cartesian(xlim = c(0, 3e+08),
                  ylim = c(0, 5e+12)) +
  geom_smooth(method = lm, level = 0.99)

pop_gdp_2018

pop_gdp_2018_dens <-ggMarginal(pop_gdp_2018, type='histogram')
pop_gdp_2018_dens


