library(tidyverse)
library(dplyr)
library(stringr)
library(readr)
library(ggExtra)

non_country_entities <- readRDS(file = "non_country_entities.rds")

non_country_entities

co2_data < - read_csv("data/co2_data_selected_columns.csv")

# group and sum by country ------------------------------------------------

# co2_data_by_country <- co2_data |>
#   group_by(country) |>
#   summarize(across(-c('iso_code', 'year'), ~sum(., na.rm = TRUE)))

co2_data_countries <- read_csv("data/co2_data_selected_columns_countries_only.csv")

co2_data_by_country <- co2_data_countries |>
  group_by(country) |>
  summarize(total_co2 = sum(co2, na.rm = TRUE))

co2_data_by_country

# write.csv(co2_data_by_county, "data/co2_data_countries_sum")

top10_co2_countries <- co2_data_by_country |>
  arrange(desc(total_co2)) |>
  head(10) |>
  select('country')

top10_co2_countries <- unlist(top10_co2_countries, use.names=FALSE)

saveRDS(top10_co2_countries, file="top10_co2_countries_names.rds")

co2_data |>
  filter(country %in% top10_co2_countries) |>
  ggplot(
    aes(x = year, y=co2, color=country)
  ) +
  geom_line(size=2) +
  ggtitle("Total co2 emissions over time for top 10 countries")



# looking at individual countries -----------------------------------------

co2_data |>
  filter(country %in% top10_co2_countries) |>
  ggplot(
    aes(x = year, y = co2, color = country)
  ) +
  geom_line(size = 2) +
  ggtitle("Co2 emissions faceted by country") +
  facet_wrap(~ country)


co2_data |>
  filter(country == 'United States') |>
  ggplot(
    aes(x = year, y = co2, color = country)
  ) +
  geom_line(size = 2) +
  ggtitle("United States")


co2_data |>
  filter(country == 'United States') |>
  ggplot(
    aes(x = year, y = co2, color = country)
  ) +
  geom_line(size = 2) +
  geom_vline(xintercept = 1930, linetype='dashed',
             color = 'blue', size = 1.2) +
  geom_text(x=1930, y = 6000, label = "The Great Depression",
            color = 'blue') +
  geom_vline(xintercept = 2008, linetype='dashed',
             color = 'green', size = 1.2) +
  geom_text(x=2000, y = 2000, label = "The 2008 Crash",
            color = 'green') +
  ggtitle("United States")


co2_data |>
  filter(country == 'Germany') |>
  ggplot(
    aes(x = year, y = co2, color = country)
  ) +
  geom_line(size = 2) +
  geom_vline(xintercept = 1933, linetype='dashed',
             color = 'brown', size = 1.2) +
  geom_text(x=1920, y = 950, label = "Hitler assigned as Chancellor",
            color = 'brown') +
  geom_vline(xintercept = 1945, linetype='dashed',
             color = 'blue', size = 1.2) +
  geom_text(x=1945, y = 900, label = "End of WW2",
            color = 'blue') +
  geom_vline(xintercept = 1989, linetype='dashed',
             color = 'green', size = 1.2) +
  geom_text(x=1989, y = 300, label = "The Fall of The Berlin Wall",
            color = 'green') +
  ggtitle("Germany")


co2_data |>
  filter(country == 'China') |>
  ggplot(
    aes(x = year, y = co2, color = country)
  ) +
  geom_line(size = 2) +
  geom_vline(xintercept = 2012, linetype='dashed',
             color = 'green', size = 1.2) +
  geom_text(x=2012, y = 3000, label = "Xi Jinping",
            color = 'green') +
  ggtitle("China")



# bottom 10 countries -----------------------------------------------------

bot10_co2_countries <- co2_data_by_country |>
  filter(total_co2 > 0) |>
  arrange(total_co2) |>
  head(10) |>
  select('country')

bot10_co2_countries <- unlist(bot10_co2_countries, use.names=FALSE)

bot10_co2_countries

saveRDS(bot10_co2_countries, file="bot10_co2_countries_names.rds")

co2_data |>
  filter(country %in% bot10_co2_countries) |>
  ggplot(
    aes(x = year, y=co2, color=country)
  ) +
  geom_line(size=2) +
  ggtitle("Total co2 emissions over time for bottom 10 countries")


# countries by popularity -------------------------------------------------

pop_data_by_country <- co2_data_countries |>
  group_by(country) |>
  summarize(total_pop = sum(population, na.rm = TRUE))

top10_pop_countries <- pop_data_by_country |>
  arrange(desc(total_pop)) |>
  head(10) |>
  select('country')

top10_pop_countries <- unlist(top10_pop_countries, use.names=FALSE)

saveRDS(top10_pop_countries, file="top10_pop_countries_names.rds")

co2_data |>
  filter(country %in% top10_pop_countries) |>
  ggplot(
    aes(x = year, y=population, color=country)
  ) +
  geom_line(size=2) +
  ggtitle("Total population over time for top 10 countries")


# co2 and population with 2 axes ------------------------------------------

max_co2_US <- co2_data |>
  filter(country == 'United States') |>
  select('co2') |>
  max(na.rm = TRUE)

max_pop_US <- co2_data |>
  filter(country == 'United States') |>
  select('population') |>
  max(na.rm = TRUE)

scaleFactor <- max_co2_US / max_pop_US

co2_data |>
  filter(country == 'United States') |>
  ggplot(
    aes(x = year)
  ) +
  geom_line(aes(y = co2, color = "co2")) +
  geom_line(aes(y = population * scaleFactor, color = "population")) +
  scale_y_continuous(
    name = "co2",
    sec.axis = sec_axis(~./scaleFactor, name = 'population')
  ) +
  ggtitle("Co2 and population for United States")



# top 10 countries vs rest of world ---------------------------------------

top10_co2_countries_data <- co2_data |>
  filter(country %in% top10_co2_countries)

top10_co2_data_by_year <- top10_co2_countries_data |>
  group_by(year) |>
  summarize(total_co2 = sum(co2, na.rm = TRUE))

not_top10_co2_countries_data <- co2_data |>
  filter(!country %in% top10_co2_countries)

not_top10_co2_data_by_year <- not_top10_co2_countries_data |>
  group_by(year) |>
  summarize(total_co2 = sum(co2, na.rm = TRUE))

top10_co2_data_by_year

ggplot(NULL, aes(x=year, y=total_co2)) +
  geom_line(data = top10_co2_data_by_year,
            aes(color = 'top 10')) +
  geom_line(data = not_top10_co2_data_by_year,
            aes(color = 'rest of world')) +
  ggtitle("Top10 vs not top 10 sum")


# donut
top10_co2_sum <- sum(top10_co2_data_by_year$total_co2)
not_top10_co2_sum <- sum(not_top10_co2_data_by_year$total_co2)

donut_data <- data.frame(
  group = c('top 10', 'rest of world'),
  value = c(top10_co2_sum, not_top10_co2_sum)
)

ggplot(donut_data, aes(x="", y=value, fill=group)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0)

# co2 vs population scatter -----------------------------------------------

top10_co2_countries_data |>
  ggplot(
    aes(x = population, y = co2, color=country)
  ) +
  geom_point()

# zoomed
top10_co2_countries_data |>
  ggplot(
    aes(x = population, y = co2, color=country)
  ) +
  geom_point() +
  coord_cartesian(xlim = c(0, 350000000))
