library(tidyverse)
library(readr)

co2_data_full <- read_csv("data/visualizing_global_co2_data.csv")

library(readxl)

co2_data_dict <- read_xlsx("data/visualizing_global_CO2_emissions_data_dictionary.xlsx")    

View(co2_data_full)
View(co2_data_dict)

co2_data <- co2_data_full |>
  select(country, year, iso_code, population, gdp,  co2, co2_per_capita,
         co2_per_gdp, co2_per_unit_energy, coal_co2, coal_co2_per_capita,
         consumption_co2, consumption_co2_per_capita, cumulative_co2,
         energy_per_capita, energy_per_gdp, oil_co2, oil_co2_per_capita,
         ghg_per_capita, share_global_co2, share_global_coal_co2,
         temperature_change_from_co2,
         trade_co2, co2_including_luc,
         co2_including_luc_per_capita
         )

co2_data <- co2_data |>
  mutate(
    gdp_per_capita = round(gdp / population, 3),
    .after = gdp
  )

co2_data$gdp_per_capita

co2_data <- co2_data |>
  select(-c('after'))

View(co2_data)

# plotting

ggplot(
  co2_data,
  aes(x = year, y = co2)
) +
  geom_point()

co2_data_by_country <- co2_data |>
  group_by(country, year) |>
  summarize(across(-c('iso_code'), ~mean(., na.rm = TRUE)))
#  summarize_all("mean")
#  summarize(
#    avg_co2 = mean(co2),
#    avg_co2_per_capita = mean(co2_per_capita)
#  )

co2_data_by_country

latest_co2_data_by_county <- co2_data_by_country |>
  filter(year == max(year))

latest_co2_data_by_county

lowest_pop_10 <- latest_co2_data_by_county |>
  arrange(population) |>
  head(10)

lowest_pop_10_val <- max(lowest_pop_10$population)
lowest_pop_10_val


# get top 10 co2_per_capita where population is above lowest 10
top10_co2_per_capita <- co2_data |>
  filter(
    population > lowest_pop_10_val
  ) |>
  slice_max(
    order_by = co2_per_capita,
    n = 10
  )

ggplot(
  top10_co2_per_capita,
  aes(x = year, y = co2)
) +
  geom_point()
