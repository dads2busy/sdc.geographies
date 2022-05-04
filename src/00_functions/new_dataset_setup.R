new_dataset_setup <- function(dataset_info_yml_file_path = "src/01_data/00_dataset_yaml_files/fairfax_county_zip_codes_geo.yml",
                              code_files = "R",
                              overwrite = FALSE) {
  dataset_info <- yaml::read_yaml(dataset_info_yml_file_path)$dataset_info
  # data_source_subject_abbrv <- set_data_source_subject_abbrv(dataset_info)
  data_file_basename <- set_data_file_basename(dataset_info)

  dataset_pths <- list(
    ds_orig = list(
      pth = file.path("data", data_file_basename, "original"),
      dsc = "original files unchanged"
    ),
    ds_work = list(
      pth = file.path("data", data_file_basename, "working"),
      dsc = "working/scratch files"
    ),
    ds_dist = list(
      pth = file.path("data", data_file_basename, "distribution"),
      dsc = "final files for distribution"
    ),
    ds_docs = list(
      pth = file.path("docs/01_data", data_file_basename),
      dsc = "dataset source documentation"
    ),
    ds_src_prepare  = list(
      pth = file.path("src/01_data", data_file_basename, paste0("02_prepare.", code_files)),
      dsc = paste0("# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)",
                   "\n\n# Import file from original",

                   "\n", data_file_basename, " <- sf::st_read(\"", file.path("data", data_file_basename, "original", paste0(data_file_basename, ".geojson\"")), ")",
                   "\n\n# Assign geoid\n", data_file_basename, "$geoid <- \"\"",
                   "\n\n# Assign region_type\n", data_file_basename, "$region_type <- \"\"",
                   "\n\n# Assign region_name\n", data_file_basename, "$region_name <- \"\"",
                   "\n\n# measure, measure_type, and value need to be included in non-geo datasets",
                   "\n\n# Export final",
                   "\nfinal_data_set <- ", data_file_basename, "[, c(\"geoid\", \"region_name\", \"region_type\", \"geometry\", ...)]",
                   "\nsf::st_write(final_data_set, \"", file.path("data", data_file_basename, "distribution", paste0(data_file_basename, ".geojson\"")), ")"
                   )
    )
  )

  if (length(dataset_info$dataset_source_files) > 0) {
    for (i in 1:length(dataset_info$dataset_source_files)) {
      dwnld_fld <- dataset_pths$ds_orig$pth
      if (dataset_info$dataset_source_files[[i]]$type == "doc") dwnld_fld <- dataset_pths$ds_docs$pth

      assign(paste0("ds_src_ingest_", i),
             list(
               pth = file.path("src/01_data", data_file_basename, paste0("01_ingest_file_", i, ".", code_files)),
               dsc = paste0("# dataset creation code - data source ingest - file ", i,
                            "\n# source file: ", dataset_info$dataset_source_files[[i]]$url,
                            "\n\n# Import source file and save to original for backup",
                            "\nsource_file <- \"", dataset_info$dataset_source_files[[i]]$url, "\"",
                            "\ndownload.file(source_file, \"", file.path(dwnld_fld, paste0(data_file_basename, ".", dataset_info$dataset_source_files[[i]]$format)), "\")"
                            )
             ))
      dataset_pths[paste0("ds_src_ingest_", i)] <- list(get(paste0("ds_src_ingest_", i)))
    }
  } else {
    assign(paste0("ds_src_ingest_1"),
           list(
             pth = file.path("src/01_data", data_file_basename, paste0("01_ingest_file_1.", code_files)),
             dsc = paste0("# dataset creation code - data source ingest - file 1")
           ))
    dataset_pths[paste0("ds_src_ingest_1")] <- list(get(paste0("ds_src_ingest_1")))
  }

  for (i in 1:length(dataset_pths)) {
    pth <- dataset_pths[[i]]$pth
    if (tools::file_ext(pth) == "") {
      dir.create(pth, recursive = TRUE)
      file.create(file.path(pth, "README"))
      write(dataset_pths[[i]]$dsc, file.path(pth, "README"))
    } else {
      dir.create(dirname(pth), recursive = TRUE)
      if (overwrite == TRUE) {
        file.create(file.path(pth))
        write(dataset_pths[[i]]$dsc, file.path(pth))
      }
    }
  }
}
