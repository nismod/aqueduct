# Aqueduct flood data

Scripts for working with the WRI Aqueduct global open flood dataset. [1]

For country extracts, it can be helpful to use
[Natural Earth boundaries](https://www.naturalearthdata.com/downloads/10m-cultural-vectors/)

For example, to check the boundary of Tanzania, download all country boundaries
and check using the three-letter country code (TZA):

    bash download_boundaries.sh
    python check_bbox.py TZA

For more accurate administrative boundaries at different levels, consider using
the [GADM](https://gadm.org/index.html) dataset.

## Data dictionary

Each hazard map shows inundation depth in meters for either coastal or riverine
floods.

The file names are used to encode the model variables in a structured way:

    inunriver_{climatescenario}_{model}_{year}_{returnperiod}.extension
    inunriver_rcp8p5_00000NorESM1-M_2080_rp01000.tif

    inuncoast_{climatescenario}_{subsidence}_{year}_{returnperiod}_{projection}.extension
    inuncoast_historical_nosub_hist_rp0002_0.pickle

To produce metadata CSVs after downloading data, run

    python generate_metadata_csvs.py

### Coastal flooding

Category | Category Full Name | Options | Description
--- | --- | --- | ---
floodtype | Flood Type | inuncoast | Coastal flood hazard
climatescenario | Climate Scenario | historical | Baseline condition
climatescenario | Climate Scenario | rcp4p5 | Representative Concentration Pathway 4.5 (steady carbon emissions)
climatescenario | Climate Scenario | rcp8p5 | Representative Concentration Pathway 8.5 (rising carbon emissions)
subsidence | Subsidence | nosub | Subsidence not included in projection
subsidence | Subsidence | wtsub | Subsidence included in projection
year | Year | hist | Baseline condition
year | Year | 2030 | 2030
year | Year | 2050 | 2050
year | Year | 2080 | 2080
returnperiod | Return Period | rp0002 | 2-year flood
returnperiod | Return Period | rp0005 | 5-year flood
returnperiod | Return Period | rp0010 | 10-year flood
returnperiod | Return Period | rp0025 | 25-year flood
returnperiod | Return Period | rp0050 | 50-year flood
returnperiod | Return Period | rp0100 | 100-year flood
returnperiod | Return Period | rp0250 | 250-year flood
returnperiod | Return Period | rp0500 | 500-year flood
returnperiod | Return Period | rp1000 | 1000-year flood
projection | Sea level rise scenario (in percentile) | 0 | 95th percentile (default)
projection | Sea level rise scenario (in percentile) | 0_perc_05 | 5th percentile
projection | Sea level rise scenario (in percentile) | 0_perc_50 | 50th percentile


### Riverine flooding

Category | Category Full Name | Options | Description
--- | --- | --- | ---
floodtype | Flood Type | inunriver | Riverine flood hazard
climatescenario | Climate Scenario | historical | Baseline condition/ no climate scenario needed
climatescenario | Climate Scenario | rcp4p5 | Representative Concentration Pathway 4.5 (steady carbon emissions)
climatescenario | Climate Scenario | rcp8p5 | Representative Concentration Pathway 8.5 (rising carbon emissions)
model | global circulation model | 000000000WATCH | Baseline condition
model | global circulation model | 00000NorESM1-M | GCM model: Bjerknes Centre for Climate Research, Norwegian Meteorological Institute
model | global circulation model | 0000GFDL_ESM2M | GCM model: Geophysical Fluid Dynamics Laboratory (NOAA)
model | global circulation model | 0000HadGEM2-ES | GCM model: Met Office Hadley Centre
model | global circulation model | 00IPSL-CM5A-LR | GCM model: Institut Pierre Simon Laplace
model | global circulation model | MIROC-ESM-CHEM | GCM model: Atmosphere and Ocean Research Institute (The University of Tokyo), National Institute for Environmental Studies, and Japan Agency for Marine-Earth Science and Technology
year | Year | hist | Baseline condition
year | Year | 2030 | 2030
year | Year | 2050 | 2050
year | Year | 2080 | 2080
returnperiod | Return Period | rp0002 | 2-year flood
returnperiod | Return Period | rp0005 | 5-year flood
returnperiod | Return Period | rp0010 | 10-year flood
returnperiod | Return Period | rp0025 | 25-year flood
returnperiod | Return Period | rp0050 | 50-year flood
returnperiod | Return Period | rp0100 | 100-year flood
returnperiod | Return Period | rp0250 | 250-year flood
returnperiod | Return Period | rp0500 | 500-year flood
returnperiod | Return Period | rp1000 | 1000-year flood


## References

[1] [World Resources Institute (April 2020) Aqueduct Floods Hazard Maps](https://www.wri.org/resources/data-sets/aqueduct-floods-hazard-maps)
