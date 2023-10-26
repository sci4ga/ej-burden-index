# ej-burden-index
This is used to create an environmental justice index designed to be an improvement over the CEJST.

# Downloading and Preparing Data
First step is to load any packages in R that are necessary. We used mostly tidyverse, ggplot, and sf. 

Then upload the CEJST.shp file. This file should be downloaded on your computer and the file path can be set in R.

We then filtered out all of the files not for Georgia using the tidyverse filter function to eliminate uncessary data and make the file easier to process. We viewed the file to make sure it was correct.

# Data Exploration
Next we manipulated the data and created a map to ensure that everything necessary was included.

We started by creating a new dataset which included a new column that was a caculation of the percentage of non-white identifying people within each census track. Since this file was already in the dataset it was used to ensure accuracy within the data. 

We then created a map of this new column using ggplot to test out visualization.

# Creating the New Index
Next we created the dataset which included the data for the new index. This was done by taking the orginal CJEST dataset and adding new columns using the tidyverse mutate function to create a new dataset. 

The first step was creating a column for each bucket in the CJEST file, of which there were 8. This buckets were Climate Change, Energy, Health, Housing, Legacy Pollution, Transportation, Water and Wastewater, and Workforce Development. 

For each of these buckets, the corresponding columns that were used to calculate the 0/1 score were identified.  These columns were added to together and the sum was divided by the number of categories within each bucket to give the percentage of categories that were identified as burdened per census track. These new categories were given arbitrary names to make them easy to work with.

Then for the final new total burdened index score each of the new columns were summed together. This new dataset was then viewed to ensure that all data was calculated correctly.

# Exportation
This data was then exported from R using the st_write function. The first function simply exports an .shp file without any of the supporting file. The second st_write identifies the driver and so also exports the supporting files. For this dataset the driver in ESRI Shapefile.

This step can be difficult. If difficulties arise a R package called 'shapefiles' can be installed which can assist with data exportation.

# List
This step was used to create a list that just contained the census track, county, and the final total burdened index score. 

To create this list, first drop the geometry file the new index using the st_drop_geomtry function, as the data won't export from R as a .csv file with the geometry included. Then the necessary columns were filtered out using the tidyverse select function and arranged to descend most to least burdened. This list was then viewed to ensure correctness and exported using the st_write function. 
