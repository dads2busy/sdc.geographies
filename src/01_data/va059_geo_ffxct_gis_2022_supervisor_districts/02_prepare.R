# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
va059_geo_ffxct_gis_2022_supervisor_districts <- sf::st_read("data/va059_geo_ffxct_gis_2022_supervisor_districts/original/va059_geo_ffxct_gis_2022_supervisor_districts.geojson")

# Assign geoid
va059_geo_ffxct_gis_2022_supervisor_districts$geoid <- tolower(paste0("51059_sd_", va059_geo_ffxct_gis_2022_supervisor_districts$DISTRICT))

# Assign region_type
va059_geo_ffxct_gis_2022_supervisor_districts$region_type <- "Supervisor District"

# Assign region_name
va059_geo_ffxct_gis_2022_supervisor_districts$region_name <- va059_geo_ffxct_gis_2022_supervisor_districts$DISTRICT

# Assign year
va059_geo_ffxct_gis_2022_supervisor_districts$year <- "2022"

# measure, measure_type, and value need to be included in non-geo datasets

# Export final
final_dataset <- va059_geo_ffxct_gis_2022_supervisor_districts[, c("geoid", "region_name", "region_type", "year", "geometry")]
sf::st_write(final_dataset, "data/va059_geo_ffxct_gis_2022_supervisor_districts/distribution/va059_geo_ffxct_gis_2022_supervisor_districts.geojson")
