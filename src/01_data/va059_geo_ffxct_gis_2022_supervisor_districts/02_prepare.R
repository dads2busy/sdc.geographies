# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
va059_geo_ffxct_gis_2022_supervisor_districts <- sf::st_read("data/va059_geo_ffxct_gis_2022_supervisor_districts/original/va059_geo_ffxct_gis_2022_supervisor_districts.geojson")

# Assign geoid
va059_geo_ffxct_gis_2022_supervisor_districts$geoid <- ""

# Assign region_type
va059_geo_ffxct_gis_2022_supervisor_districts$region_type <- ""

# Assign region_name
va059_geo_ffxct_gis_2022_supervisor_districts$region_name <- ""

# Assign year
va059_geo_ffxct_gis_2022_supervisor_districts$year <- "2022"

# measure, measure_type, and value need to be included in non-geo datasets

# Export final
final_data_set <- va059_geo_ffxct_gis_2022_supervisor_districts[, c("geoid", "region_name", "region_type", "year", "geometry", ...)]
sf::st_write(final_data_set, "data/va059_geo_ffxct_gis_2022_supervisor_districts/distribution/va059_geo_ffxct_gis_2022_supervisor_districts.geojson")
