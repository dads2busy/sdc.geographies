new_dataset_setup <- function(dataset_info_yml_file_path = "src/01_data/00_new_dataset_setup/fairfax_county_planning_district_geo.yml",
                              code_files = "R",
                              overwrite = FALSE) {
  dataset_info <- yaml::read_yaml(dataset_info_yml_file_path)$dataset_info
  data_source_subject_abbrv <- set_data_source_subject_abbrv(dataset_info)

  dataset_pths <- list(
    ds_orig = list(
      pth = file.path("data", data_source_subject_abbrv, "original"),
      dsc = "original files unchanged"
    ),
    ds_work = list(
      pth = file.path("data", data_source_subject_abbrv, "working"),
      dsc = "working/scratch files"
    ),
    ds_dist = list(
      pth = file.path("data", data_source_subject_abbrv, "distribution"),
      dsc = "final files for distribution"
    ),
    ds_docs = list(
      pth = file.path("docs/01_data", data_source_subject_abbrv),
      dsc = "dataset source documentation"
    ),
    ds_src_prepare  = list(
      pth = file.path("src/01_data", data_source_subject_abbrv, paste0("02_prepare.", code_files)),
      dsc = "# dataset creation code - dataset preparation (transformation, new variables, linkage, etc)"
    )
  )

  if (length(dataset_info$dataset_source_files) > 0) {
    for (i in 1:length(dataset_info$dataset_source_files)) {
      assign(paste0("ds_src_ingest_", i),
             list(
               pth = file.path("src/01_data", data_source_subject_abbrv, paste0("01_ingest_file_", i, ".", code_files)),
               dsc = paste0("# dataset creation code - data source ingest - file ", i,
                            "\n# source file: ", dataset_info$dataset_source_files[i],
                            "\n\n# Import source file",
                            "\nsource_file <- \"", dataset_info$dataset_source_files[i], "\"",
                            "\n", set_data_file_basename(dataset_info), " <- sf::st_read(source_file)",
                            "\n\n# Save original file for backup",
                            "\nsf::st_write(", set_data_file_basename(dataset_info), ", \"", file.path(dataset_pths$ds_orig$pth, paste0(set_data_file_basename(dataset_info), ".geojson\"")), ")",
                            "\n\n# Assign geoid\n", set_data_file_basename(dataset_info), "$geoid <- \"\"",
                            "\n\n# Assign region_type\n", set_data_file_basename(dataset_info), "$region_type <- \"\"",
                            "\n\n# Assign region_name\n", set_data_file_basename(dataset_info), "$region_name <- \"\"",
                            "\n\n# measure, measure_type, and value need to be included in non-geo datasets",
                            "\n\n# Export final",
                            "\nfinal_data_set <- ", set_data_file_basename(dataset_info), "[, c(\"geoid\", \"region_name\", \"region_type\", \"geometry\", ...)]",
                            "\nsf::st_write(final_data_set, \"", file.path(dataset_pths$ds_dist$pth, paste0(set_data_file_basename(dataset_info), ".geojson\"")), ")"
                            )
             ))
      dataset_pths[paste0("ds_src_ingest_", i)] <- list(get(paste0("ds_src_ingest_", i)))
    }
  } else {
    assign(paste0("ds_src_ingest_1"),
           list(
             pth = file.path("src/01_data", data_source_subject_abbrv, paste0("01_ingest_file_1.", code_files)),
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
