library(tidyverse)
library(dplyr)
library(stringr)
library(readr)
library(ggExtra)

co2_data <- read_csv("data/co2_data_selected_columns.csv")

european_entities <- co2_data |>
  filter(str_detect(country, "European.*")) |>
  select('country') |>
  unique()

countries_entities <- co2_data |>
  filter(str_detect(country, ".*countries.*")) |>
  select('country') |>
  unique()

OECD_entities <- co2_data |>
  filter(str_detect(country, ".*OECD.*")) |>
  select('country') |>
  unique()

europe_entities <- co2_data |>
  filter(str_detect(country, ".*Europe.*")) |>
  select('country') |>
  unique()

asia_entities <- co2_data |>
  filter(str_detect(country, ".*Asia.*")) |>
  select('country') |>
  unique()

na_entities <- co2_data |>
  filter(str_detect(country, "North America.*")) |>
  select('country') |>
  unique()

sa_entities <- co2_data |>
  filter(str_detect(country, "South America.*")) |>
  select('country') |>
  unique()

ca_entities <- co2_data |>
  filter(str_detect(country, "Central America.*")) |>
  select('country') |>
  unique()

fr_africa_entities <- co2_data |>
  filter(str_detect(country, "French.*Africa.*")) |>
  select('country') |>
  unique()

africa_entities <- co2_data |>
  filter(str_detect(country, "Africa.*")) |>
  select('country') |>
  unique()

middle_east_entities <- co2_data |>
  filter(str_detect(country, "Middle East.*")) |>
  select('country') |>
  unique()

oceania_entities <- co2_data |>
  filter(str_detect(country, "Oceania.*")) |>
  select('country') |>
  unique()


non_country_entities <- c(european_entities, countries_entities,
                          OECD_entities, europe_entities,
                          asia_entities, na_entities,
                          sa_entities, ca_entities,
                          fr_africa_entities, africa_entities,
                          middle_east_entities, "World",
                          "International transport",
                          oceania_entities)
non_country_entities <- unlist(non_country_entities, use.names=FALSE)

typeof(non_country_entities)

non_country_entities
# list of non-country (continent etc entities)

# co2_data_countries <- co2_data |>
#   filter(!country %in% non_country_entities) |>
#   select('country') |>
#   unique()

co2_data_countries <- co2_data |>
  filter(!country %in% non_country_entities)

write.csv(
  co2_data_countries,
  "data/co2_data_selected_columns_countries_only.csv",
  row.names=FALSE)

co2_data_non_countries <- co2_data |>
  filter(country %in% non_country_entities)

write.csv(
  co2_data_non_countries,
  "data/co2_data_selected_columns_non_countries_only.csv",
  row.names = FALSE)

saveRDS(non_country_entities, file="non_country_entities.rds")
