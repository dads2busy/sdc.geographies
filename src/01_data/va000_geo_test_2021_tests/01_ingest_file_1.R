# dataset creation code - data source ingest - file 1
# source file: data/md_geo_census_cb_2010_census_tracts/distribution/md_geo_census_cb_2010_census_tracts.geojson

# Import source file and save to original for backup
source_file <- "data/md_geo_census_cb_2010_census_tracts/distribution/md_geo_census_cb_2010_census_tracts.geojson"
file.copy(source_file, "data/va000_geo_test_2021_tests/original/md_geo_census_cb_2010_census_tracts.geojson")
