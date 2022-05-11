# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
unzip("data/va_geo_census_cb_2020_census_tracts/original/va_geo_census_cb_2020_census_tracts.zip", exdir = "data/va_geo_census_cb_2020_census_tracts/original/va_geo_census_cb_2020_census_tracts")
va_geo_census_cb_2020_census_tracts <- sf::st_read("data/va_geo_census_cb_2020_census_tracts/original/va_geo_census_cb_2020_census_tracts/cb_2020_51_tract_500k.shp")
va_geo_census_cb_2020_census_tracts <- sf::st_transform(va_geo_census_cb_2020_census_tracts, 4326)

unlink("data/va_geo_census_cb_2020_census_tracts/original/va_geo_census_cb_2020_census_tracts", recursive = T)

# Assign geoid
va_geo_census_cb_2020_census_tracts$geoid <- va_geo_census_cb_2020_census_tracts$GEOID

# Assign region_type
va_geo_census_cb_2020_census_tracts$region_type <- "tract"

# Assign region_name
va_geo_census_cb_2020_census_tracts$region_name <-
  paste0(
    va_geo_census_cb_2020_census_tracts$NAMELSAD,
    ", ",
    va_geo_census_cb_2020_census_tracts$NAMELSADCO,
    ", ",
    va_geo_census_cb_2020_census_tracts$STATE_NAME
  )

# Assign year
va_geo_census_cb_2020_census_tracts$year <- "2020"

# measure, measure_type, and value need to be included in non-geo datasets

# Select final columns
final_dataset <- va_geo_census_cb_2020_census_tracts[, c("geoid", "region_name", "region_type", "year", "geometry")]

# Simplify the geography
final_dataset_simplified <- rmapshaper::ms_simplify(final_dataset)

# Export final dataset
sf::st_write(final_dataset_simplified, "data/va_geo_census_cb_2020_census_tracts/distribution/va_geo_census_cb_2020_census_tracts.geojson")

# Update file manifest
data_file_checksums()
