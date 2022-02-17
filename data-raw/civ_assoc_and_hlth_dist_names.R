library(sf)
library(stringr)
con <- get_db_conn()
  va_013_arl_2020_civic_associations <- st_read(con,c("dc_geographies", "va_013_arl_2020_civic_associations"))
DBI::dbDisconnect(con)

va_013_arl_2020_civic_associations$geoid <- paste0("51013_ca_", str_pad(va_013_arl_2020_civic_associations$OBJECTID, 2, side = "left", pad = "0"))
va_013_arl_2020_civic_assoc_names <- va_013_arl_2020_civic_associations[, c("geoid", "CIVIC")]
va_013_arl_2020_civic_assoc_names$geometry <- NULL
colnames(va_013_arl_2020_civic_assoc_names) <- c("geoid", "region_name")
va_013_arl_2020_civic_assoc_names$region_type <- "neighborhood"

con <- get_db_conn()
  dc_dbWriteTable(con, "dc_geographies", "va_013_arl_2020_civic_assoc_geo_names", va_013_arl_2020_civic_assoc_names)
DBI::dbDisconnect(con)


con <- get_db_conn()
  va_hd_sdad_2021_virginia_health_district_geoids <- st_read(con,c("dc_common", "va_hd_sdad_2021_virginia_health_district_geoids"))
DBI::dbDisconnect(con)
setDT(va_hd_sdad_2021_virginia_health_district_geoids)
va_hd_sdad_2021_virginia_health_district_geoids[, geoid := paste0("51_hd_", str_pad(geoid, 2, side = "left", pad = "0"))]

con <- get_db_conn()
  dc_dbWriteTable(con, "dc_geographies", "va_hd_vdh_2021_health_district_geo_names", va_hd_sdad_2021_virginia_health_district_geoids)
DBI::dbDisconnect(con)
