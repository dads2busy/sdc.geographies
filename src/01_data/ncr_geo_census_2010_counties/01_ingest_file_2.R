# dataset creation code - data source ingest - file 2
# source file: data/dc_geo_census_cb_2010_counties/distribution/dc_geo_census_cb_2010_counties.geojson

# Import source file and save to original for backup
source_file <- "data/dc_geo_census_cb_2010_counties/distribution/dc_geo_census_cb_2010_counties.geojson"
file.copy(source_file, "data/ncr_geo_census_2020_counties/original/dc_geo_census_2020_counties.geojson")
