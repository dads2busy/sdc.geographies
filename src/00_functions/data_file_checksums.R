data_file_checksums <- function(dir_path = "data", distribution_files = T, output_path = "data", output_name = "distribution_file_manifest") {
  if (distribution_files) {
    dirs <- list.dirs(dir_path)
    dirs_dist <- dirs[grep(pattern = ".*distribution*", dirs)]
    files_dist <- list.files(dirs_dist, pattern = "(geojson|csv|parquet)$", full.names = T)
    checksums <- tools::md5sum(files_dist)
    # write.csv(data.frame(file = basename(names(checksums)), file_path = names(checksums), md5 = as.character(checksums)),
    #           file.path(output_path, paste0(output_name, ".csv")),
    #           row.names = F)
    jsonlite::write_json(data.frame(file = basename(names(checksums)), file_path = names(checksums), md5 = as.character(checksums)),
                         file.path(output_path, paste0(output_name, ".json")))
  }
}
