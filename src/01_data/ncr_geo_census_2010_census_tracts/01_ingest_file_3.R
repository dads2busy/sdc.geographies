# dataset creation code - data source ingest - file 3
# source file: data/va_geo_census_cb_2010_census_tracts/distribution/va_geo_census_cb_2010_census_tracts.geojson

# Import source file and save to original for backup
source_file <- "data/va_geo_census_cb_2010_census_tracts/distribution/va_geo_census_cb_2010_census_tracts.geojson"
download.file(source_file, "data/ncr_geo_census_2010_census_tracts/original/ncr_geo_census_2010_census_tracts.geojson")
