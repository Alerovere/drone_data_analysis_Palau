# Analysis of drone Digital Surface models and Orthomosaics
This repository contains the scripts used in the following paper:
> Casella et al., in prep. Drones and structure from motion photogrammetry on coral reef: what is the error of the reconstructed digital height of corals?

The repository is composed of different folders, described hereafter.

## 1. Comparison_IM
This folder contains the Jupyter notebook and the data used to produce the following figure.
![Alt text](Comparison_IM/Indep_meas_comparison.svg?raw=true "Title")

## 2. QGIS_processing
This folder contains the processing toolbox and example data used to extract 2d and 3d rugosity profiles from drone-derived Digital Surface Models.
The tool was tested in QGIS 3.16 Grass 7.8.4, and needs SAGA to be installed.
--Instructions--
1. Load a line file (transect) and a raster, both in the same UTM projection (meters)
2. Go to Processing >> Graphical Modeler and load the "2d_3d_roughness_QGIS.model3" file.
3. Select the transect file for which you want to extract 2d and 3d profiles and run the processing script.
