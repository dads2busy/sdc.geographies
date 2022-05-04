# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)

# Import file from original
va059_geo_ffxct_gis_2022_zip_codes <- sf::st_read("data/ffxct_gis_zip_codes/original/va059_geo_ffxct_gis_2022_zip_codes.geojson")

# Assign geoid
va059_geo_ffxct_gis_2022_zip_codes$geoid <- ""

# Assign region_type
va059_geo_ffxct_gis_2022_zip_codes$region_type <- ""

# Assign region_name
va059_geo_ffxct_gis_2022_zip_codes$region_name <- ""

# measure, measure_type, and value need to be included in non-geo datasets

# Export final
final_data_set <- va059_geo_ffxct_gis_2022_zip_codes[, c("geoid", "region_name", "region_type", "geometry", ...)]
sf::st_write(final_data_set, "data/ffxct_gis_zip_codes/distribution/va059_geo_ffxct_gis_2022_zip_codes.geojson")
