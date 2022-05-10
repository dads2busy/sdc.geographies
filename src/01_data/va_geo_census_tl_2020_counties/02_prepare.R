# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
unzip("data/va_geo_census_tl_2020_counties/original/va_geo_census_tl_2020_counties.zip", exdir = "data/va_geo_census_tl_2020_counties/original/va_geo_census_tl_2020_counties")
va_geo_census_tl_2020_counties <- sf::st_read("data/va_geo_census_tl_2020_counties/original/va_geo_census_tl_2020_counties/tl_2020_us_county.shp")
va_geo_census_tl_2020_counties <- va_geo_census_tl_2020_counties[va_geo_census_tl_2020_counties$STATEFP == 51,]
va_geo_census_tl_2020_counties <- sf::st_transform(va_geo_census_tl_2020_counties, 4326)

unlink("data/va_geo_census_tl_2020_counties/original/va_geo_census_tl_2020_counties", recursive = T)

# Assign geoid
va_geo_census_tl_2020_counties$geoid <- va_geo_census_tl_2020_counties$GEOID

# Assign region_type
va_geo_census_tl_2020_counties$region_type <- "county"

# Assign region_name
va_geo_census_tl_2020_counties$region_name <- paste0(va_geo_census_tl_2020_counties$NAMELSAD, ", ", "Virginia")

# Assign year
va_geo_census_tl_2020_counties$year <- "2020"

# measure, measure_type, and value need to be included in non-geo datasets

# Export final
final_dataset <- va_geo_census_tl_2020_counties[, c("geoid", "region_name", "region_type", "year", "geometry")]
sf::st_write(final_dataset, "data/va_geo_census_tl_2020_counties/distribution/va_geo_census_tl_2020_counties.geojson")
