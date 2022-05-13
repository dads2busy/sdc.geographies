# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
md_geo_census_2010_counties <- sf::st_read("data/ncr_geo_census_2010_counties/original/md_geo_census_2010_counties.geojson")
dc_geo_census_2010_counties <- sf::st_read("data/ncr_geo_census_2010_counties/original/dc_geo_census_2010_counties.geojson")
va_geo_census_2010_counties <- sf::st_read("data/ncr_geo_census_2010_counties/original/va_geo_census_2010_counties.geojson")

ncr_geo_census_2010_counties <- data.table::rbindlist(list(md_geo_census_2010_counties, dc_geo_census_2010_counties, va_geo_census_2010_counties))


ncr_counties <- yaml::read_yaml("src/01_data/00_dataset_yaml_files/ncr_counties.yml")
ncr_geoids <- character()
for (i in 1:length(ncr_county_geoids$ncr_localities)) {
  ncr_geoids <- c(ncr_geoids, ncr_counties$ncr_localities[[i]]$geoid)
}

ncr_geo_census_2010_counties <- ncr_geo_census_2010_counties[geoid %in% ncr_geoids]
ncr_geo_census_2010_counties <- sf::st_as_sf(ncr_geo_census_2010_counties)

# # Assign geoid
# ncr_geo_census_2010_counties$geoid <- ""
#
# # Assign region_type
# ncr_geo_census_2010_counties$region_type <- "county"
#
# # Assign region_name
# ncr_geo_census_2010_counties$region_name <- ""
#
# # Assign year
# ncr_geo_census_2010_counties$year <- "2010"
#
# # measure, measure_type, and value need to be included in non-geo datasets
#
# # Select final columns
# final_dataset <- ncr_geo_census_2010_counties[, c("geoid", "region_name", "region_type", "year", "geometry")]
#
# # Simplify the geography
# final_dataset_simplified <- rmapshaper::ms_simplify(final_dataset)

# Export final dataset
sf::st_write(ncr_geo_census_2010_counties, "data/ncr_geo_census_2010_counties/distribution/ncr_geo_census_2010_counties.geojson")

# Update file manifest
data_file_checksums()
