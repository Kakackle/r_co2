colnames(co2_data)


# co2 per capita ----------------------------------------------------------

co2_data_countries |>
  ggplot(
    aes(x = year, y = co2_per_capita)
  ) +
  geom_point() +
  ggtitle(label="Co2 per capita")


co2_data_countries |>
  filter(co2_per_capita > 200)


co2_data_countries |>
  ggplot(
    aes(x = population, y = co2_per_capita)
  ) +
  geom_point() +
  ggtitle(label="Co2 per capita against population")


# co2 per unit energy -----------------------------------------------------
# + energy_per_capita
co2_data_countries |>
  ggplot(
    aes(x = year, y = co2_per_unit_energy)
  ) +
  geom_point() +
  ggtitle(label="co2 per unity energy")

co2_data_countries |>
  ggplot(
    aes(x = year, y = energy_per_capita)
  ) +
  geom_point() +
  ggtitle(label="energy_per_capita")


# categories --------------------------------------------------------------

# categories = c('coal_co2', 'consumption_co2', 'oil_co2',
#                'trade_co2', 'co2_including_luc')
categories = c('coal_co2', 'consumption_co2', 'oil_co2',
               'trade_co2')

co2_data_categories <- subset(co2_data_countries, select=categories)

co2_data_categories_pivot <- tidyr::pivot_longer(co2_data_categories, categories)

co2_data_cat_pivot_group <- co2_data_categories_pivot |>
  group_by(name) |>
  summarize(
    value_sum = sum(value, na.rm = TRUE)
  )

# co2_data_categories_pivot |>
#   ggplot(
#     aes(name, value, fill=name)
#   ) +
#   geom_col(position='fill')

ggplot(co2_data_cat_pivot_group,
       aes(x="", y=value_sum, fill=name)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  ggtitle(label="coal, consumption, oil, trade co2 emissions (tonnes)")

# categories by continent, income group

categories_country = c('country', 'coal_co2', 'consumption_co2', 'oil_co2',
                       'trade_co2')

income_data_categories <- subset(income_split, select=categories_country)

income_data_categories_pivot <- tidyr::pivot_longer(income_data_categories, categories)

income_data_cat_pivot_group <- income_data_categories_pivot |>
  group_by(country, name) |>
  summarize(
    value_sum = sum(value, na.rm = TRUE)
  )

income_data_cat_pivot_group |>
  ggplot(
    aes(country, value_sum, fill = name)
    ) +
  geom_col(position = 'fill') +
  theme(axis.text.x = element_text(angle = -90, vjust = 0.5, hjust=1)) +
  coord_cartesian(ylim = c(0, 1)) +
  ggtitle(label = "contribution by income group")

income_data_cat_pivot_group


# continent

continent_data_categories <- subset(co2_data_continents, select=categories_country)

continent_data_categories_pivot <- tidyr::pivot_longer(continent_data_categories, categories)

continent_data_cat_pivot_group <- continent_data_categories_pivot |>
  group_by(country, name) |>
  summarize(
    value_sum = sum(value, na.rm = TRUE)
  )

continent_data_cat_pivot_group |>
  ggplot(
    aes(country, value_sum, fill = name)
  ) +
  geom_col(position = 'fill') +
  theme(axis.text.x = element_text(angle = -90, vjust = 0.5, hjust=1)) +
  coord_cartesian(ylim = c(0, 1)) +
  ggtitle(label = "contribution by continent")

continent_data_cat_pivot_group

# temperature_change_from_co2 ---------------------------------------------

co2_data_countries |>
  ggplot(
    aes(x = year, y = temperature_change_from_co2)
  ) +
  geom_point() +
  ggtitle(label="temperature_change_from_co2")



