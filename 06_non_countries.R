co2_data_non_countries <- read_csv("data/co2_data_selected_columns_non_countries_only.csv")

co2_data_non_countries

non_countries_grouped <- co2_data_non_countries |>
  group_by(country) |>
  summarize(
   co2_total = sum(co2, na.rm = TRUE),
   pop_max = max(population, na.rm = TRUE),
   gdp_total = sum(gdp, na.rm = TRUE),
   co2_per_capita_total = sum(co2_per_capita, na.rm = TRUE)
  )

co2_data_non_countries |>
  ggplot(
    aes(x = year, y = co2)
  ) +
  geom_point()

non_countries_grouped |>
  arrange(desc(co2_total))

income_split <- co2_data |>
  filter(str_detect(country, '.*income.*'))

write.csv(income_split, "data/co2_data_by_income.csv")

income_split |>
  ggplot(
    aes(x = year, y = co2, color = country)
  ) +
  geom_point() +
  ggtitle(label="co2 emissions by year per income group")


# income_split |>
#   ggplot(
#     aes(x = year, y = gdp, color = country)
#   ) +
#   geom_point() +
#   ggtitle(label="gdp by year per income group")


income_split |>
  ggplot(
    aes(x = year, y = population, color = country)
  ) +
  geom_point() +
  ggtitle(label="population by year per income group")

# boxplots

income_split |>
  ggplot(
    aes(x = country, y = co2)
  ) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = -90, vjust = 0.5, hjust=1)) +
  ggtitle(label="co2 distribution per income group")


# continents etc ----------------------------------------------------------

co2_data_non_countries |>
  select(country) |>
  unique() |>
  print(n=40)


continents = c('Africa', 'Asia', 'Asia (excl. China and India)',
               'Central America (GCP)', 'Europe', 'International transport',
               'Middle East (GCP)', 'North America',
               'North America (excl. USA)', 'Oceania',
               'South America (GCP)')

co2_data_continents <- co2_data_non_countries |>
  filter(country %in% continents)

write.csv(co2_data_continents, "data/co2_data_continents.csv")

co2_data_continents |>
  ggplot(
    aes(x = year, y = co2, color = country)
  ) +
  geom_point() +
  ggtitle(label="co2 emissions per continent / important region")
