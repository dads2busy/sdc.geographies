# dataset creation code - data source ingest - file 3
# source file: data/va_geo_census_cb_2010_counties/distribution/va_geo_census_cb_2010_counties.geojson

# Import source file and save to original for backup
source_file <- "data/va_geo_census_cb_2010_census_tracts/distribution/va_geo_census_cb_2010_census_tracts.geojson"
file.copy(source_file, "data/ncr_geo_census_2010_census_tracts/original/va_geo_census_cb_2010_census_tracts.geojson")
