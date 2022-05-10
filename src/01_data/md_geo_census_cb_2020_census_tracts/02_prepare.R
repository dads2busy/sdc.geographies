# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
unzip("data/md_geo_census_cb_2020_census_tracts/original/md_geo_census_cb_2020_census_tracts.zip", exdir = "data/md_geo_census_cb_2020_census_tracts/original")
md_geo_census_cb_2020_census_tracts <- sf::st_read("data/md_geo_census_cb_2020_census_tracts/original/cb_2020_24_tract_500k.shp")
md_geo_census_cb_2020_census_tracts <- sf::st_transform(md_geo_census_cb_2020_census_tracts, 4326)

# Assign geoid
md_geo_census_cb_2020_census_tracts$geoid <- md_geo_census_cb_2020_census_tracts$GEOID

# Assign region_type
md_geo_census_cb_2020_census_tracts$region_type <- "tract"

# Assign region_name
md_geo_census_cb_2020_census_tracts$region_name <-
  paste0(
    md_geo_census_cb_2020_census_tracts$NAMELSAD,
    ", ",
    md_geo_census_cb_2020_census_tracts$NAMELSADCO,
    ", ",
    md_geo_census_cb_2020_census_tracts$STATE_NAME
  )

# Assign year
md_geo_census_cb_2020_census_tracts$year <- "2020"

# measure, measure_type, and value need to be included in non-geo datasets

# Export final
final_dataset <- md_geo_census_cb_2020_census_tracts[, c("geoid", "region_name", "region_type", "year", "geometry")]
sf::st_write(final_dataset, "data/md_geo_census_cb_2020_census_tracts/distribution/md_geo_census_cb_2020_census_tracts.geojson")
