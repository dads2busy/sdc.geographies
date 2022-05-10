# dc.geographies

This repository serves as the authoritative source for all geography files used by the Social Impact Data Commons.


## Structure
Data files, data information files, and data creation code area organized in identical named sets of folders in the /data, /docs, and /src folders, respectively.
For example, the dataset "va059_geo_ffxct_gis_2022_zip_codes" the following folders are maintained:
/data/va059_geo_ffxct_gis_2022_zip_codes
/docs/01data/va059_geo_ffxct_gis_2022_zip_codes
/src/01data/va059_geo_ffxct_gis_2022_zip_codes

The individual dataset folders in the /data folder are further sub-divided into /original, /working, and /distribution.
The files in a dataset's distribution folder are the authoritative files for distribution.  

## File List
A manifest with a list of the latest distribution files, along with md5 checksums, is available at /data/distribution_file_manifest.csv

Current geography files:<br />
[dc_geo_census_cb_2020_census_block_groups.geojson](https://github.com/uva-bi-sdad/dc.geographies/blob/5678fd7955a63af47192f56684437a820e3595db/data/dc_geo_census_cb_2020_census_block_groups/distribution/dc_geo_census_cb_2020_census_block_groups.geojson) <br />
[dc_geo_census_cb_2020_census_tracts.geojson](data/dc_geo_census_cb_2020_census_tracts/distribution/dc_geo_census_cb_2020_census_tracts.geojson)

## New Geography Dataset Creation
1. Create new yaml settings file and place in /src/01_data/00_dataset_yaml_files. For example:
<pre><code>
  ---
  dataset_info:
    dataset_type: "geo"             # geo or data
    data_agency_company_abbrv: "ffxct"
    data_center_program: "gis"
    dataset_general_subject: "Supervisor Districts"
    dataset_sub_subject: ""
    dataset_region_type: "supervisor district"
    dataset_geo_coverage: "va059"
    dataset_geo_level: ""           # if dataset_type = "data"
    dataset_start_year: "2022"
    dataset_end_year: ""
    dataset_source_files:
      - type: "data"
        format: "geojson"
        url: "https://services1.arcgis.com/ioennV6PpG5Xodq0/arcgis/rest/services/OpenData_S1/FeatureServer/17/query?outFields=*&where=1%3D1&f=geojson"
</code></pre>

2. Open /src/01_data/01_set_up_new_datasets.R and add new new_dataset_setup command, and run. This creates a filename all of the folders that will go along with this dataset. For example:
<pre><code>
  # Fairfax County Supervisor Districts Geo
  new_dataset_setup(dataset_info_yml_file_path = "src/01_data/00_dataset_yaml_files/fairfax_county_supervisor_districts_geo.yml",
                    code_files = "R",
                    overwrite = TRUE)
</code></pre>

3. Now go to the folder created for this dataset in /src/01_data/<name of new dataset> and open the first ingest file (01_ingest_file_1.R). There should now be one file for ingest for each source file you listed in the yaml file.

Running the already created code should download the source file and place it in the /data/<name of new dataset>/original folder.

4. Now open the prepared dataset preparation file, 02_prepare.R. 
This file has the basic steps and some of the needed code already prepopolated.

Once finished, you will have a final dataset in /data/<name of new dataset>/distribution.
