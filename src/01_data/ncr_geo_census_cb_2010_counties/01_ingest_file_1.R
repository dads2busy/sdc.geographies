# dataset creation code - data source ingest - file 1
# source file: data/md_geo_census_cb_2010_counties/distribution/md_geo_census_cb_2010_counties.geojson

# Import source file and save to original for backup
source_file <- "data/us_geo_census_cb_2010_counties/distribution/us_geo_census_cb_2010_counties.geojson"
file.copy(source_file, "data/ncr_geo_census_cb_2010_counties/original/us_geo_census_cb_2010_counties.geojson")
