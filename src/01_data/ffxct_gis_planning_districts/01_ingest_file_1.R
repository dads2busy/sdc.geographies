# dataset creation code - data source ingest - file 1
# source file: https://services1.arcgis.com/ioennV6PpG5Xodq0/ArcGIS/rest/services/OpenData_A1/FeatureServer/2/query?outFields=*&where=1%3D1&f=geojson

# Import source file
source_file <- "https://services1.arcgis.com/ioennV6PpG5Xodq0/ArcGIS/rest/services/OpenData_A1/FeatureServer/2/query?outFields=*&where=1%3D1&f=geojson"
va059_geo_ffxct_gis_2022_planning_districts <- sf::st_read(source_file)

# Save original file for backup
sf::st_write(va059_geo_ffxct_gis_2022_planning_districts, "data/ffxct_gis_planning_districts/original/va059_geo_ffxct_gis_2022_planning_districts.geojson")

# Assign geoid
va059_geo_ffxct_gis_2022_planning_districts$geoid <- tolower(paste0("51059_pd_", va059_geo_ffxct_gis_2022_planning_districts$DISTRICT_CODE))

# Assign region_type
va059_geo_ffxct_gis_2022_planning_districts$region_type <- "Planning District"

# Assign region_name
names(va059_geo_ffxct_gis_2022_planning_districts)[names(va059_geo_ffxct_gis_2022_planning_districts) == "DISTNAME"] <- "region_name"
va059_geo_ffxct_gis_2022_planning_districts$region_name <- stringr::str_to_title(va059_geo_ffxct_gis_2022_planning_districts$region_name)

# measure, measure_type, and value need to be included in non-geo datasets

# Export final
final_data_set <- va059_geo_ffxct_gis_2022_planning_districts[, c("geoid", "region_name", "region_type", "geometry")]
sf::st_write(final_data_set, "data/ffxct_gis_planning_districts/distribution/va059_geo_ffxct_gis_2022_planning_districts.geojson")
