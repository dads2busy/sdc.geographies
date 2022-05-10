# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
va059_geo_ffxct_gis_2022_human_services_regions <- sf::st_read("data/va059_geo_ffxct_gis_2022_human_services_regions/original/va059_geo_ffxct_gis_2022_human_services_regions.geojson")

# Assign geoid
va059_geo_ffxct_gis_2022_human_services_regions$geoid <- tolower(paste0("51059_hsr_", va059_geo_ffxct_gis_2022_human_services_regions$REGION))

# Assign region_type
va059_geo_ffxct_gis_2022_human_services_regions$region_type <- "Human Service Region"

# Assign region_name
va059_geo_ffxct_gis_2022_human_services_regions$region_name <- as.character(va059_geo_ffxct_gis_2022_human_services_regions$REGION)

# Assign year
va059_geo_ffxct_gis_2022_human_services_regions$year <- "2022"

# measure, measure_type, and value need to be included in non-geo datasets

# Export final
final_data_set <- va059_geo_ffxct_gis_2022_human_services_regions[, c("geoid", "region_name", "region_type", "year", "geometry")]
sf::st_write(final_data_set, "data/va059_geo_ffxct_gis_2022_human_services_regions/distribution/va059_geo_ffxct_gis_2022_human_services_regions.geojson")
