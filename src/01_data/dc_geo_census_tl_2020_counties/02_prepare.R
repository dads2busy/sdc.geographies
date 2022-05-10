# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
unzip("data/dc_geo_census_tl_2020_counties/original/dc_geo_census_tl_2020_counties.zip", exdir = "data/dc_geo_census_tl_2020_counties/original/dc_geo_census_tl_2020_counties")
dc_geo_census_tl_2020_counties <- sf::st_read("data/dc_geo_census_tl_2020_counties/original/dc_geo_census_tl_2020_counties/tl_2020_us_county.shp")
dc_geo_census_tl_2020_counties <- dc_geo_census_tl_2020_counties[dc_geo_census_tl_2020_counties$STATEFP == 11,]
dc_geo_census_tl_2020_counties <- sf::st_transform(dc_geo_census_tl_2020_counties, 4326)

unlink("data/dc_geo_census_tl_2020_counties/original/dc_geo_census_tl_2020_counties", recursive = T)

# Assign geoid
dc_geo_census_tl_2020_counties$geoid <- dc_geo_census_tl_2020_counties$GEOID

# Assign region_type
dc_geo_census_tl_2020_counties$region_type <- "county"

# Assign region_name
dc_geo_census_tl_2020_counties$region_name <- paste0(dc_geo_census_tl_2020_counties$NAMELSAD, ", ", "Washington DC")

# Assign year
dc_geo_census_tl_2020_counties$year <- "2020"

# measure, measure_type, and value need to be included in non-geo datasets

# Export final
final_dataset <- dc_geo_census_tl_2020_counties[, c("geoid", "region_name", "region_type", "year", "geometry")]
sf::st_write(final_dataset, "data/dc_geo_census_tl_2020_counties/distribution/dc_geo_census_tl_2020_counties.geojson")
