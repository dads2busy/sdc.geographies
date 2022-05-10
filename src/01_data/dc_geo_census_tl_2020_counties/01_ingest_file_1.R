# dataset creation code - data source ingest - file 1
# source file: https://www2.census.gov/geo/tiger/TIGER2020/COUNTY/tl_2020_us_county.zip

# Import source file and save to original for backup
source_file <- "https://www2.census.gov/geo/tiger/TIGER2020/COUNTY/tl_2020_us_county.zip"
download.file(source_file, "data/dc_geo_census_tl_2020_counties/original/dc_geo_census_tl_2020_counties.zip")
