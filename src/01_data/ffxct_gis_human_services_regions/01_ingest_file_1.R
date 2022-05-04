# dataset creation code - data source ingest - file 1
# source file: https://services1.arcgis.com/ioennV6PpG5Xodq0/ArcGIS/rest/services/OpenData_S2/FeatureServer/12/query?outFields=*&where=1%3D1&f=geojson

# Import source file
source_file <- "https://services1.arcgis.com/ioennV6PpG5Xodq0/ArcGIS/rest/services/OpenData_S2/FeatureServer/12/query?outFields=*&where=1%3D1&f=geojson"
source_file_data <- sf::st_read(source_file)

# Save original file for backup
sf::st_write(source_file_data, "data/ffxct_gis_human_services_regions/original/va059_geo_ffxct_gis_2022_human_services_regions.geojson")
