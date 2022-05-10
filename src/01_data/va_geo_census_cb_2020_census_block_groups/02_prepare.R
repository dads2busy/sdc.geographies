# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
unzip("data/va_geo_census_cb_2020_census_block_groups/original/va_geo_census_cb_2020_census_block_groups.zip", exdir = "data/va_geo_census_cb_2020_census_block_groups/original/va_geo_census_cb_2020_census_block_groups")
va_geo_census_cb_2020_census_block_groups <- sf::st_read("data/va_geo_census_cb_2020_census_block_groups/original/va_geo_census_cb_2020_census_block_groups/cb_2020_51_bg_500k.shp")
va_geo_census_cb_2020_census_block_groups <- sf::st_transform(va_geo_census_cb_2020_census_block_groups, 4326)

unlink("data/va_geo_census_cb_2020_census_block_groups/original/va_geo_census_cb_2020_census_block_groups", recursive = T)

# Assign geoid
va_geo_census_cb_2020_census_block_groups$geoid <- va_geo_census_cb_2020_census_block_groups$GEOID

# Assign region_type
va_geo_census_cb_2020_census_block_groups$region_type <- "block group"

# Assign region_name
va_geo_census_cb_2020_census_tracts <- sf::st_read("data/va_geo_census_cb_2020_census_tracts/distribution/va_geo_census_cb_2020_census_tracts.geojson")
va_geo_census_cb_2020_census_tracts$region_name_tract <- va_geo_census_cb_2020_census_tracts$region_name

va_geo_census_cb_2020_census_block_groups$tract_id <- substr(va_geo_census_cb_2020_census_block_groups$geoid, 1, 11)

va_geo_census_cb_2020_census_block_groups <- merge(va_geo_census_cb_2020_census_block_groups,
                                                   sf::st_drop_geometry(va_geo_census_cb_2020_census_tracts[, c("geoid", "region_name_tract")]),
                                                   by.x = "tract_id", by.y = "geoid")

va_geo_census_cb_2020_census_block_groups$region_name <- paste0(va_geo_census_cb_2020_census_block_groups$NAMELSAD, ", ", va_geo_census_cb_2020_census_block_groups$region_name_tract)

# Assign year
va_geo_census_cb_2020_census_block_groups$year <- "2020"

# measure, measure_type, and value need to be included in non-geo datasets

# Export final
final_dataset <- va_geo_census_cb_2020_census_block_groups[, c("geoid", "region_name", "region_type", "year", "geometry")]
sf::st_write(final_dataset, "data/va_geo_census_cb_2020_census_block_groups/distribution/va_geo_census_cb_2020_census_block_groups.geojson")
