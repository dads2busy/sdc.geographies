# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
unzip("data/dc_geo_census_cb_2020_census_block_groups/original/dc_geo_census_cb_2020_census_block_groups.zip", exdir = "data/dc_geo_census_cb_2020_census_block_groups/original/dc_geo_census_cb_2020_census_block_groups")
dc_geo_census_cb_2020_census_block_groups <- sf::st_read("data/dc_geo_census_cb_2020_census_block_groups/original/dc_geo_census_cb_2020_census_block_groups/cb_2020_11_bg_500k.shp")
dc_geo_census_cb_2020_census_block_groups <- sf::st_transform(dc_geo_census_cb_2020_census_block_groups, 4326)

unlink("data/dc_geo_census_cb_2020_census_block_groups/original/dc_geo_census_cb_2020_census_block_groups", recursive = T)

# Assign geoid
dc_geo_census_cb_2020_census_block_groups$geoid <- dc_geo_census_cb_2020_census_block_groups$GEOID

# Assign region_type
dc_geo_census_cb_2020_census_block_groups$region_type <- "block group"

# Assign region_name
dc_geo_census_cb_2020_census_tracts <- sf::st_read("data/dc_geo_census_cb_2020_census_tracts/distribution/dc_geo_census_cb_2020_census_tracts.geojson")
dc_geo_census_cb_2020_census_tracts$region_name_tract <- dc_geo_census_cb_2020_census_tracts$region_name

dc_geo_census_cb_2020_census_block_groups$tract_id <- substr(dc_geo_census_cb_2020_census_block_groups$geoid, 1, 11)

dc_geo_census_cb_2020_census_block_groups <- merge(dc_geo_census_cb_2020_census_block_groups,
             sf::st_drop_geometry(dc_geo_census_cb_2020_census_tracts[, c("geoid", "region_name_tract")]),
             by.x = "tract_id", by.y = "geoid")

dc_geo_census_cb_2020_census_block_groups$region_name <- paste0(dc_geo_census_cb_2020_census_block_groups$NAMELSAD, ", ", dc_geo_census_cb_2020_census_block_groups$region_name_tract)

# Assign year
dc_geo_census_cb_2020_census_block_groups$year <- "2020"

# measure, measure_type, and value need to be included in non-geo datasets

# Export final
final_dataset <- dc_geo_census_cb_2020_census_block_groups[, c("geoid", "region_name", "region_type", "year", "geometry")]
sf::st_write(final_dataset, "data/dc_geo_census_cb_2020_census_block_groups/distribution/dc_geo_census_cb_2020_census_block_groups.geojson")
