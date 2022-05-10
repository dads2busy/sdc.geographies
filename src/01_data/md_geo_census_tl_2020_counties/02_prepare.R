# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
unzip("data/md_geo_census_tl_2020_counties/original/md_geo_census_tl_2020_counties.zip", exdir = "data/md_geo_census_tl_2020_counties/original/md_geo_census_tl_2020_counties")
md_geo_census_tl_2020_counties <- sf::st_read("data/md_geo_census_tl_2020_counties/original/md_geo_census_tl_2020_counties/tl_2020_us_county.shp")
md_geo_census_tl_2020_counties <- md_geo_census_tl_2020_counties[md_geo_census_tl_2020_counties$STATEFP == 24,]
md_geo_census_tl_2020_counties <- sf::st_transform(md_geo_census_tl_2020_counties, 4326)

unlink("data/md_geo_census_tl_2020_counties/original/md_geo_census_tl_2020_counties", recursive = T)

# Assign geoid
md_geo_census_tl_2020_counties$geoid <- md_geo_census_tl_2020_counties$GEOID

# Assign region_type
md_geo_census_tl_2020_counties$region_type <- "county"

# Assign region_name
md_geo_census_tl_2020_counties$region_name <- paste0(md_geo_census_tl_2020_counties$NAMELSAD, ", ", "Maryland")

# Assign year
md_geo_census_tl_2020_counties$year <- "2020"

# measure, measure_type, and value need to be included in non-geo datasets

# Export final
final_dataset <- md_geo_census_tl_2020_counties[, c("geoid", "region_name", "region_type", "year", "geometry")]
sf::st_write(final_dataset, "data/md_geo_census_tl_2020_counties/distribution/md_geo_census_tl_2020_counties.geojson")
