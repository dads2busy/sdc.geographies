# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
md_geo_census_cb_2010_census_tracts.geojson <- sf::st_read("data/va000_geo_test_2021_tests/original/md_geo_census_cb_2010_census_tracts.geojson")
dc_geo_census_cb_2010_census_tracts.geojson <- sf::st_read("data/va000_geo_test_2021_tests/original/dc_geo_census_cb_2010_census_tracts.geojson")

va000_geo_test_2021_tests <- 

# Assign geoid
va000_geo_test_2021_tests$geoid <- ""

# Assign region_type
va000_geo_test_2021_tests$region_type <- "test"

# Assign region_name
va000_geo_test_2021_tests$region_name <- ""

# Assign year
va000_geo_test_2021_tests$year <- "2021"

# measure, measure_type, and value need to be included in non-geo datasets

# Select final columns
final_dataset <- va000_geo_test_2021_tests[, c("geoid", "region_name", "region_type", "year", "geometry")]

# Simplify the geography
final_dataset_simplified <- rmapshaper::ms_simplify(final_dataset)

# Export final dataset
sf::st_write(final_dataset_simplified, "data/va000_geo_test_2021_tests/distribution/va000_geo_test_2021_tests.geojson")

# Update file manifest
data_file_checksums()
