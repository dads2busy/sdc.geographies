# dataset creation code - data source ingest - file 1
# source file: https://www2.census.gov/geo/tiger/GENZ2010/gz_2010_51_140_00_500k.zip

# Import source file and save to original for backup
source_file <- "https://www2.census.gov/geo/tiger/GENZ2010/gz_2010_51_140_00_500k.zip"
download.file(source_file, "data/va_geo_census_cb_2010_census_tracts/original/va_geo_census_cb_2010_census_tracts.zip")
