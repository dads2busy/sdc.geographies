# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
va_geo_census_cb_2020_census_tracts <- sf::st_read("data/va_geo_census_cb_2020_census_tracts/original/va_geo_census_cb_2020_census_tracts.geojson")

# Assign geoid
va_geo_census_cb_2020_census_tracts$geoid <- ""

# Assign region_type
va_geo_census_cb_2020_census_tracts$region_type <- ""

# Assign region_name
va_geo_census_cb_2020_census_tracts$region_name <- ""

# Assign year
va_geo_census_cb_2020_census_tracts$year <- "2020"

# measure, measure_type, and value need to be included in non-geo datasets

# Export final
final_data_set <- va_geo_census_cb_2020_census_tracts[, c("geoid", "region_name", "region_type", "year", "geometry", ...)]
sf::st_write(final_data_set, "data/va_geo_census_cb_2020_census_tracts/distribution/va_geo_census_cb_2020_census_tracts.geojson")
