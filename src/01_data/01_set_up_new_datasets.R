source(".Rprofile")

# Fairfax County Planning District Geo
new_dataset_setup(dataset_info_yml_file_path = "src/01_data/00_dataset_yaml_files/fairfax_county_planning_district_geo.yml",
                  code_files = "R",
                  overwrite = TRUE)

# Fairfax County Human Services Regions Geo
new_dataset_setup(dataset_info_yml_file_path = "src/01_data/00_dataset_yaml_files/fairfax_county_human_services_regions_geo.yml",
                  code_files = "R",
                  overwrite = TRUE)

# Fairfax County Supervisor Districts Geo
new_dataset_setup(dataset_info_yml_file_path = "src/01_data/00_dataset_yaml_files/fairfax_county_supervisor_districts_geo.yml",
                  code_files = "R",
                  overwrite = TRUE)

# Fairfax County ZIP Codes Geo
new_dataset_setup(dataset_info_yml_file_path = "src/01_data/00_dataset_yaml_files/fairfax_county_zip_codes_geo.yml",
                  code_files = "R",
                  overwrite = TRUE)

# Virginia Census Tracts Geo
new_dataset_setup(dataset_info_yml_file_path = "src/01_data/00_dataset_yaml_files/virginia_census_tracts_geo.yml",
                  code_files = "R",
                  overwrite = TRUE)
