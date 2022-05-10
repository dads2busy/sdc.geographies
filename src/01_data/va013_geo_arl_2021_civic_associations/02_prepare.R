# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
va013_geo_arl_2021_civic_associations <- sf::st_read("data/va013_geo_arl_2021_civic_associations/original/va013_geo_arl_2021_civic_associations.geojson")

# Assign geoid
va013_geo_arl_2021_civic_associations$geoid <- paste0("51013_ca_", stringr::str_pad(va013_geo_arl_2021_civic_associations$OBJECTID, 2, side = "left", pad = "0"))

# Assign region_type
va013_geo_arl_2021_civic_associations$region_type <- "civic association"

# Assign region_name
va013_geo_arl_2021_civic_associations$region_name <- va013_geo_arl_2021_civic_associations$CIVIC

# Assign year
va013_geo_arl_2021_civic_associations$year <- "2021"

# measure, measure_type, and value need to be included in non-geo datasets

# Export final
final_dataset <- va013_geo_arl_2021_civic_associations[, c("geoid", "region_name", "region_type", "year", "geometry")]
sf::st_write(final_dataset, "data/va013_geo_arl_2021_civic_associations/distribution/va013_geo_arl_2021_civic_associations.geojson")
