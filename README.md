# R EDA project / Co2 emissions

### An exploratiion of R, ggplot, the co2 emissions dataset, maybe even modelling

data present in data folder with an explanatory column dict

### main columns of interest are:
limited in order to bring focus to certain parts of data and reduce some redundancy

country, year, iso_code, population, gdp,  co2, co2_per_capita, co2_per_gdp, co2_per_unit_energy, coal_co2, coal_co2_per_capita, consumption_co2, consumption_co2_per_capita, cumulative_co2, energy_per_capita, energy_per_gdp, oil_co2, oil_co2_per_capita, 	ghg_per_capita, share_global_co2, share_global_coal_co2, 	temperature_change_from_co2, trade_co2, co2_including_luc, co2_including_luc_per_capita

where:
* co2 - Annual total emissions of carbon dioxide (CO2), excluding land-use change, measured in million tonnes.
* co2_per_unit_energy - Annual CO2 emissions per unit energy (kg per kilowatt-hour)
* coal_co2 - Annual emissions of carbon dioxide (CO2) from coal, measured in million tonnes.
* cumulative_co2 - Total cumulative emissions of carbon dioxide (CO2), excluding land-use change, since the first year of available data, measured in million tonnes
* energy_per_capita - Primary energy consumption per capita, measured in kilowatt-hours per person per year.
* ghg_per_capita - green house gas
* share_global_co2 - Share of global annual CO2 emissions - Annual total emissions of carbon dioxide (CO2), excluding land-use change, measured as a percentage of global emissions of CO2 in the same year.
* temperature_change_from_co2 - Change in global mean surface temperature (in Â°C) caused by CO2 emissions. This measures each country's contribution to global mean surface temperature (GMST) rise from its cumulative emissions of carbon dioxide. The warming effects of each gas are calculated based on cumulative CO2-equivalent emissions using the Global Warming Potential (GWP*) approach.
* trade_co2 - Annual net carbon dioxide (CO2) emissions embedded in trade, measured in million tonnes.
* co2_including_luc - Annual total emissions of carbon dioxide (CO2), including land-use change, measured in million tonnes
* 